import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LearningLevelCard extends StatelessWidget {
  const LearningLevelCard({Key? key, required this.selectLevelButton, required this.learningType}) : super(key: key);
  final String learningType;
  final Function selectLevelButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        verticalDirection: VerticalDirection.down,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton(
              onPressed: () => selectLevelButton("认识"), child: Text("认识")),
          Visibility(
            visible: learningType == "review" ? true : false,
            child: ElevatedButton(
                onPressed: () => selectLevelButton("模糊"), child: Text("模糊")),
          ),
          ElevatedButton(
              onPressed: () => selectLevelButton("不认识"), child: Text("不认识")),
        ],

      ),
    );
  }
}
