
import 'package:ccu_proj/objectClasses/VoteOption.dart';
import 'package:flutter/material.dart';

class popUpVoteOptionInfo {
  late VoteOption option;
  popUpVoteOptionInfo({required VoteOption option}) {
    this.option = option;
  }

  Future<void> addPollOptionsDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Title:' + option.title),
                  Text('Description' + option.description),
                ],
              ),
            ),
            /*actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
                },
            )


          ]

           */
          );
        });
  }
}