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
import 'package:front_end_flutter/pages/sub_pages/learning_finish_sub_page.dart';

class LearningSubPage extends StatefulWidget {
  const LearningSubPage({Key? key, required this.learningType})
      : super(key: key);
  final String learningType;


  @override
  State<LearningSubPage> createState() => _LearningSubPageState();
}

class _LearningSubPageState extends State<LearningSubPage> {
  late final String learningType;
  late final List<dynamic> wordList;
  bool _isSelected = false;
  late int _studyIndex;
  late DateTime startTime;
  List<int> finishList = [];


  void selectLevelButton(String level) {
    setState(() {
      _isSelected = true;
    });
  }



  bool isFinish(item) {
    if (learningType == "learning") {
        if (item.reviewCount >= 3) return true;
    } else {
        if (item.firstType == "认识" && item.reviewCount >= 1) {
          return true;
        } else if (item.firstType == "模糊" && item.reviewCount >= 2) {
          return true;
        } else if (item.firstType == "不认识" && item.reviewCount >= 3) {
          return true;
        }
    }
    return false;
  }

  int getFinishCount() {
    int res = 0;
    for (var value in wordList) {
      if (isFinish(value)) res ++;
    }
    return res;
  }

  void _nextWordButtonAction() {

    if (getFinishCount() == wordList.length) {
      Route route = MaterialPageRoute(builder: (context) => LearningFinishSubPage(learningType: learningType,));
      Navigator.pushReplacement(context, route);
    } else {
      setState(() {
        _isSelected = false;
        _nextStudyIndex();
      });
    }

  }

  void _levelButtonAction(String buttonType) {
    print(buttonType);
    if (learningType == "review" && wordList[_studyIndex].firstType == null) {
      wordList[_studyIndex].firstType = buttonType;
    }
    if (buttonType == "认识") {
      wordList[_studyIndex].reviewCount ++;
    } else if (buttonType == "不认识") {
      wordList[_studyIndex].reviewCount = 0;
    }
    setState(() {
      _isSelected = true;
    });
    if (isFinish(wordList[_studyIndex])) {
      finishList.add(wordList[_studyIndex].wordId);
    }


  }

  void _nextStudyIndex() {
    int nextStudyIndex;
    for (int i = 1; i <= wordList.length; i ++) {
      nextStudyIndex = (_studyIndex + i) % wordList.length;
      if (!isFinish(wordList[nextStudyIndex])) {
        _studyIndex = nextStudyIndex;
        break;
      }
    }
  }

  @override
  void initState() {
    learningType = widget.learningType;
    wordList = (learningType == "learning") ? Global.getNonLearningList()! : Global.getReviewList()!;
    _studyIndex = (learningType == "learning") ? Global.getNonLearningIndex()! : Global.getReviewIndex()!;
    if (getFinishCount() == wordList.length) {
        _isSelected = true;
    }
    startTime = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    print("dispose 被调用了");

    if (_isSelected) {
      _nextStudyIndex();
    }

    if (learningType == "learning") {
      Global.saveNonLearningList(wordList.map<LearningItem>((e)=> e as LearningItem).toList());
      Global.saveNonLearningIndex(_studyIndex);
    } else if (learningType == "review") {
      Global.saveReviewList(wordList.map<ReviewItem>((e)=> e as ReviewItem).toList());
      Global.saveReviewIndex(_studyIndex);
    }
    DateTime endTime = DateTime.now();
    print("学习时长:${endTime.difference(startTime).inSeconds}秒");
    print("完成单词:$finishList");

    EWL().addLearningData(learningType: learningType, startTime: startTime, endTime: endTime, wordIdList: finishList);
    EWL().singleSignIn().then((value) => print(value));


    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop('刷新')},
        ),
        title: Text("$learningType (${getFinishCount()}/${wordList.length})"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<WordData>(
          future: EWL().getWordData(wordList[_studyIndex].wordId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                // 请求成功，显示数据
                WordData wordData = snapshot.data;
                return Column(
                  children: [
                    EnglishWordCard(
                      word: wordData.word,
                      symbolAm: wordData.amPhoneticSymbol,
                      symbolEn: wordData.enPhoneticSymbol,
                    ),
                    WordMeaningCard(meaningList: wordData.meanings, isVisibility: _isSelected,),
                    ExampleSentencesCard(
                      sentenceList: wordData.exampleSentences!,
                      isVisibility: _isSelected,
                    ),
                    !_isSelected ? LearningLevelCard(selectLevelButton: _levelButtonAction, learningType: learningType,) : NextWordCard(selectNextButton: _nextWordButtonAction,)
                  ],
                );
              }
            } else {
              // 请求未结束，显示loading
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
