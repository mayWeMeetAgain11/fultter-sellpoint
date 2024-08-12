import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/features/home/data/models/category_model.dart';
import 'package:selling_point_app/features/loginAndStart/data/models/login_model/data.dart';
import 'package:selling_point_app/features/loginAndStart/data/models/login_model/login_model.dart';
import 'package:selling_point_app/features/loginAndStart/data/repos/login_repo.dart';
import 'package:sqflite/sqflite.dart';
part 'login_and_start_state.dart';

class LoginAndStartCubit extends Cubit<LoginAndStartState> {
  LoginAndStartCubit(this.loginRepo) : super(LoginAndStartInitial());
  final LoginRepo loginRepo;
  static LoginAndStartCubit get(context) => BlocProvider.of(context);
  /*--------------------OUR VARIABLE-------------------------*/

  // List<CategoryModel> activeCategory = [];
  bool visibality = true;
  Icon passIcon = const Icon(Icons.remove_red_eye);
  LoginModel sellPointInfo = LoginModel(
    data: Data(
      id: null,
      driverId: null,
      managerId: null,
      name: null,
      password: null,
      promoterId: null,
      schoolId: null,
      user: null,
    ),
    token: null,
  );
  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  // late Database database;

  //-----------------------------------------------------------

  // ---------- Api methods ----------------

  Future<void> setLang(key, String value) async {
    await CasheHelper.setData(key: key, value: value);
    emit(SuccessLoginAndStartState());
  }

  Future<void> loginAccounting(Map<String, dynamic> data) async {
    emit(LoadingLoginAndStartState());
    var result = await loginRepo.postLoginSellPoint(data);
    result.fold((failure) {
      // emit(FailureLoginAndStartState('error in inputs'));
      emit(FailureLoginAndStartState(failure.errMassage));
    }, (logininfo) {
      sellPointInfo = logininfo;
      // print(success.data!.result!.type);
      emit(SuccessSignUpState(logininfo));
    });
  }
  // --------------------------------------

  void changePassVisibility() {
    visibality = !visibality;
    passIcon = (visibality)
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off);

    emit(LoginAndStartInitial());
  }

  // ---------- SQFLITE FUNCTION --------------
  // void createDataBase() {
  //   openDatabase(
  //     'category.db',
  //     version: 1,
  //     onCreate: (db, version) async {
  //       print('Database Created');
  //       await db
  //           .execute(
  //         'CREATE TABLE category (id INTEGER , name_ar TEXT , name_en TEXT  , price DOUBLE , type TEXT , school_type TEXT ,source TEXT ,photo TEXT )',
  //       )
  //           .then((value) {
  //         print('table created');
  //       }).catchError((error) {
  //         print('error when creating table ${error.toString()}');
  //       });
  //     },
  //     onOpen: (db) {
  //       // here we should call get method from locall database
  //       print('database opened');
  //     },
  //   ).then((value) {
  //     database = value;
  //     emit(AppCreatDatabaseState());
  //   });
  // }
  // Future<void> insertToDatabase(CategoryModel cat) async {
  //   await database.transaction((txn) async {
  //     double price = double.parse(cat.price.toString());
  //     txn
  //         .rawInsert(
  //       'INSERT INTO category (id,name_ar,name_en,price,type,school_type,source,photo ) VALUES ("${cat.id}" , "${cat.nameAr}" , "${cat.nameEn}" ,"$price" , "${cat.type}" , "${cat.schoolType}" , "${cat.source}" ,"${cat.photo}" )',
  //     )
  //         .then((value) async {
  //       print('${value} insert successfully');
  //       // emit(AppinseartDatabaseState());
  //       // here we should call method for get data from database
  //       // getDataFromDatabase();
  //     }).catchError((Error) {
  //       print('error when inseting new record ${Error}');
  //     });
  //   });
  // }
  // Future<void> deleteDatabase({required int id}) async {
  //   database
  //       .rawDelete('DELETE FROM category WHERE id = ? ', [id]).then((value) {
  //     print('delete item , id : $id , $value');
  //     // here should call method get data base
  //   }).catchError((Error) {
  //     print('there is an error $Error');
  //   });
  // }
  // // example for update
  // // Future<void> updateDatabase(dynamic data) async {
  // //  database.rawUpdate(
  // //       'UPDATE taskes SET status = ? WHERE id = ?', ['$status', id]).then(
  // //     (value) {
  // //     // here we should call method get data base
  // //     },
  // //   );
  // // }
  // Future<void> getDataFromDatabase() async {
  //   // here we should make our array or anouther
  //   // data type empty to assigned new data from database
  //   activeCategory = [];
  //   emit(AppGetDatabaseLoadingState());
  //   await database.rawQuery('SELECT * FROM category').then((value) {
  //     // here we can fellter the result and assign to our dataType
  //     // print('-----------------------------------------------------------');
  //     // print('                                                            ');
  //     // print(value);
  //     // print('                                                            ');
  //     // print('-----------------------------------------------------------');
  //     value.forEach(
  //       (element) {
  //         // print(element);
  //         // print(
  //         //     '---------------------------------------------------------------');
  //         activeCategory.add(CategoryModel.fromJson(element));
  //       },
  //     );
  //     emit(AppSuccessGetDatabaseState());
  //     print(activeCategory.length);
  //   }).catchError(
  //     (Error) {
  //       print('there is an error in get method $Error');
  //       emit(AppFailureGetDatabaseState());
  //     },
  //   );
  // }
}
