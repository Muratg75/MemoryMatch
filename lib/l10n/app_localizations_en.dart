// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Memory Match';

  @override
  String get subtitle => 'Memory Matching Game';

  @override
  String get rememberCards => 'Remember the cards!';

  @override
  String get startGame => 'START GAME';

  @override
  String get playNow => 'PLAY NOW';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get selectDifficulty => 'Select Difficulty';

  @override
  String get score => 'Score';

  @override
  String get moves => 'Moves';

  @override
  String get total => 'Total';

  @override
  String get best => 'Best';

  @override
  String get games => 'Games';

  @override
  String get congrats => 'Congratulations!';

  @override
  String get youFinished => 'You finished the game!';

  @override
  String get playAgain => 'Play Again';

  @override
  String get home => 'Home';

  @override
  String secondsLeft(Object seconds) {
    return '$seconds seconds left';
  }

  @override
  String get language => 'Language';

  @override
  String get turkish => 'Turkish';

  @override
  String get english => 'English';

  @override
  String get tagline => 'Remember and match the cards!';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get expert => 'Expert';

  @override
  String get restart => 'Restart';

  @override
  String get points => 'Points';
}
