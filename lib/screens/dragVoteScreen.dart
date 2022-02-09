import 'package:ccu_proj/objectClasses/PollOption.dart';
import 'package:flutter/material.dart';
import 'package:ccu_proj/cards/DragVoteOptionCard.dart';
import 'package:ccu_proj/objectClasses/VoteOption.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';


class DragVoteScreen extends StatefulWidget {
  final PollOption poll;

  const DragVoteScreen({Key? key, required this.poll}) : super(key: key);

  @override
  State<DragVoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<DragVoteScreen> {
  final DatabaseReference _testRef = FirebaseDatabase(databaseURL: "https://ccu-prototype-default-rtdb.europe-west1.firebasedatabase.app").reference();
  List<VoteOption> options =[];

  @override
  Widget build(BuildContext context) {


    options = widget.poll.getOptions();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.poll.title),
      ),
      body: Column(
        children: [
          ReorderableListView(
            shrinkWrap: true, // use this

            header: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                            style: TextStyle(
                              fontSize: 17,
                            )
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                        widget.poll.description,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        )),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                        ),
                        SizedBox(width: 2),
                        Flexible(
                          child: const Text(
                              'Long Press and drag the options to sort by the order of preference',
                              style: TextStyle(
                                fontSize: 17,
                              )
                          ),
                        ),
                      ],
                    ),

                    /*Column(
                        children: options.map((voteOption) => VoteOptionCard(option: voteOption)).toList(),
                      ),*/
                  ]
              ),
            ),
            onReorder: (int oldIndex, int newIndex) { setState(() {
              if(newIndex>oldIndex){
                newIndex-=1;
              }
              final option =options.removeAt(oldIndex);
              options.insert(newIndex, option);
            });
            },
            /*children: <Widget> [
                for(int index=0; index<options.length; index++)
                  Card(
                      key: Key('$index'),
                      child: ListTile(
                        title: Text(
                            options[index].title,
                            style:TextStyle(fontSize: 20)
                        ),
                        subtitle: Text(
                            options[index]. description,
                            style:TextStyle(fontSize: 17)),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        trailing: Icon(Icons.drag_indicator),
                        //leading: const Icon(Icons.work,color: Colors.blue,)
                      ),
                  )
              ]*/
            children: options.map((voteOption) => DragVoteOptionCard(option: voteOption, key: ValueKey(voteOption),)).toList(),
            //trailing is out of the screen!!!

            /*options.map(() => Container(
                  key: ValueKey(option),
                  child: ListTile(
                      title: Text(option.title),
                      leading: const Icon(Icons.work,color: Colors.blue,)
                  )
              )
              ).toList(),*/
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: (){
                for(int i=0; i<options.length; i++) {
                  //print position;
                }
                Navigator.pop(context, widget.poll.title);
                updateData();
              },
              child: Text(
                'Done',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),

    );
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