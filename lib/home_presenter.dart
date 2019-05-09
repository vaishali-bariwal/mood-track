import 'package:app2/db/db.dart';
import 'package:app2/db/model/moodlog.dart';
import 'dart:async';

abstract class HomeContract {
  void screenUpdate();
}

class HomePresenter {

  HomeContract _view;

  var db = new DatabaseHelper();
  HomePresenter(this._view);
  
  /* delete(MoodLog mlog) {
    var db = new DatabaseHelper();
    db.deleteMoodLog(mlog);
    updateScreen();
  } */

  Future<List<MoodLog>> getMoodLog() {
    return db.getMoodLog();
  }

  updateScreen() {
    _view.screenUpdate();
  }
}