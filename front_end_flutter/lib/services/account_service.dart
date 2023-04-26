import 'dart:convert';

import 'package:dio/dio.dart';

import '../common/http/dio_singleton.dart';



class AccountService {
  static Future getToken(
      {required String username, required String password}) async {
    final response = await DioSingleton().dio.post('/user/account/token',
        data: {'password': password, 'username': username},
        options: Options(responseType: ResponseType.json));
    return response;
  }
}
