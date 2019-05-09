import 'package:app2/constants.dart'; 


class MoodLog {

  //For first iteration, I'm going to play only with text description.
  //TODO: People can record audio message or something for that.

  int id;
  Mood _mood;
  String _moodStatus;

  MoodLog(this._mood, this._moodStatus);

  MoodLog.map(dynamic obj) {
    this._mood = obj["mood"];
    this._moodStatus = obj["moodStatus"];
  }

  String get moodStatus => _moodStatus;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["mood"] = _mood.toString();
    map["moodStatus"] = _moodStatus.toString();
    return map;
  }

  String setMoodId(DateTime timestamp) {
    String dateSlug = "${timestamp.toUtc().year.toString()}";
    dateSlug += "${timestamp.toUtc().month.toString().padLeft(2,'0')}";
    dateSlug += "${timestamp.toUtc().day.toString().padLeft(2,'0')}";
    dateSlug += "${timestamp.toUtc().hour.toString().padLeft(2, '0')}";
    dateSlug += "${timestamp.toUtc().minute.toString().padLeft(2, '0')}";
    dateSlug += "${timestamp.toUtc().second.toString().padLeft(2, '0')}";
    //print(dateSlug);
    return dateSlug;
  }
}