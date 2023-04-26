import 'package:front_end_flutter/common/Global.dart';

import '../models/index.dart';
import 'profileChangeNotifier.dart';

class UserModel extends ProfileChangeNotifier {

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => Global.profile.user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User? user) {
    if (user?.username != Global.profile.user?.username) {
      Global.profile.lastLogin = Global.profile.user?.username;
      Global.profile.user = user;
      notifyListeners();
    }
  }
}