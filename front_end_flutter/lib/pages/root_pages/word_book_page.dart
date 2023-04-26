import 'package:flutter/cupertino.dart';

class WordBookPage extends StatefulWidget {
  const WordBookPage({Key? key}) : super(key: key);

  @override
  State<WordBookPage> createState() => _WordBookPageState();
}

class _WordBookPageState extends State<WordBookPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text("单词书"));
  }
}
