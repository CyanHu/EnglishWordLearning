import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextWordCard extends StatelessWidget {
  const NextWordCard({Key? key, required this.selectNextButton}) : super(key: key);
  final Function selectNextButton;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed:()=> selectNextButton(),
          child: Text("下一个"),
        ));
  }
}
