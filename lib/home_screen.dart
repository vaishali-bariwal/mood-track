import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app2/constants.dart'; 
import 'package:app2/home_presenter.dart';
import 'package:app2/db/model/moodlog.dart';
import 'package:app2/db/db.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements HomeContract {

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  TextEditingController textController = new TextEditingController();
  
  var currentMood = Mood.happy;

  @override
  void initState() {
    super.initState();
    //homePresenter = new HomePresenter(this);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2014),
      lastDate: new DateTime(2020)
    );

    if (picked != null && picked != _date) {
      print("Date selected is : ${_date.toString()}"); 

      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time
    );

    if (picked != null && picked != _time) {
      print("Date selected is : ${_date.toString()}"); 

      setState(() {
        _time = picked;
      });
    }
  }


  void _updateMoodIconBackground(Mood mood) {
    currentMood = mood;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: <Widget>[
          _dateTimeSelector(),
          new Divider(
          ),
          new Text(
            "What mood you are in ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )
          ),
          _moodIcons(),
          _moodTextBox(),
          new GestureDetector(
            onTap: () {
                addRecord();
              },
            child: new Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: _appBorderButton(
                  //isEdit?"Edit":"Add", EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                  "Save", 
                  EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
            ),
          ),
        ],
      );
  }

  Widget _dateTimeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RaisedButton(
          child: new Text("${_date.toLocal()}"),
          onPressed: (){_selectDate(context);}
        ),
        new RaisedButton(
          child: new Text("${_time.hour}:${_time.minute}"),
          onPressed: (){_selectTime(context);},
        ),
      ],
    );
  }
  
  Widget _moodTextBox() {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: "Write it up"
      ),          
      textAlign: TextAlign.center,
      maxLines: null,
    );   
  }
  
  Widget _moodIcons() {
    return Row (
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: new Icon(FontAwesomeIcons.grinHearts), 
          onPressed: () {_updateMoodIconBackground(Mood.heart);},
          iconSize: 45,
          color: currentMood ==Mood.heart ? Colors.orange[500] :null, 
        ),
        IconButton(
          icon: new Icon(FontAwesomeIcons.smileBeam), 
          onPressed: () {_updateMoodIconBackground(Mood.happy);},
          iconSize: 45,
          color: currentMood ==Mood.happy ? Colors.orange[400] :null,
        ),
        IconButton(
          icon: new Icon(FontAwesomeIcons.meh), 
          onPressed: () {_updateMoodIconBackground(Mood.meh);},
          color: currentMood == Mood.meh ? Colors.orange[300] :null,
          iconSize: 45,
        ),
        IconButton(
          icon: new Icon(FontAwesomeIcons.frown), 
          onPressed: () {_updateMoodIconBackground(Mood.frown);},
          color: currentMood == Mood.frown ? Colors.orange[200] :null,
          iconSize: 45,
        ),
        IconButton(
          icon: new Icon(FontAwesomeIcons.sadTear), 
          onPressed: () {_updateMoodIconBackground(Mood.tear);},
          color: currentMood == Mood.tear ? Colors.orange[100] :null,
          iconSize: 45,
        ),
      ],
    );
  }

  Widget _appBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }
  
  @override
  void screenUpdate() {
    setState(() {});
  }

  Future addRecord() async {
    var db = new DatabaseHelper();
    var moodLog = new MoodLog(currentMood, textController.text);
    moodLog.setMoodId(_date);
    await db.saveMoodLog(moodLog);
    showInSnackBar("Added moodlog");
    db.getMoodLog();
  }

  Future deleteDB() async {
    var db = new DatabaseHelper();
    db.deleteDB();
    showInSnackBar("Deleting database");
  }


  
  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  
}
