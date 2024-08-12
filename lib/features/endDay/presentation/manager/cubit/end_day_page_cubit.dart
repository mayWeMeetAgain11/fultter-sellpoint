import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/features/endDay/data/repos/endDay_repo.dart';

import '../../../../../constants.dart';

part 'end_day_page_state.dart';

class EndDayPageCubit extends Cubit<EndDayPageState> {
  EndDayPageCubit(this.endDayRepo) : super(EndDayPageInitial());
  final EndDayRepo endDayRepo;
  static EndDayPageCubit get(context) => BlocProvider.of(context);
// ---------------------------- VAriable ------------------------
  List<TextEditingController> invintoryController = [];
  // List<TextEditingController> takenController = [];
  // List<TextEditingController> soldController = [];
  TextEditingController envelopeAddress = TextEditingController();
  TextEditingController envelopeAmount = TextEditingController(text: '0');
  // TextEditingController takenAmount = TextEditingController(text: '0');

  GlobalKey<FormState> formKay = GlobalKey<FormState>();
  DateTime dateFOrInventory = DateTime.now();
  DateTime dateFOrEnvelops = DateTime.now();

// --------------------------------------------------------------

  Future<void> postEndInvintory(
    Map<String, dynamic> data,
  ) async {
    emit(LoadingEndDayState());
    var result = await endDayRepo.postInvintory(data);
    result.fold(
      (failure) {
        emit(FailureEndDayState(failure.errMassage));
      },
      (success) {
        // CasheHelper.setData(key: Constants.kstartDay, value: true);
        // CasheHelper.setData(
        //   key: Constants.kIsEnvelopeDone,
        //   value: false,
        // );
        // CasheHelper.setData(key: Constants.kIsOrdered, value: false);

        emit(SuccessPostInvintory());
      },
    );
  }

  Future<void> postEndEnvelops(
      Map<String, dynamic> data, int sellPointID) async {
    emit(LoadingPostEnvelopeState());
    var result = await endDayRepo.postEnvelope(data, sellPointID);
    result.fold(
      (failure) {
        emit(FailurePostEnvelopeState(failure.errMassage));
      },
      (success) {
        // CasheHelper.setData(key: Constants.kIsEnvelopeDone, value: true);
        emit(SuccessPostEnvelopeState());
      },
    );
  }

  Future<void> postExpensesToFactory(Map<String, dynamic> data) async {
    emit(LoadingPostExpensesState());
    var result = await endDayRepo.postExpensesToFactory(data);
    result.fold((failure) {
      emit(FailurePostExpensesState(failure.errMassage));
    }, (success) async {
      emit(SuccessPostExpensesState());
    });
  }
}
