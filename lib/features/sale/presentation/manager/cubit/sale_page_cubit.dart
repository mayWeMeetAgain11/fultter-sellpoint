import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/left_side_of_order_pages.dart';
import 'package:selling_point_app/features/sale/data/models/student_model.dart';
import 'package:selling_point_app/features/sale/data/models/students_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../core/cache/cashe_helper.dart';
import '../../../data/repos/sale_repo.dart';
import '../../views/widgets/left_side_of_sale_page.dart';

part 'sale_page_state.dart';

class SalePageCubit extends Cubit<SalePageState> {
  SalePageCubit(this.saleRepo) : super(SalePageInitial());
  final SaleRepo saleRepo;
  static SalePageCubit get(context) => BlocProvider.of(context);

  /*--------------------OUR VARIABLE-------------------------*/
  Map<int, SelectedItem> selectedItem = {};
  double total = 0;
  List<Map<String, dynamic>> orders = [];
  List<Map<String, dynamic>> students = [];

  // SelectedItem(title: 'sheesh',price: 200,quantity: 20),
  // SelectedItem(title: 'sheesh',price: 200,quantity: 20),
  // SelectedItem(title: 'sheesh',price: 200,quantity: 20),
  List<TextEditingController> cardController = [];
  List<int> cardCounter = [];

  TextEditingController chargeController = TextEditingController(text: '');
  bool isChoosen = false;

  ScrollController scrollController = ScrollController();
  scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  List<StudentModel> allStudents = [];

  StudentModel student = StudentModel(balance: 0.0, threshold: 0.0);
  StudentModels studentOffline =
      StudentModels(balance: 0.0, threshold: 0.0, totalPrice: 0.0);
  late Database database2;
  // String lang = 'en';
  //-----------------------------------------------------------

  // ------------------------ Api methods ---------------------
  Future<void> fetchOneStudent(String id) async {
    emit(LoadingSaleFetchStudentState());
    var result = await saleRepo.getStudent(id);
    result.fold((failure) {
      emit(FailureSaleFetchStudentState(failure.errMassage));
    }, (student) async {
      isChoosen = true;
      studentOffline =
          StudentModels(balance: 0.0, threshold: 0.0, totalPrice: 0.0);
      this.student = student;
      emit(SuccessSaleFetchStudent());
    });
  }

  Future<void> fetchAllStudens() async {
    emit(LoadingFetchAllStudent());
    var result = await saleRepo.getAllStudents();
    result.fold((failure) {
      emit(FailureFetchAllStudentState(failure.errMassage));
    }, (student) async {
      for (var element in student) {
        await insertStudentsToDatabase(element);
        // deleteDatabase(id: element.id!);
      }
      CasheHelper.setData(key: Constants.kfetchedStudent, value: true);

      emit(SuccessSaleFetchAllStudent());
    });
  }

  Future<void> postBillOnline(
    Map<String, dynamic> data,
  ) async {
    emit(LoadingSaleOrder());
    var result = await saleRepo.postBillSaleStudentOnline(data);
    result.fold((failure) {
      total = 0;
      emit(FailureSaleOrder(failure.errMassage));
    }, (success) {
      emit(SuccessSaleOrder());
    });
  }

  Future<void> postBillOffline(
    Map<String, dynamic> data,
  ) async {
    emit(LoadingFetchAllStudent());
    var result = await saleRepo.postAllBillSaleStudentOffline(data);
    result.fold(
      (failure) {
        emit(FailureFetchAllStudentState('error'));
      },
      (success) {
        print('suceessssssssssss offline');
        CasheHelper.setData(key: Constants.kfetchedStudent, value: false);
        student = StudentModel(balance: 0.0, threshold: 0.0);
        orders = [];
        students = [];
        deleteStudentsAndOrdersTablesFromDatabase();
        emit(SuccessSaleFetchStudent());
      },
    );
  }

  Future<void> postStudentCardCharge(
    Map<String, dynamic> data,
  ) async {
    emit(LoadingCardCharge());
    var result = await saleRepo.postCardCharge(data);
    result.fold(
      (failure) {
        chargeController.clear();
        emit(FailureCardCharge(failure.errMassage));
      },
      (success) {
        chargeController.clear();
        fetchOneStudent(student.id.toString());
        emit(SuccessCardCharge());
      },
    );
  }

