import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/features/home/data/repos/home_repo.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/models/category_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this.homeRepo) : super(HomePageInitial());
  final HomeRepo homeRepo;
  static HomePageCubit get(context) => BlocProvider.of(context);
  /*--------------------OUR VARIABLE-------------------------*/
  List<CategoryModel> activeCategory = [];
  late Database database;
  //-----------------------------------------------------------

  //----------------------- api method ------------------------
  Future<void> fetchActiveCategory() async {
    emit(LoadingfetchActiveCatState());
    var result = await homeRepo.getActiveCategory();
    result.fold((failure) {
      // CasheHelper.setData(key: Constants.kstartDay, value: false);

      emit(FailureHomePageState(failure.errMassage));
    }, (activeCategory) async {
      /*
     The following line makes the transition from the 
     splashView Page to the HomePage certain because the
     user pressed the StartDayButton And data was fetched
     correctly
     */
      await deleteDatabase();
      CasheHelper.setData(key: Constants.kstartDay, value: false);
      CasheHelper.setData(key: Constants.kfirstTime, value: false);
      CasheHelper.setData(key: Constants.kfirstOrderFActory, value: false);
      CasheHelper.setData(key: Constants.kfirstOrderSp, value: false);
      for (var element in activeCategory) {
        await insertToDatabase(element);
      }
      emit(SuccessLoginAndStartState());
      await getDataFromDatabase(database);
    });
  }

  // Future<void> checkForUpdateCAtegory() async {
  //   emit(LoadingfetchActiveCatState());
  //   var result = await homeRepo.checkForCAtegory();
  //   result.fold(
  //     (failure) {
  //       emit(FailureHomePageState(failure.errMassage));
  //     },
  //     (check) async {
  //       if (check) {
  //         await deleteDatabase();
  //         await fetchActiveCategory();
  //       } else {
  //         CasheHelper.setData(key: Constants.kstartDay, value: false);
  //         CasheHelper.setData(key: Constants.kfirstOrderFActory, value: false);
  //         CasheHelper.setData(key: Constants.kfirstOrderSp, value: false);
  //         emit(SuccessLoginAndStartState());
  //         // getDataFromDatabase(database);
  //         print('all righte');
  //       }
  //     },
  //   );
  // }

  //-----------------------------------------------------------

  //----------------------- SqfLite methods -------------------
  void createDataBase() {
    openDatabase(
      'category.db',
      version: 1,
      onCreate: (db, version) async {
        print('Database Created');
        await db
            .execute(
          'CREATE TABLE category (id INTEGER , name_ar TEXT , name_en TEXT  , price DOUBLE , type TEXT , school_type TEXT ,source TEXT ,photo TEXT )',
        )
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (db) {
        // here we should call get method from locall database
        getDataFromDatabase(db);
        print('database opened');
        // print(CasheHelper.getData(key: Constants.ktoken));
      },
    ).then((value) {
      database = value;
      emit(AppCreatDatabaseState());
    });
  }

  Future<void> insertToDatabase(CategoryModel cat) async {
    if (cat.type == 'store') {
      await database.transaction((txn) async {
        double price = double.parse(cat.price.toString());
        txn
            .rawInsert(
          'INSERT INTO category (id,name_ar,name_en,price,type,school_type,source,photo ) VALUES ("${cat.id}" , "${cat.nameAr}" , "${cat.nameEn}" ,"$price" , "${cat.type}" , "${cat.schoolType}" , "${cat.source}" ,"${cat.photo}" )',
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
  }

  // example for update
  // Future<void> updateDatabase(dynamic data) async {
  //  database.rawUpdate(
  //       'UPDATE taskes SET status = ? WHERE id = ?', ['$status', id]).then(
  //     (value) {
  //     // here we should call method get data base
  //     },
  //   );
  // }

  Future<void> getDataFromDatabase(db) async {
    // here we should make our array or anouther
    // data type empty to assigned new data from database
    activeCategory = [];
    emit(AppGetDatabaseLoadingState());
    await db.rawQuery('SELECT * FROM category').then((value) {
      // here we can fellter the result and assign to our dataType

      // print('-----------------------------------------------------------');
      // print('                                                            ');

      // print(value);

      // print('                                                            ');
      // print('-----------------------------------------------------------');

      value.forEach(
        (element) {
          // print(element);
          // print(
          //     '---------------------------------------------------------------');
          activeCategory.add(CategoryModel.fromJson(element));
        },
      );
      emit(AppSuccessGetDatabaseState());
      print(activeCategory.length);
    }).catchError(
      (Error) {
        print('there is an error in get method $Error');
        emit(AppFailureGetDatabaseState());
      },
    );
  }

  Future<void> deleteDatabase() async {
    database.rawDelete('DELETE FROM category').then((value) {
      print('delete successfuly : $value');
      // here should call method get data base
    }).catchError((Error) {
      print('there is an error $Error');
    });
  }
  
  
  //-----------------------------------------------------------
}
