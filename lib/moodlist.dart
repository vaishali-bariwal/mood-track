// SecondScreen.dart

import 'package:flutter/material.dart';
import 'package:app2/db/model/moodlog.dart';
import 'package:app2/db/db.dart';

import 'package:app2/home_presenter.dart';



class MoodList extends StatelessWidget {
  List<MoodLog> mlogs;
  HomePresenter homePresenter;

  var db = new DatabaseHelper();

  
  Future<List<MoodLog>> getMoodLog() {
    return db.getMoodLog();
  }

  @override
  Widget build(BuildContext context) {

    return new Text(
      "todo: welcome to tab 2"
    );

    /* return new FutureBuilder<List<MoodLog>>(
        future: homePresenter.getMoodLog(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var data = snapshot.data;
          return snapshot.hasData
              ? new History(data,homePresenter)
              : new Center(child: new CircularProgressIndicator());
        },
      ); */
  }

  displayRecord() {
    homePresenter.updateScreen();
  }


  String getStatus(MoodLog mlog) {
    String shortName = "";
    if (!mlog.moodStatus.isEmpty) {
      shortName = mlog.moodStatus.substring(0, 1) + ".";
    }
    return shortName;
  }
}