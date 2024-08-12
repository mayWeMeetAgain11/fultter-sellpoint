import 'package:dio/dio.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';

abstract class Failure {
  final String errMassage;
  final int statusCode;
  const Failure(this.errMassage, this.statusCode);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMassage, super.statusCode);

  factory ServerFailure.fromDioError(DioException dioException) {
    print('here we go again');
    print(
        'status code from ServerFailure: ${dioException.response?.statusCode ?? 600}');
    if (dioException.type == DioExceptionType.connectionTimeout) {
      print('111');
      return ServerFailure(
        'Connection timeout with ApiServer',
        dioException.response?.statusCode ?? 601,
      );
    } else if (dioException.type == DioExceptionType.sendTimeout) {
      print('222');
      return ServerFailure(
        'Send timeout with ApiServer',
        dioException.response?.statusCode ?? 602,
      );
    } else if (dioException.type == DioExceptionType.receiveTimeout) {
      print('333');
      return ServerFailure(
        'Receive timeout with ApiServer',
        dioException.response?.statusCode ?? 603,
      );
    } else if (dioException.type == DioExceptionType.badResponse) {
      print('444');
      return ServerFailure.fromResponse(
        dioException.response!.statusCode!,
        dioException.response!.data,
      );
    } else if (dioException.type == DioExceptionType.cancel) {
      print('555');
      return ServerFailure(
        'Request to  ApiServer was canceld',
        dioException.response?.statusCode ?? 604,
      );
    } else {
      // print(10000);
      // if (dioException.message!.contains('SocketException')) {
      //   print('666');
      //   return ServerFailure('No Internet Connection');
      // }
      // print("status code:  ${dioException.response!.statusCode}");
      print('7777');
      String errMessage =
          (CasheHelper.getData(key: Constants.klangSympol) == 'en')
              ? 'please check your internet'
              : 'تأكد من إتصال الإنترنت لديك أو قم بإطفاء أي تطبيق VPN';
      return ServerFailure(
        errMessage,
        dioException.response?.statusCode ?? 600,
      );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    print('statusCode is $statusCode');
    if (statusCode == 400 ||
        statusCode == 401 ||
        // statusCode == 403 ||
        statusCode == 422) {
      print(response['data']);
      String error = response['data'];
      if (statusCode == 422) {
        if (CasheHelper.getData(key: Constants.klangSympol) == 'ar') {
          double num =
              double.parse(response['data'].replaceAll(RegExp(r'[^0-9.]'), ''));
          error = '  بقي للطالب من الحد اليومي $num ';
        }
      }
      return ServerFailure(error, statusCode);
    } else if (statusCode == 403) {
      return ServerFailure(
          'Forbidden Access, please logout and login again ', statusCode);
    } else if (statusCode == 404) {
      String errMessage =
          (CasheHelper.getData(key: Constants.klangSympol) == 'ar')
              ? 'خطأ في الطلب, يرجى التأكد من المعلومات المرسلة'
              : 'Request error, please check the information sent';
      return ServerFailure(errMessage, statusCode);
    } else if (statusCode == 500) {
      return ServerFailure(
          'internal Server error, Please try later', statusCode);
    } else {
      return ServerFailure(
          'Opps There was an Error, Please try again', statusCode);
    }
  }
}
