import 'package:dio/dio.dart';

import 'http_options.dart';

class DioSingleton {
  static final _singleton = DioSingleton._internal();
  factory DioSingleton() => _singleton;
  final dio = Dio(baseOptions);
  DioSingleton._internal();

  static final BaseOptions baseOptions = BaseOptions(
    baseUrl: HttpOptions.baseURL,
    connectTimeout: const Duration(milliseconds: HttpOptions.connectTimeout),
    receiveTimeout: const Duration(milliseconds: HttpOptions.receiveTimeout),
    headers: {},
  );
  static void init() {

  }

}