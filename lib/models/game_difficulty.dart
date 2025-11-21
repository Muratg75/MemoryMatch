enum GameDifficulty {
  easy('Kolay', 8, 4, 2),
  medium('Orta', 12, 4, 3),
  hard('Zor', 16, 4, 4),
  expert('Uzman', 20, 5, 4),
  professional('Profesyonel', 32, 8, 4);

  const GameDifficulty(
      this.displayName, this.totalCards, this.rows, this.columns);

  final String displayName;
  final int totalCards;
  final int rows;
  final int columns;
}
