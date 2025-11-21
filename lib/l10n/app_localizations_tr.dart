// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Hafıza Eşleştirme';

  @override
  String get subtitle => 'Hafıza Eşleştirme Oyunu';

  @override
  String get rememberCards => 'Kartları hatırla!';

  @override
  String get startGame => 'OYUNU BAŞLAT';

  @override
  String get playNow => 'ŞİMDİ OYNA';

  @override
  String get selectCategory => 'Kategori Seçin';

  @override
  String get selectDifficulty => 'Zorluk Seviyesi';

  @override
  String get score => 'Skor';

  @override
  String get moves => 'Hamle';

  @override
  String get total => 'Toplam';

  @override
  String get best => 'En İyi';

  @override
  String get games => 'Oyun';

  @override
  String get congrats => 'Tebrikler!';

  @override
  String get youFinished => 'Oyunu tamamladınız!';

  @override
  String get playAgain => 'Tekrar Oyna';

  @override
  String get home => 'Ana Menü';

  @override
  String secondsLeft(Object seconds) {
    return '$seconds saniye kaldı';
  }

  @override
  String get language => 'Dil';

  @override
  String get turkish => 'Türkçe';

  @override
  String get english => 'İngilizce';

  @override
  String get tagline => 'Kartları hatırla ve eşleştir!';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get expert => 'Expert';

  @override
  String get restart => 'Tekrar Başlat';

  @override
  String get points => 'Points';
}
