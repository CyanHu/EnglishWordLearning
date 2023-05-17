import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordBookBlankItem extends StatelessWidget {
  const WordBookBlankItem({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        width: BouncingScrollSimulation.maxSpringTransferVelocity,
        child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey),
            )));
  }
}
