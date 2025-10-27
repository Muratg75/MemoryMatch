class ScoreModel {
  final int totalScore;
  final int gamesPlayed;
  final int bestScore;
  final DateTime lastPlayed;

  const ScoreModel({
    required this.totalScore,
    required this.gamesPlayed,
    required this.bestScore,
    required this.lastPlayed,
  });

  ScoreModel copyWith({
    int? totalScore,
    int? gamesPlayed,
    int? bestScore,
    DateTime? lastPlayed,
  }) {
    return ScoreModel(
      totalScore: totalScore ?? this.totalScore,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      bestScore: bestScore ?? this.bestScore,
      lastPlayed: lastPlayed ?? this.lastPlayed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalScore': totalScore,
      'gamesPlayed': gamesPlayed,
      'bestScore': bestScore,
      'lastPlayed': lastPlayed.toIso8601String(),
    };
  }

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    return ScoreModel(
      totalScore: json['totalScore'] ?? 0,
      gamesPlayed: json['gamesPlayed'] ?? 0,
      bestScore: json['bestScore'] ?? 0,
      lastPlayed: DateTime.parse(
          json['lastPlayed'] ?? DateTime.now().toIso8601String()),
    );
  }

  factory ScoreModel.empty() {
    return ScoreModel(
      totalScore: 0,
      gamesPlayed: 0,
      bestScore: 0,
      lastPlayed: DateTime.now(),
    );
  }
}
