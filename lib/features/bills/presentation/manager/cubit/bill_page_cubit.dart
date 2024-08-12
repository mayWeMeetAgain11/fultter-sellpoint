import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/features/bills/data/models/all_bills_model/all_bills_model.dart';
import 'package:selling_point_app/features/bills/data/models/all_bills_model/bills_to_sell_point.dart';
import 'package:selling_point_app/features/bills/data/repos/bills_repo.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/left_side_of_order_pages.dart';
import '../../../../home/data/models/category_model.dart';
import '../../../data/models/all_bills_model/bills_to_factory.dart';
import '../../../data/models/bills_orderd_from_me/bills_orderd_from_me.dart';
import '../../../data/models/factory_bills_model/factory_bills_model.dart';
import '../../../data/models/sell_point.dart';
import '../../../data/models/sp_bills_model/sp_bills_model.dart';
part 'bill_page_state.dart';

class BillPageCubit extends Cubit<BillPageState> {
  BillPageCubit(this.billsRepo) : super(BillPageInitial());
  static BillPageCubit get(context) => BlocProvider.of(context);
  final BillsRepo billsRepo;
  /*--------------------OUR VARIABLE-------------------------*/
  Map<int, SelectedItem> selectedItem = {};
  double total = 0;
  Map<String, List<Map<String, int>>> billTOSend = {'bills': []};
  // SelectedItem(title: 'sheesh',price: 200,quantity: 20),
  // SelectedItem(title: 'sheesh',price: 200,quantity: 20),
  // SelectedItem(title: 'sheesh',price: 200,quantity: 20),
  List<TextEditingController> cardController = [];
  List<int> cardCounter = [];

  ScrollController scrollController = ScrollController();
  scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  TextEditingController search = TextEditingController();
  AllBillsModel allBills = AllBillsModel(
    billsToFactory: [],
    billsToSellPoint: [],
  );

  List<CategoryModel> activeCategory = [];
  List<CategoryModel> currentActiveCategory = [];
  List<CategoryModel> activeCategoryRaw = [];
  List<CategoryModel> currentActiveCategoryRaw = [];
  // bool isStore = false;

  Map<int, List<FactoryBillsModel>> detailsOfFActoryBill = {};
  Map<int, List<SpBillsModel>> detailsOfSpBill = {};

  List<BillsOrderdFromMe> billsOrderFromMe = [];
  List<SellPoint> allSellPoints = [];
  List<SellPoint> currentAllSellPoints = [];
  SellPoint selectedSellPoint = SellPoint();
  CancelToken cancelToken = CancelToken();
  DateTime dateForOrder = DateTime.now();
  DateTime dateForOrderFromSp = DateTime.now();

  //-----------------------------------------------------------

  //------------------------ Api methods ----------------------
  Future<void> fetchAllBills() async {
    emit(LoadingBillState());
    var result = await billsRepo.getAllBills();
    result.fold((failure) {
      print('FailureBillState 555');
      emit(FailureBillState(failure.errMassage));
    }, (data) {
      allBills = data;
      emit(SuccessToFactoryBillState(allBills.billsToFactory!));
    });
  }

  Future<void> fetchAllBills2() async {
    emit(LoadingBillState());
    var result = await billsRepo.getAllBills();
    result.fold((failure) {
      print('FailureBillState 555');
      emit(FailureBillState(failure.errMassage));
    }, (data) {
      allBills = data;
      emit(SuccessToSpBillState(allBills.billsToSellPoint!));
    });
  }

  Future<void> fetchFactoryBill(int billID, int index) async {
    emit(LoadingGetSingleBillState());
    var result = await billsRepo.getFactoryBills(billID);
    result.fold((failure) {
      print('get single factory bill error');
      emit(FailureBillState(failure.errMassage));
    }, (data) {
      detailsOfFActoryBill[index] = data;
      emit(SuccessToFactoryBillState(allBills.billsToFactory!));
    });
  }

  Future<void> fetchSpBill(int billID, int index) async {
    emit(LoadingGetSingleBillState());
    var result = await billsRepo.getSpBills(billID);
    result.fold((failure) {
      print('get single SP bill error');
      emit(FailureBillState(failure.errMassage));
    }, (data) {
      detailsOfSpBill[index] = data;
      emit(SuccessToSpBillState(allBills.billsToSellPoint!));
    });
  }

  Future<void> fetchBillFromMe() async {
    emit(LoadingBillState());
    var result = await billsRepo.getBillsOrderFromMe();
    result.fold((failure) {
      print('get orderd from me error');
      emit(FailureBillState(failure.errMassage));
    }, (data) {
      billsOrderFromMe = data;
      emit(SuccessGetBillFromMe());
    });
  }

  Future<void> postBillToFActory(
    Map<String, dynamic> data
  ) async {
    emit(LoadingPostToFactoryBillState());
    var result = await billsRepo.postBillToFactory(data);
    result.fold((failure) {
      
      emit(FailurePostData(failure.errMassage));
    }, (success) async {
      total = 0;
      // if (data['type'] == 'default') {
      //   print('true, type == default');
      //   // await CasheHelper.setData(key: Constants.kIsOrdered, value: true);
      // }
      emit(SuccessPostBill());
    });
  }

