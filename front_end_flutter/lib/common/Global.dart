import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end_flutter/common/http/ewl.dart';
import 'package:front_end_flutter/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cacheConfig.dart';
import '../models/learningItem.dart';
import '../models/profile.dart';
import 'http/cacheObject.dart';

class Global {
  static late SharedPreferences _prefs;
  static Profile profile = Profile();
  // 网络缓存对象
  static NetCache netCache = NetCache();


  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    //初始化网络请求相关配置
    EWL.init();
  }

  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));

  static saveNonLearningList(List<LearningItem> list) {
    List<String> stringList = list.map<String>((e) => jsonEncode(e.toJson())).toList();
    _prefs.setStringList("nonLearningList", stringList);
  }
  static List<LearningItem>? getNonLearningList() {
    List<String>? stringList = _prefs.getStringList("nonLearningList");
    if (stringList == null) return null;
    return stringList.map<LearningItem>((e) => LearningItem.fromJson(jsonDecode(e))).toList();
  }

  static saveReviewList(List<ReviewItem> list) {
    List<String> stringList = list.map<String>((e) => jsonEncode(e.toJson())).toList();
    _prefs.setStringList("reviewList", stringList);
  }
  static List<ReviewItem>? getReviewList() {
    List<String>? stringList = _prefs.getStringList("reviewList");
    if (stringList == null) return null;
    return stringList.map<ReviewItem>((e) => ReviewItem.fromJson(jsonDecode(e))).toList();
  }

  static saveNonLearningIndex(int index) {
    _prefs.setInt("nonLearningIndex", index);
  }
  static getNonLearningIndex() {
    return _prefs.getInt("nonLearningIndex");
  }
  static saveReviewIndex(int index) {
    _prefs.setInt("reviewIndex", index);
  }
  static getReviewIndex() {
    return _prefs.getInt("reviewIndex");
  }

}