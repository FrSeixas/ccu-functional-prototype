import 'package:ccu_proj/objectClasses/PollOption.dart';
import 'package:ccu_proj/objectClasses/PollTypes.dart';
import 'package:ccu_proj/objectClasses/VoteOption.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';


class CreatePollScreen extends StatefulWidget {

  final Function addpoll;

  const CreatePollScreen({Key? key, required this.addpoll}) : super(key: key);

  @override
  State<CreatePollScreen> createState() => _CreatePollScreen(addpoll);
}

class _CreatePollScreen extends State<CreatePollScreen>{
  late TextEditingController titleTextEditingController;
  late TextEditingController descriptionTextEditingController;
  final DatabaseReference _testRef = FirebaseDatabase(databaseURL: "https://ccu-prototype-default-rtdb.europe-west1.firebasedatabase.app").reference();

  _CreatePollScreen(Function addpoll){
    this.addpoll = addpoll;
  }
  late Function addpoll;



  @override
  void initState() {
    super.initState();
    titleTextEditingController = TextEditingController();
    descriptionTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    titleTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    super.dispose();
  }

  late String group;
  late String type;
  late String title;
  late String description;
  late String endDate;

  DateTime selectedDate = DateTime.now();
  var newFormat = DateFormat("yy-MM-dd");

  List <VoteOption> options = [];
  List<String> pollOptions = [];


  final _pollKey = GlobalKey<FormState>();
  final _optionKey = GlobalKey<FormState>();

  Widget _buildGroup(){
    String? groupDropdownValue;

    return DropdownButtonFormField<String>(
      value: groupDropdownValue,
      hint: Text('Groups'),
      icon: const Icon(Icons.arrow_downward),
      //elevation: 16,
      //style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? newValue) {
        setState(() {
          groupDropdownValue = newValue!;
        });
      },
      items: <String>['Freguesia do Areeiro', 'OldFellas']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Group is required';
        }
      },
      onSaved: (String? value) {
        group = value!;
      },
    );
  }

  Widget _buildType(){
    String? typeDropdownValue;

    return DropdownButtonFormField<String>(
      value: typeDropdownValue,
      hint: Text('Type'),
      icon: const Icon(Icons.arrow_downward),
      //elevation: 16,
      //style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? newValue) {
        setState(() {
          typeDropdownValue = newValue!;
        });
      },
      items: <String>['Type1', 'Type2']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Type is required';
        }
      },
      onSaved: (String? value) {
        type = value!;
      },
    );
  }
  Widget _buildTitle(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Title is required';
        }
      },
      onSaved: (String? value) {
        title = value!;
      },
    );
  }
  Widget _buildDescription(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Description'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Description is required';
        }
      },
      onSaved: (String? value) {
        description = value!;
      },
    );
  }
  Widget _buildEndDate(){
    return Column(
        children: [
          Row(
            children: [
              Text(
                'End Date',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
              Text(selectedDate.toString())
            ],
          ),
          Row(
            children: [
              IconButton(
                alignment: Alignment.centerLeft,
                onPressed:() {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  ).then((date) {
                    setState((){
                      selectedDate = date!;
                    });
                  }
                  );
                },
                icon: Icon(Icons.calendar_today),
              ),
            ],
          )
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new poll'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(40),
          child: Column(
            children: [
              Form(
                key: _pollKey,
                child: Column(
                  children: <Widget> [
                    _buildGroup(),
                    _buildType(),
                    _buildTitle(),
                    _buildDescription(),
                    _buildEndDate(),
                  ],
                ),
              ),
              SizedBox(height: 10),

              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Options',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 16,
                    ),
                  )
              ),

              ReorderableListView(
                shrinkWrap: true, // use this

                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final String item = pollOptions.removeAt(oldIndex);
                    pollOptions.insert(newIndex, item);
                  });
                },
                children: [
                  for (final item in options)
                    Card(
                        key: ValueKey(item),
                        elevation: 1,
                        child: ListTile(
                          title: Text(item.title),
                          subtitle: Text(item.description),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_forever),
                            onPressed: () {  },
                          ),
                        )
                    )
                ],
              ),

              Row(
                children: [
                  IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () async {
                      final newOptionString = await addPollOptionsDialog();
                      if(newOptionString == null ) return;

                      print(newOptionString);

                      setState(() {
                        VoteOption newOption = VoteOption(title: newOptionString[0], description: newOptionString[1]);
                        options.add(newOption);
                        pollOptions.add(newOptionString[0]);
                      });
                    },
                    icon: Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  child: Text('Create'),
                  onPressed: () {
                    if(!_pollKey.currentState!.validate())
                      return;

                    else if( pollOptions.isEmpty) {
                      final snackBar = SnackBar(
                        content: Text('Poll must have options to vote'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    else {
                      _pollKey.currentState!.save();
                      PollOption poll = PollOption(title: title,
                          description: description,
                          endDate: selectedDate.toString(),
                          group: group,
                          pollType: PollTypes.tokens,
                          options: options);
                      createRecord();
                      addpoll(poll);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>?> addPollOptionsDialog() => showDialog<List<String>> (
      context: context,
      builder: (context){
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
              content: Form(
                key: _optionKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleTextEditingController,
                      validator: (value){
                        return value!.isNotEmpty ? null : 'Invalid Field';
                      },
                      decoration: InputDecoration(hintText: "Title"),
                    ),
                    TextFormField(
                      controller: descriptionTextEditingController,
                      validator: (value){
                        return value!.isNotEmpty ? null : 'Invalid Field';
                      },
                      decoration: InputDecoration(hintText: "Description"),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Create'),
                  onPressed: (){
                    if(_optionKey.currentState!.validate()) {
                      List<String> optionInfo = [titleTextEditingController.text, descriptionTextEditingController.text];
                      Navigator.of(context).pop(optionInfo);
                      titleTextEditingController.clear();
                      descriptionTextEditingController.clear();
                    };
                  },
                )
              ]
          );
        });
      });
  void createRecord(){
    _testRef.child("polls/" + title).set({
      'title': title,
      'description': description,
      'group': group,
      'type': type,
      'endDate:': selectedDate.toString(),
      'options:': pollOptions,
      'votes': [""]
    });
  }
}