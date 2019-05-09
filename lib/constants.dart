
enum Mood { heart, happy, meh, frown, tear }

class Constants {
  static const String MoodHeading = 'What mood you are in';
  static const String dbDelete = 'deletedb';
  static const String extra = 'extra';

  static const List<String> choices = <String> [
    dbDelete,
    extra,
  ];
}
