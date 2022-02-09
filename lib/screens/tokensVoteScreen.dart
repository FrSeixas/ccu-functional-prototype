import 'package:ccu_proj/objectClasses/PollOption.dart';
import 'package:ccu_proj/screens/popUpPollOptionInfo.dart';
import 'package:flutter/material.dart';
import 'package:ccu_proj/cards/TokensVoteOptionCard.dart';
import 'package:ccu_proj/objectClasses/VoteOption.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';


class TokensVoteScreen extends StatefulWidget {

  final PollOption poll;

  const TokensVoteScreen({Key? key, required this.poll}) : super(key: key);

  @override
  State<TokensVoteScreen> createState() => _TokensVoteScreenState();
}

class _TokensVoteScreenState extends State<TokensVoteScreen> {
  final DatabaseReference _testRef = FirebaseDatabase(databaseURL: "https://ccu-prototype-default-rtdb.europe-west1.firebasedatabase.app").reference();

  List<VoteOption> options =[];
  int nr_tokens_left = 10;

  late popUpVoteOptionInfo popup;

  @override
  Widget build(BuildContext context) {

    options = widget.poll.getOptions();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.poll.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.group_rounded,
                  size: 25,
                ),
                SizedBox(width: 5),
                Text(
                  widget.poll.group,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.calendar_today_rounded,
                  size: 25,
                ),
                SizedBox(width: 5),
                Text(
                    'Ends in: ' + widget.poll.endDate,
                    style: TextStyle( fontSize: 17, )
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Text(
                widget.poll.description,
                style: TextStyle( fontSize: 17, )
            ),
            //const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                    ),
                    SizedBox(width: 2),
                    const Text(
                        'Distribution of tokens in your desired order',
                        style: TextStyle( fontSize: 17, )
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.add_task),
                        Text('$nr_tokens_left',
                          style: TextStyle ( fontSize: 35),
                        ),
                      ],
                    ),
                    IconButton(
                        icon: const Icon(Icons.refresh_outlined),
                        iconSize: 40,
                        onPressed: () {
                          setState(() {
                            resetTokens();
                          });
                        }
                    )
                  ],
                )
              ],
            ),
            Column(
              children: options.map((voteOption) => TokensVoteOptionCard(
                option: voteOption,
                key: ValueKey(voteOption),
                remove_token_left :(){
                  if(nr_tokens_left>0) {
                    voteOption.addToken();
                    setState(() {
                      nr_tokens_left--;
                    });
                    return true;
                  }
                  else return false;
                },
                add_token_left :(){
                  if(nr_tokens_left<10) {
                    voteOption.removeToken();
                    setState(() {
                      nr_tokens_left++;
                    });
                    return true;
                  }
                  else return false;
                },
              )).toList(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: (){
                  for(int i=0; i<options.length; i++) {
                    print(options[i].total_tokens);
                  }
                  if(nr_tokens_left == 0) {
                    Navigator.pop(context, widget.poll.title);
                    updateData();
                  }
                  else {
                    final snackBar = SnackBar(
                      content: Text('Please distribute all the tokens.\n Still $nr_tokens_left tokens left'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetTokens() {
    for(int i = 0; i<widget.poll.options.length; i++){
      options[i].resetTokens();
    }
    nr_tokens_left = 10;
  }
  void updateData(){
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String vote = String.fromCharCodes(Iterable.generate(25, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    String titulo = "polls/" + widget.poll.title;
    _testRef.child(titulo).update({
      'votes': [vote]
    });
  }
}