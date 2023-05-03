import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/index.dart';

class ExampleSentencesCard extends StatefulWidget {
  const ExampleSentencesCard({Key? key, required this.sentenceList, required this.isVisibility})
      : super(key: key);
  final List<Sentence> sentenceList;
  final bool isVisibility;

  @override
  State<ExampleSentencesCard> createState() => _ExampleSentencesCardState();
}

class _ExampleSentencesCardState extends State<ExampleSentencesCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          width: BouncingScrollSimulation.maxSpringTransferVelocity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            visible: widget.isVisibility,
            child: ListView.builder(
              itemCount: widget.sentenceList.length,
              itemExtent: 100,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('例句：${widget.sentenceList[index].sentence}'),
                    Text('翻译：${widget.sentenceList[index].sentenceTranslation}')
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}
