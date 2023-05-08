import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/common/http/ewl.dart';

import '../models/index.dart';

class ExampleSentencesCard extends StatefulWidget {
  const ExampleSentencesCard(
      {Key? key, required this.sentenceList, required this.isVisibility})
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
                    SelectableText(
                      '例句：${widget.sentenceList[index].sentence}',
                      contextMenuBuilder: (BuildContext context,
                          EditableTextState editableTextState) {
                        final List<ContextMenuButtonItem> buttonItems =
                            editableTextState.contextMenuButtonItems;
                        // Here we add an "Email" button to the default TextField
                        // context menu for the current platform, but only if an email
                        // address is currently selected.
                        String text = editableTextState.textEditingValue.text;
                        String selectedText = editableTextState.textEditingValue.selection.textInside(text);
                          buttonItems.insert(
                              0,
                              ContextMenuButtonItem(
                                label: '添加到生词本',
                                onPressed: () {
                                  EWL().addWordToRawWordBook(selectedText).then((value) => EasyLoading.showInfo(value));
                                },
                              ));
                        return AdaptiveTextSelectionToolbar.buttonItems(
                          anchors: editableTextState.contextMenuAnchors,
                          buttonItems: buttonItems,
                        );
                      },
                    ),
                    SelectableText(
                        '翻译：${widget.sentenceList[index].sentenceTranslation}'),
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
