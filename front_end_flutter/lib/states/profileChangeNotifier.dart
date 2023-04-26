import 'package:flutter/widgets.dart';

import '../common/Global.dart';
import '../models/profile.dart';

class ProfileChangeNotifier extends ChangeNotifier {

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}