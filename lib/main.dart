import 'dart:io';

import 'package:app2/constants.dart';
import 'package:app2/db/db.dart';
import 'package:app2/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app2/moodlist.dart';



void main() => runApp(MyApp());

 Widget _title(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            new Text('Moodify',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: _title(context),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice,) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: RaisedButton(
                        onPressed: () { deleteDB(context); },
                        child: Text(choice),
                      ),
                    );
                  }).toList();
                },
              ),     
              //PopupMenuButton<String> {
              //  onSelected: choiceAction,
              //}
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.add)),
                Tab(icon: Icon(Icons.history))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              MyHomePage(),
              MoodList(),
            ],
          ),
        //floatingActionButton: FloatingActionButton.extended(
        //onPressed: _saveText,
        //tooltip: 'Add',
        //icon: Icon(Icons.add_circle),
        //label: Text("Add"),
        //),
        ),
      ),
    );
  }
}

void choiceAction(String choice) {
  if(choice == Constants.dbDelete) {
    print("Db deleted");
  }
  else if (choice == Constants.extra)
  {
    print("Extra..");
  }
}

void deleteDB(BuildContext context) async {
    var db = new DatabaseHelper();
    db.deleteDB();
}

