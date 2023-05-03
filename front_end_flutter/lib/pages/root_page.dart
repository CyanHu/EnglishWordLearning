
import 'package:flutter/material.dart';
import 'package:front_end_flutter/common/Global.dart';
import 'package:front_end_flutter/pages/root_pages/learning_page.dart';
import 'package:front_end_flutter/pages/root_pages/profile.dart';
import 'package:front_end_flutter/pages/root_pages/word_book_page.dart';
import 'package:front_end_flutter/pages/sub_pages/login_page.dart';
import 'package:provider/provider.dart';

import '../states/userModel.dart';


class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

const Map<String, String> _bottomNames = {
  'learning': '学习',
  'wordBook': '词书',
  'profile': '我的'
};

class _RootPageState extends State<RootPage> {

  int _currentIndex = 0;
  List<BottomNavigationBarItem> navItemList = [];
  final List<Widget> _pages = [
    LearningPage(),
    WordBookPage(),
    Profile()
  ];

  @override
  void initState() {
    super.initState();
    _bottomNames.forEach((key, value) {
      navItemList.add(_bottomNavBarItem(key, value));
    });
  }

  void _onTabClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return const LoginPage();
    } else {
      return Scaffold(
          body: _pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: navItemList,
            currentIndex: _currentIndex,
            onTap: _onTabClick,
            type: BottomNavigationBarType.fixed,
          )
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  BottomNavigationBarItem _bottomNavBarItem(String key, String value) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        'lib/assets/images/$key.png',
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        'lib/assets/images/$key.png',
        width: 24,
        height: 24,
        color: Colors.blue,
      ),
      label: '$value',
      tooltip: '',
    );
  }

}
