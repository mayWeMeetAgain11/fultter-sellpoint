import 'data.dart';

class LoginModel {
  String? token;
  Data? data;

  LoginModel({this.token, this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json['token'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'data': data?.toJson(),
      };
}
