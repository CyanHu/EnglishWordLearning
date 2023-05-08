import 'dart:convert';
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

  Future<String> addWordToRawWordBook(String word) async {
    var r = await dio.post(
      "/wordBook/rawBook/${Global.profile.user!.userId}/$word",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return r.data['error_message'];
  }

  Future<WordBook> getSelectedWordBook() async {
    var r = await dio.get(
      "/wordBook/selected/${Global.profile.user!.userId}",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return WordBook.fromJson(r.data['data']['selectedWordBook']);
  }

  Future<List<WordBook>> getUserWordBookList() async {
    var r = await dio.get(
      "/wordBook/user/${Global.profile.user!.userId}",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return r.data['data']['userWordBookList'].map<WordBook>((e) => WordBook.fromJson(e)).toList();
  }

  Future<List<WordBook>> getSystemWordBookList() async {
    var r = await dio.get(
      "/wordBook/system",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return r.data['data']['systemWordBookList'].map<WordBook>((e) => WordBook.fromJson(e)).toList();
  }

  Future<String> updateSelectedWordBook(int bookId) async {
    var r = await dio.post(
      "/wordBook/selected/update/${Global.profile.user!.userId}/$bookId",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    if (r.data['error_message'] == "成功") return "更新成功";
    return "更新失败";
  }

  Future<LearningBrief> getLearningBrief() async {
    var r = await dio.get(
      "/learning/brief/${Global.profile.user!.userId}",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return LearningBrief.fromJson(r.data['data']);
  }

  Future<List<LearningItem>> getNonLearningItemList() async {
    var r = await dio.get(
      "/learning/nonLearningWordIdList/${Global.profile.user!.userId}",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return r.data['data']['nonLearningWordIdList'].map<LearningItem>((e) => LearningItem()..wordId = e..reviewCount=0).toList();
  }

  Future<List<ReviewItem>> getReviewItemList() async {
    var r = await dio.get(
      "/learning/reviewWordIdList/${Global.profile.user!.userId}",
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return r.data['data']['reviewItemVOList'].map<ReviewItem>((e) => ReviewItem()..wordId = e['wordId']..firstType=null..reviewCount=0..learningWordId = e['learningWordId']).toList();
  }

  Future<String> learning() async {
    List<num> learningList =  Global.getNonLearningList()!.map<num>((e) => e.wordId).toList();
    String str = jsonEncode(learningList);
    var r = await dio.post(
      "/learning/learning/${Global.profile.user!.userId}",
      data: str,
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return r.data['error_message'];
  }

  Future<String> review() async {

    List<Map<String, dynamic>> reviewList =  Global.getReviewList()!.map<Map<String, dynamic>>((e) => {'learningWordId': e.learningWordId, 'firstType': e.firstType}).toList();
    String str = jsonEncode(reviewList);
    var r = await dio.post(
      "/learning/review/${Global.profile.user!.userId}",
      data: str,
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    return r.data['error_message'];
  }

  Future<String> addLearningData({required String learningType, required DateTime startTime, required DateTime endTime, required List<int> wordIdList}) async {
    Map<String, dynamic> requestBody = {
      "userId": Global.profile.user!.userId,
      "learningType": learningType,
      "startTime": startTime.millisecondsSinceEpoch,
      "endTime": endTime.millisecondsSinceEpoch,
      "wordIdList": wordIdList,
    };

    var r = await dio.post(
      "/learning/record/add",
      data: jsonEncode(requestBody),
      options: _options.copyWith(extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );

    return r.data["error_message"];

  }








}