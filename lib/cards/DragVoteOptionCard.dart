import 'package:flutter/material.dart';
import 'package:ccu_proj/objectClasses/VoteOption.dart';

class DragVoteOptionCard extends StatelessWidget {

  late VoteOption option;
  late Key key;
  DragVoteOptionCard({required this.option, required this.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      child: Container(
        width: 1000,
        height: 60,
        decoration: BoxDecoration(
          color:Colors.lightBlue[50],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.drag_indicator,
              size: 40,
            ),
            Text(
                option.title,
                style:TextStyle(
                  fontSize: 20,)
            ),
          ],
        ),
      ),
    );
  }
}