  // ----------------------------------------------------------
  void decreaseCounter(int index) {
    if (cardCounter[index] != 0) {
      cardCounter[index]--;
      cardController[index].text = cardCounter[index].toString();
      emit(SalePageInitial());
    }
  }

  void increaseCounter(int index) {
    cardCounter[index]++;
    cardController[index].text = cardCounter[index].toString();
    emit(SalePageInitial());
  }

  void onTapCounterChange(index) {
    if (cardController[index].text == '0') {
      cardController[index].clear();
    }
    emit(SalePageInitial());
  }

  void onChangedCounter(index, String value) {
    if (value.isEmpty) {
      cardCounter[index] = 0;
    } else {
      cardCounter[index] = int.parse(cardController[index].text);
    }
    emit(SalePageInitial());
  }

  void addToSelectedItem(index, String itemName, double price, int id) {
    total += cardCounter[index] * price;

    selectedItem.update(
      index,
      (value) {
        return SelectedItem(
            title: itemName,
            price: (cardCounter[index] * price) + value.price,
            quantity: cardCounter[index] + value.quantity!,
            id: id);
      },
      ifAbsent: () => SelectedItem(
          title: itemName,
          price: cardCounter[index] * price,
          quantity: cardCounter[index],
          id: id),
    );
    cardCounter[index] = 1;
    cardController[index].text = '1';
    scrollToBottom();
    emit(SalePageInitial());
  }

  void deleteFromSelectedItem(index) {
    // print('llllllllllllllll $index');
    double price = double.parse(selectedItem[index]!.price.toString());
    total -= price;
    selectedItem.remove(index);
    emit(SalePageInitial());
  }

  void backToPrevious(context) {
    selectedItem.clear();
    cardController.clear();
    cardCounter.clear();
    total = 0;
    studentOffline =
        StudentModels(balance: 0.0, threshold: 0.0, totalPrice: 0.0);
    student = StudentModel(balance: 0.0, threshold: 0.0);
    Navigator.pop(context);
  }

  void interToSalePages() {
    emit(SalePageInitial());
  }

