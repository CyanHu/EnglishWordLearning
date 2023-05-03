import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end_flutter/common/Global.dart';
import 'package:front_end_flutter/common/http/ewl.dart';
import 'package:front_end_flutter/components/english_word_card.dart';
import 'package:front_end_flutter/components/example_sentences_card.dart';
import 'package:front_end_flutter/components/learning_level_card.dart';
import 'package:front_end_flutter/components/next_word_card.dart';
import 'package:front_end_flutter/components/word_meaning_card.dart';
import 'package:front_end_flutter/models/index.dart';

class LearningSubPage extends StatefulWidget {
  const LearningSubPage({Key? key, required this.learningType})
      : super(key: key);
  final String learningType;

  @override
  State<LearningSubPage> createState() => _LearningSubPageState();
}

class _LearningSubPageState extends State<LearningSubPage> {
  late final String learningType;
  bool _isSelected = false;
  WordData? wordData;

  void selectLevelButton(String level) {
    print(level);
    setState(() {
      _isSelected = true;
    });
  }

  @override
  void initState() {
    learningType = widget.learningType;
      EWL().getWordData(6).then((value) {
        setState(() {
          wordData = value;
        });
      });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if (wordData == null) {
      return SizedBox();
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop('刷新')},
        ),
        title: Text(learningType),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            EnglishWordCard(
              word: wordData!.word,
              symbolAm: wordData!.amPhoneticSymbol,
              symbolEn: wordData!.enPhoneticSymbol,
            ),
            WordMeaningCard(meaningList: wordData!.meanings, isVisibility: _isSelected,),
            ExampleSentencesCard(
              sentenceList: wordData!.exampleSentences!,
              isVisibility: _isSelected,
            ),
            !_isSelected ? LearningLevelCard(selectLevelButton) : NextWordCard()
          ],
        ),
      ),
    );
  }
}
