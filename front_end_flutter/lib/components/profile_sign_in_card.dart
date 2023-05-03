import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/Global.dart';

class ProfileSignInCard extends StatelessWidget {
  const ProfileSignInCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          Column(
            children: [Text("1"), Text('累计签到', style: TextStyle(color: Colors.grey),)],
          ),
          Column(
            children: [Text("是"), Text("今日签到",style: TextStyle(color: Colors.grey))],
          )
        ],),
      ),
    );
  }
}
