import 'package:ccu_proj/objectClasses/PollList.dart';
import 'package:ccu_proj/objectClasses/PollTypes.dart';
import 'package:ccu_proj/objectClasses/VoteOption.dart';
import 'package:flutter/material.dart';
import 'package:ccu_proj/cards/pollOptionCard.dart';
import 'package:ccu_proj/objectClasses/PollOption.dart';


class HomeScreen extends StatefulWidget {
  final PollList polloptions;

  /*List<PollOption> options = [
    PollOption(
        title: 'Orçamento Participativo - Areeiro',
        description: 'Votação das propostas aprovadas para o orçamento participativo de fevereiro de 2022.',
        endDate: '2022-02-14',
        group: 'Freguesia do Areeiro',
        pollType: PollTypes.order,
        options: <VoteOption> [
          VoteOption(title: 'Prop1', description: "Description 1"),
          VoteOption(title: 'Prop2', description: "Description 2"),
          VoteOption(title: 'Prop3', description: "Description 3"),
          VoteOption(title: 'Prop4', description: "Description 4"),
        ]
    ),
    PollOption(
        title: 'Local de Jantar Pizzanight',
        description: 'Vamos reunir o pessoal para uma pizzanight e queremos escolher um sitio que seja conveniente a todos!',
        endDate: '2022-02-26',
        group: 'OldFellas',
        pollType: PollTypes.tokens,
        options: <VoteOption> [
          VoteOption(title: 'Lupita Pizzaria', description: "Description 1"),
          VoteOption(title: 'M´arrecreo Pizzeria', description: "Description 2"),
          VoteOption(title: 'Valdo Gatti Pizza Bio', description: "Description 3"),
          VoteOption(title: 'Primo Basílico', description: "Description 4"),
        ]
    ),
  ];*/

  HomeScreen({Key? key, required this.polloptions}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(polloptions);
}

class _HomeScreenState extends State<HomeScreen> {
  late PollList polloptions;
  _HomeScreenState(this.polloptions);

  @override
  Widget build(BuildContext context) {
    List<PollOption> options = polloptions.options;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Polls",
            style:TextStyle(
              fontSize: 26,
            )
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: <Widget>[
                  //order by button
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width:100,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Order by',
                                    style:TextStyle(
                                      fontSize: 16,
                                    )
                                ),
                                Icon(
                                    Icons.keyboard_arrow_down_outlined
                                ),
                              ]
                          )
                      )
                  ),
                  SizedBox(width: 5),
                  // search bar
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          width:200,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.search,
                                ),
                                Text('Search',
                                    style:TextStyle(
                                      fontSize: 16,
                                    )
                                ),
                              ]
                          )
                      )
                  ),
                  SizedBox(width: 5),
                  Column(
                    children: options.map((pollOption) => PollOptionCard(
                      option: pollOption,
                      remove_poll :(String title){
                        setState(() {
                          options.removeWhere((element) => element.title==title);
                        });
                      },
                    )).toList(),
                  ),
                  /*Column(
                  children: options.map((pollOption) {
                    return Text(pollOption.title);
                  }).toList(),
                )*/
                ],
              )
          ),
        ),
      ),

    );
  }
}
