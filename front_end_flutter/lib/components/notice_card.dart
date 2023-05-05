import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/models/index.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({Key? key, required this.notice}) : super(key: key);
  final Notice notice;
  @override
  Widget build(BuildContext context) {
    DateTime time =
        DateTime.fromMillisecondsSinceEpoch(notice.noticeTime.toInt());
    return Column(
      children: [
        Text(
          '${time.year.toString().substring(2)}年${time.month}月${time.day}日 ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
          style: TextStyle(color: Colors.grey),
        ),
        Container(
          width: BouncingScrollSimulation.maxSpringTransferVelocity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Visibility(
                    visible: notice.pictureUrl != null,
                    child: notice.pictureUrl != null
                        ? Image.network(notice.pictureUrl!, height: 80,)
                        : const Placeholder(),
                  ),
                  Title(
                    color: Colors.black,
                    child: Text(
                      notice.title,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),
                  Text(
                    notice.description,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  Container(
                    width: BouncingScrollSimulation.maxSpringTransferVelocity,
                    child: Text(
                      '#${notice.noticeType}',
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
