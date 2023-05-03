import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/index.dart';

class WordMeaningCard extends StatelessWidget {
  const WordMeaningCard({Key? key, required this.meaningList, required this.isVisibility})
      : super(key: key);
  final List<Meaning> meaningList;
  final bool isVisibility;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: BouncingScrollSimulation.maxSpringTransferVelocity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            visible: isVisibility,
            child: ListView(
              children: List.from(
                  meaningList.map((e) => Text('${e.wordType}. ${e.meaning}', textAlign: TextAlign.left,))),
            ),
          ),
        ),
      ),
    );
  }
}
