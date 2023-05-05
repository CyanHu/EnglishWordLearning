import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/main.dart';

import '../../models/index.dart';
import '../Global.dart';

class EWL {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  EWL([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext? context;
  late Options _options;
  static Dio dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000',
  ));

  static void init() {
    // 添加缓存插件
    dio.interceptors.add(Global.netCache);
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token != null ? 'Bearer ${Global.profile.token}' : null;
  }

  Future<User?> login(String username, String password) async {
    var r = await dio.post(
      "/user/account/token",
      data: {'username': username, 'password' : password},
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    if (r.data['error_message'] != "成功") {
      EasyLoading.showError('登录失败');
      return null;
    } else {
      Global.profile.token = r.data['data']['token'];
      Global.netCache.cache.clear();
      dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ${r.data['data']['token']}';
      return User.fromJson(r.data['data']['user']);
    }
  }

  Future<WordData> getWordData(num wordId) async {
    var r = await dio.get(
      "/wordData/$wordId",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return WordData.fromJson(r.data['data']['wordData']);
  }

  Future<List<Notice>> getNoticeList() async {
    var r = await dio.get(
      "/notice/all",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return r.data['data']['notices'].map<Notice>((e) => Notice.fromJson(e)).toList();
  }
  Future<LearningDataBrief> getLearningDataBrief(num wordId) async {
    var r = await dio.get(
      "/learningData/brief/$wordId",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return LearningDataBrief.fromJson(r.data['data']['learningDataBrief']);
  }
  Future<RecentWeekLearningData> getRecentWeekLearningData(num wordId) async {
    var r = await dio.get(
      "/learningData/recentWeek/$wordId",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return RecentWeekLearningData.fromJson(r.data['data']['recentWeekLearningData']);
  }

  Future<SingleSignInRecord> getSingleSignInRecord(num wordId) async {
    var r = await dio.get(
      "/signIn/single/$wordId",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return SingleSignInRecord.fromJson(r.data['data']['singleSignInRecord']);
  }



}