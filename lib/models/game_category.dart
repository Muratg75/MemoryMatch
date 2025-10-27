enum GameCategory {
  // words('Kelimeler', 'assets/images/words/'),
  fruits('Meyveler', 'assets/images/fruits/'),
  vegetables('Sebzeler', 'assets/images/vegetables/'),
  animals('Hayvanlar', 'assets/images/animals/'),
  flags('Bayraklar', 'assets/images/flags/');

  const GameCategory(this.displayName, this.assetPath);

  final String displayName;
  final String assetPath;
}