  // ----------------- SqfLite Methods --------------------
  void createDataBase() {
    openDatabase(
      'category2.db',
      version: 1,
      onCreate: (db, version) async {
        print('Database Created');
        await db
            .execute(
          'CREATE TABLE students(id INTEGER , first_name TEXT NULLABLE ,mid_name TEXT NULLABLE,last_name TEXT NULLABLE , threshold DOUBLE , balance DOUBLE , school_id INEGER ,total_price DOUBLE, purchase BOOLEAN DEFAULT false)',
        )
            .then((value) {
          print('new table created - student table-');
        }).catchError((error) {
          print('error when creating table ${error.toString()}');
        });

        await db
            .execute(
          'CREATE TABLE orders(amount INTEGER , total_price DOUBLE , unit_price DOUBLE , category_id INTEGER , student_id INTEGER , date DATETIME )',
        )
            .then((value) {
          print('new table created - orders -');
        }).catchError((error) {
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (db) {
        // here we should call get method from locall database
        // getDataFromDatabase(db);
        print('database opened');
        // print(CasheHelper.getData(key: Constants.ktoken));
      },
    ).then((value) {
      database2 = value;
      // emit(AppCreatDatabaseState());
    });
  }

  Future<void> insertStudentsToDatabase(StudentModels student) async {
    await database2.transaction((txn) async {
      double threshold = double.parse(student.threshold.toString());
      double balance = double.parse(student.balance.toString());
      var totalPrice = threshold - student.totalPrice;
      txn
          .rawInsert(
        'INSERT INTO students (id,first_name,mid_name,last_name,threshold,balance,school_id,total_price  ) VALUES ("${student.id}" , "${student.firstName}" , "${student.midName}" ,"${student.lastName}"  , "$threshold" , "$balance" ,"${student.schoolId}" , "$totalPrice" )',
      )
          .then((value) async {
        print('${value} insert successfully');
        // emit(AppinseartDatabaseState());
        // here we should call method for get data from database
        // getDataFromDatabase();
      }).catchError((Error) {
        print('error when inseting new record ${Error}');
      });
    });
  }

  Future<void> updateStudentsDatabase(
      double balance, int id, double totalPrice) async {
    database2.rawUpdate(
        'UPDATE students SET balance = ? , purchase = ? , total_price = ? WHERE id = ? ',
        [balance, true, totalPrice, id]).then(
      (value) async {
        // here we should call method get data base
        print('update student info success $value');
        await getStudentFromDatabase(database2, id.toString());
        total = 0;
        // selectedItem.clear();
      },
    );
  }

  Future<void> getStudentFromDatabase(db, String studentId) async {
    // here we should make our array or anouther
    // data type empty to assigned new data from database
    int id = int.parse(studentId);
    emit(LoadingSaleFetchStudentState());
    await db.rawQuery('SELECT * FROM students WHERE id = $id').then((value) {
      // here we can fellter the result and assign to our dataType

      print('-----------------------------------------------------------');
      print('                                                            ');
      student = StudentModel(balance: 0.0, threshold: 0.0);
      studentOffline = StudentModels.fromJson(value[0]);
      print(studentOffline.balance);
      print(value[0]);

      print('                                                            ');
      print('-----------------------------------------------------------');

      emit(SuccessSaleFetchStudent());
    }).catchError(
      (Error) {
        print('there is an error in get method $Error');
        emit(FailureSaleFetchStudentState('error'));
      },
    );
  }

  Future<void> deleteStudentsAndOrdersTablesFromDatabase() async {
    database2.rawDelete('DELETE FROM students ').then((value) {
      print('delete all data of students table successfuly $value');
      // here should call method get data base
    }).catchError((Error) {
      print('there is an error $Error');
    });

    database2.rawDelete('DELETE FROM orders ').then((value) {
      print('delete all data of order table successfuly $value');
      // here should call method get data base
    }).catchError((Error) {
      print('there is an error $Error');
    });
  }

  Future<void> insertOrderToDatabase(
      Database db, SelectedItem item, int studentID, String dateTime) async {
    await db.transaction((txn) async {
      emit(LoadingSaleFetchStudentState());
      double totalPrice = item.price * item.quantity;
      txn
          .rawInsert(
        'INSERT INTO orders (amount,total_price,unit_price,category_id,student_id,date ) VALUES ("${item.quantity}" , "$totalPrice" , "${item.price}" ,"${item.id}"  , "$studentID" , "$dateTime"  )',
      )
          .then((value) async {
        print('${value} insert successfully');
        // emit(AppinseartDatabaseState());
        // here we should call method for get data from database
        // getDataFromDatabase();
      }).catchError((Error) {
        print('error when inseting new record ${Error}');
      });
    });
  }

  Future<void> getAllOrdersFromDatabase(db) async {
    // here we should make our array or anouther
    // data type empty to assigned new data from database
    emit(LoadingFetchAllStudent());
    await db.rawQuery('SELECT * FROM orders').then((value) {
      // here we can fellter the result and assign to our dataType

      print('-----------------------------------------------------------');
      print('                                                            ');
      print(value);
      print('                                                            ');
      print('-----------------------------------------------------------');
      orders = value;
      // return value;
    }).catchError(
      (Error) {
        print('there is an error in get method $Error');
        emit(FailureFetchAllStudentState('error'));
      },
    );
  }

  Future<void> getAllStudentFromDatabase(db) async {
    emit(LoadingFetchAllStudent());
    await db
        .rawQuery('SELECT id , balance FROM students WHERE purchase = 1')
        .then((value) {
      // here we can fellter the result and assign to our dataType

      print('-----------------------------------------------------------');
      print('                                                            ');
      print(value);
      print('                                                            ');
      print('-----------------------------------------------------------');
      students = value;
    }).catchError(
      (Error) {
        print('there is an error in get method $Error');
        emit(FailureFetchAllStudentState('error'));
      },
    );
  }
}
