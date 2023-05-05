import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/models/index.dart';

import '../common/Global.dart';

class ProfileSignInCard extends StatelessWidget {
  const ProfileSignInCard({Key? key, required this.singleSignInRecord}) : super(key: key);
  final SingleSignInRecord singleSignInRecord;

  @override
  Widget build(BuildContext context) {
    String isSignIn = singleSignInRecord.signIn ? "是" : "否";
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          Column(
            children: [Text(singleSignInRecord.signInDay.toString()), Text('累计签到', style: TextStyle(color: Colors.grey),)],
          ),
          Column(
            children: [Text(isSignIn), Text("今日签到",style: TextStyle(color: Colors.grey))],
          )
        ],),
      ),
    );
  }
}
