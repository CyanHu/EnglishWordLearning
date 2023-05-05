import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/pages/sub_pages/learning_sub_page.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {

  void toLearningSubPage(learningType) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LearningSubPage(learningType: learningType)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" 学习"),
        centerTitle: true,
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () =>toLearningSubPage("learning"),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Learning",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    SizedBox(height: 5,),
                    Text("123")
                  ],
                ),
              )),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: () => toLearningSubPage("review"),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Review",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    SizedBox(height: 5,),
                    Text("123")
                  ],
                ),
              )),
        ],
      )),
    );
  }
}
