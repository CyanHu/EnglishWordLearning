import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextWordCard extends StatelessWidget {
  const NextWordCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () {},
          child: Text("下一个"),
        ));
  }
}
