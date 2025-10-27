class GameCard {
  final String imagePath;
  final int id;
  bool isFlipped;
  bool isMatched;

  GameCard({
    required this.imagePath,
    required this.id,
    this.isFlipped = false,
    this.isMatched = false,
  });

  GameCard copyWith({
    String? imagePath,
    int? id,
    bool? isFlipped,
    bool? isMatched,
  }) {
    return GameCard(
      imagePath: imagePath ?? this.imagePath,
      id: id ?? this.id,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}
