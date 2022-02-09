import 'package:ccu_proj/objectClasses/PollList.dart';
import 'package:ccu_proj/objectClasses/PollOption.dart';
import 'package:ccu_proj/objectClasses/PollTypes.dart';
import 'package:ccu_proj/objectClasses/VoteOption.dart';
import 'package:ccu_proj/screens/createPollScreen.dart';
import 'package:ccu_proj/screens/homeScreen.dart';
import 'package:ccu_proj/screens/tokensVoteScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';
import 'firebase_options.dart';

import 'package:flutter/material.dart';


/*void main() => runApp(MaterialApp(
  home: VoteScreen(),
));*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      initialRoute: '/homeScreen',
      routes: {
        '/homeScreen': (context) => MainScreen(),
      }
  ));
}

class MainScreen extends StatefulWidget {

  List<PollOption> options = [
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
  ];

  PollList polloptions = PollList(options: [
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
  ]);
  MainScreen({Key? key}) : super(key: key);


  @override
  State<MainScreen> createState() => _MainScreenState(polloptions);
}

class _MainScreenState extends State<MainScreen> {

  _MainScreenState(this.options);
  PollList options;

  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(polloptions: this.options),
      CreatePollScreen(
          addpoll :(PollOption poll){
            setState(() {
              print(poll.title);
              options.addoptions(poll);
            });
          }
      )
    ];
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Colors.lightBlue,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_rounded),
            label: 'Create Poll',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
    );
  }
/*return MaterialApp(
        home: HomeScreen(),
             );*/
}

