
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnglishWordCard extends StatefulWidget {
  const EnglishWordCard({Key? key, required this.word, required this.symbolEn, required this.symbolAm, }) : super(key: key);
  final String word;
  final String? symbolEn;
  final String? symbolAm;

  @override
  State<EnglishWordCard> createState() => _EnglishWordCardState();
}

class _EnglishWordCardState extends State<EnglishWordCard> {
  late int type;
  late String symbol;
  late String soundURL;

  final _player = AudioPlayer();

  void _playSound() async {
    await _player.play(UrlSource(soundURL));
  }

  @override
  void initState() {
    type = widget.symbolAm != null ? 0 : 1;
    symbol = (type == 0 ? widget.symbolAm : widget.symbolEn)!;
    soundURL = "https://dict.youdao.com/dictvoice?type=${type}&audio=${widget.word}";
    super.initState();
  }

  void switchSymbolType() {
    print('${widget.symbolAm}, ${widget.symbolEn}');
    if (widget.symbolAm != null && widget.symbolEn != null) {
      setState(() {
        type = (type + 1) % 2;
        symbol = (type == 0 ? widget.symbolAm : widget.symbolEn)!;
        soundURL = "https://dict.youdao.com/dictvoice?type=${type}&audio=${widget.word}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Column(
          children: [
            Text(
              widget.word,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => switchSymbolType(),
                  child: Container(
                    margin: EdgeInsets.all(20.0), //容器外补白
                    color: Colors.blue,
                    child: Text(type == 0 ? "美" : "英", style: TextStyle(color: Colors.white),),
                    padding: EdgeInsets.all(2),
                  ),
                ),
                Text(symbol),
                GestureDetector(
                  onTap: () { _playSound(); print("sdf");},
                  child: Image.asset(
                    'lib/assets/images/sound.png',
                    height: 24,
                    width: 24,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
