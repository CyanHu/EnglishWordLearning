import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/common/Global.dart';

class ProfileAccountCard extends StatelessWidget {
  const ProfileAccountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Row(children: [
          CircleAvatar(backgroundImage: NetworkImage(Global.profile.user!.avatar), radius: 30,),
          SizedBox(width: 20,),
          Text(Global.profile.user!.username, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),),
        ],),
      ),
    );
  }
}
