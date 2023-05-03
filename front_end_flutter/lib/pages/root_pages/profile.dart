import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/components/profile_account_card.dart';
import 'package:front_end_flutter/components/profile_sign_in_card.dart';
import 'package:front_end_flutter/pages/sub_pages/learning_data_sub_page.dart';
import 'package:front_end_flutter/pages/sub_pages/notice_sub_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          ProfileAccountCard(),
          ProfileSignInCard(),
          _profileItem(LearningDataSubPage(), "learningData", "学习数据"),
          _profileItem(NoticeSubPage(), 'notice', "通知")
        ],),
      ),
    );
  }

  Widget _profileItem(Widget navWidget, String urlString, String itemString) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => navWidget,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Image.asset("lib/assets/images/$urlString.png", height: 20, width: 20, color: Colors.cyan,),
          SizedBox(width: 10,),
          Text(itemString),
          Expanded(child: SizedBox()),
          Icon(Icons.chevron_right)
        ],),
      ),
    );
  }
}


