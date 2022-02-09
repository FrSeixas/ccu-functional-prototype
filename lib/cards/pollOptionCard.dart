import 'package:ccu_proj/objectClasses/PollTypes.dart';
import 'package:ccu_proj/screens/dragVoteScreen.dart';
import 'package:flutter/material.dart';
import 'package:ccu_proj/objectClasses/PollOption.dart';
import 'package:ccu_proj/screens/tokensVoteScreen.dart';



class PollOptionCard extends StatelessWidget {

  final PollOption option;
  final Function remove_poll;
  PollOptionCard( {required this.option, required this.remove_poll});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: InkWell(
        onTap: () { handlePollAnswer(context);},
        child: Container(
          width: 1000,
          height: 150,
          decoration: BoxDecoration(
            color:Colors.lightBlue[50],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                    option.title,
                    style:TextStyle(
                      fontSize: 20,)
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded),
                    Text(
                        option.endDate,
                        style:TextStyle(
                          fontSize: 17,)
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.group_rounded),
                    Text(
                        option.group,
                        style:TextStyle(
                          fontSize: 17,)
                    ),
                  ],
                ),
                Text(
                    option.description,
                    style:TextStyle(
                      fontSize: 17,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handlePollAnswer(BuildContext context) async {
    if (option.pollType == PollTypes.tokens) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TokensVoteScreen(poll: option)),
      );
      if (result != Null)
        remove_poll(result);
    }
    if (option.pollType == PollTypes.order) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DragVoteScreen(poll: option)),
      );
      if (result != Null)
        remove_poll(result);
    }
  }
}