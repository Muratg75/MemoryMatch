import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/score_model.dart';

class ScoreService {
  static const String _scoreKey = 'user_score';

  // Puanları kaydet
  static Future<void> saveScore(ScoreModel score) async {
    final prefs = await SharedPreferences.getInstance();
    final scoreJson = jsonEncode(score.toJson());
    await prefs.setString(_scoreKey, scoreJson);
  }

  // Puanları yükle
  static Future<ScoreModel> loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    final scoreJson = prefs.getString(_scoreKey);

    if (scoreJson != null) {
      final scoreMap = jsonDecode(scoreJson) as Map<String, dynamic>;
      return ScoreModel.fromJson(scoreMap);
    }

    return ScoreModel.empty();
  }

  // Yeni oyun puanını ekle
  static Future<ScoreModel> addGameScore(int gameScore) async {
    final currentScore = await loadScore();
    final newTotalScore = currentScore.totalScore + gameScore;
    final newBestScore =
        gameScore > currentScore.bestScore ? gameScore : currentScore.bestScore;

    final updatedScore = currentScore.copyWith(
      totalScore: newTotalScore,
      gamesPlayed: currentScore.gamesPlayed + 1,
      bestScore: newBestScore,
      lastPlayed: DateTime.now(),
    );

    await saveScore(updatedScore);
    return updatedScore;
  }

  // Puanları sıfırla
  static Future<void> resetScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scoreKey);
  }
}
