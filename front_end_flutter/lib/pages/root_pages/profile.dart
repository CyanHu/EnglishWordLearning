import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/components/profile_account_card.dart';
import 'package:front_end_flutter/components/profile_sign_in_card.dart';
import 'package:front_end_flutter/models/index.dart';
import 'package:front_end_flutter/pages/sub_pages/learning_data_sub_page.dart';
import 'package:front_end_flutter/pages/sub_pages/notice_sub_page.dart';

import '../../common/Global.dart';
import '../../common/http/ewl.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单词书"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          ProfileAccountCard(),
          FutureBuilder<SingleSignInRecord>(
            future: EWL().getSingleSignInRecord(Global.profile.user!.userId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // 请求已结束
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // 请求失败，显示错误
                  return Text("Error: ${snapshot.error}");
                } else {
                  // 请求成功，显示数据
                  return ProfileSignInCard(singleSignInRecord: snapshot.data,);
                }
              } else {
                // 请求未结束，显示loading
                return CircularProgressIndicator();
              }
            },
          ),
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