  Future<void> postBillToSP(
    int sellPointId,
    Map<String, dynamic> data
  ) async {
    emit(LoadingPostToSpBillState());
    var result = await billsRepo.postBillToSp(sellPointId, data);
    result.fold((failure) {
      emit(FailurePostData(failure.errMassage));
    }, (success) {
      total = 0;
      emit(SuccessPostBill());
    });
  }

  Future<void> fetchSellPoints() async {
    emit(LoadingBillState());
    var result = await billsRepo.getSellPoints(cancelToken);
    result.fold((failure) {
      print('get all sell points error');
      emit(FailureBillState(failure.errMassage));
    }, (data) {
      allSellPoints = data;
      currentAllSellPoints = data;
      emit(SuccessGetSellPoints());
    });
  }

  Future<void> fetchActiveCategory() async {
    emit(LoadingActiveCategoryState());
    var result = await billsRepo.getActiveCategory();
    result.fold((failure) {
      emit(FailureActivecategoryState(failure.errMassage));
    }, (activeCategory) async {
      List<CategoryModel> store = [];
      List<CategoryModel> damage = [];
      for (var element in activeCategory) {
        // print(element.type);
        if (element.type == 'store') {
          store.add(element);
        } else {
          damage.add(element);
        }
      }
      this.activeCategory = store;

      currentActiveCategory = store;
      activeCategoryRaw = damage;
      currentActiveCategoryRaw = damage;
      emit(SuccessActiveCategoryState());
    });
  }

  //-----------------------------------------------------------

  //--------------------------- normal method -----------------
  void changeToFactoryBill() {
    if (state is SuccessToFactoryBillState) {
      if (allBills.billsToFactory!.isEmpty) {
        fetchAllBills();
      }
    } else if (state is SuccessToSpBillState) {
      if (allBills.billsToFactory!.isEmpty) {
        fetchAllBills();
      } else {
        emit(SuccessToFactoryBillState(allBills.billsToFactory!));
      }
    }
  }

  void changeToSpBill() {
    if (state is SuccessToFactoryBillState) {
      if (allBills.billsToSellPoint!.isEmpty) {
        fetchAllBills2();
      } else {
        emit(SuccessToSpBillState(allBills.billsToSellPoint!));
      }
    } else if (state is SuccessToSpBillState) {
      if (allBills.billsToFactory!.isEmpty) {
        fetchAllBills2();
      }
    }
  }

  void billReturnMethod(context) {
    allBills.billsToFactory = [];
    allBills.billsToSellPoint = [];

    Navigator.of(context).pop();
  }

  void interToOrdersPages() {
    if (state is LoadingPostToFactoryBillState ||
        state is LoadingPostToSpBillState) {
    } else {
      emit(BillPageInitial());
    }
  }
  //------------------------------------------------------------

  //---------------------  Card methods -----------------------
  void decreaseCounter(int index) {
    if (cardCounter[index] != 0) {
      cardCounter[index]--;
      cardController[index].text = cardCounter[index].toString();
      emit(BillPageInitial());
    }
  }

  void increaseCounter(int index) {
    cardCounter[index]++;
    cardController[index].text = cardCounter[index].toString();
    emit(BillPageInitial());
  }

  void onTapCounterChange(index) {
    if (cardController[index].text == '1') {
      cardController[index].clear();
    }
    emit(BillPageInitial());
  }

  void onChangedCounter(index, String value) {
    if (value.isEmpty) {
      cardCounter[index] = 0;
    } else {
      cardCounter[index] = int.parse(cardController[index].text);
    }
    emit(BillPageInitial());
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
          id: id,
        );
      },
      ifAbsent: () => SelectedItem(
        title: itemName,
        price: cardCounter[index] * price,
        quantity: cardCounter[index],
        id: id,
      ),
    );
    cardCounter[index] = 1;
    cardController[index].text = '1';
    scrollToBottom();
    emit(BillPageInitial());
  }

  void deleteFromSelectedItem(index) {
    double price = double.parse(selectedItem[index]!.price.toString());
    total -= price;
    selectedItem.remove(index);
    emit(BillPageInitial());
  }

  void backToPrevious(context) {
    detailsOfFActoryBill = {};
    selectedItem.clear();
    cardController.clear();
    cardCounter.clear();
    total = 0;
    allSellPoints = [];
    currentAllSellPoints = [];
    selectedSellPoint = SellPoint();
    dateForOrderFromSp = DateTime.now();
    dateForOrder = DateTime.now();
    Navigator.pop(context);
    // emit(BillPageInitial());
  }

  void dialogBack(context) {
    selectedSellPoint = SellPoint();
    currentAllSellPoints = allSellPoints;
    // cancelRequest();
    emit(SuccessGetSellPoints());
    Navigator.of(context).pop();
  }

  void searchMethod({
    required List<CategoryModel> originalList,
    required String letter,
    required bool isStore,
  }) {
    List<CategoryModel> result = originalList.where((element) {
      return element.nameAr!.toLowerCase().contains(letter.toLowerCase());
    }).toList();
    if (isStore) {
      currentActiveCategory = result;
    } else {
      currentActiveCategoryRaw = result;
    }
    emit(BillPageInitial());
  }

// ------------------------------------------------------------
}
