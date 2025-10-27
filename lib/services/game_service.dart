import 'dart:math';
import '../models/game_category.dart';
import '../models/game_difficulty.dart';
import '../models/game_card.dart';

class GameService {
  // Her kategori için örnek görseller
  final Map<GameCategory, List<String>> _categoryImages = {
    //GameCategory.words: [], // Henüz görsel yok
    GameCategory.flags: [
      'arj.png',
      'au.png',
      'azr.png',
      'blr.png',
      'bosna.png',
      'br.png',
      'bulgar.png',
      'ca.png',
      'cameron.png',
      'cek.png',
      'cezayir.png',
      'cn.png',
      'de.png',
      'eg.png',
      'egypt.png',
      'es.png',
      'fr.png',
      'gb.png',
      'greece.png',
      'hrv.png',
      'iran.png',
      'iraq.png',
      'it.png',
      'jp.png',
      'jrd.png',
      'kktc.png',
      'krgz.png',
      'kzk.png',
      'mlz.png',
      'names.txt',
      'pak.png',
      'poland.png',
      'prtz.png',
      'roman.png',
      'russia.png',
      'sili.png',
      'swd.png',
      'tkr.png',
      'tr.png',
      'tunus.png',
      'ukr.png',
      'us.png',
      'uzk.png',
      'uzk.png',
    ],
    GameCategory.fruits: [
      'apple.jpg',
      'avocado.jpg',
      'banana.jpg',
      'blackberry.jpg',
      'cantaloupe.jpg',
      'fig.jpg',
      'grape.jpg',
      'kiwi.jpg',
      'mango.jpg',
      'nectarine.jpg',
      'orange.jpg',
      'peach.jpg',
      'pear.jpg',
      'pineapple.jpg',
      'plum.jpg',
      'strawberry.jpg',
      'tangelo.jpg',
      'watermelon.jpg',
    ],
    GameCategory.vegetables: [
      'artichoke.jpg',
      'asparagus.jpg',
      'cauliflower.jpg',
      'endive.jpg',
      'green_bell_pepper.jpg',
      'habanero.jpg',
      'kale.jpg',
      'lemon.jpg',
      'lime.jpg',
      'mushroom.jpg',
      'orange_bell_pepper.jpg',
      'persimmon.jpg',
      'potato.jpg',
      'radicchio.jpg',
      'radish.jpg',
      'squash.jpg',
      'tomato.jpg',
    ], // Henüz görsel yok
    GameCategory.animals: [
      'akrep.jpg',
      'akrep2.jpg',
      'apagan.jpg',
      'ari.jpg',
      'arslan.jpg',
      'at.jpg',
      'ayi.jpg',
      'baykus.jpg',
      'cekirge1.jpg',
      'cekirge2.jpg',
      'ceylan.jpg',
      'civciv.jpg',
      'deve.jpg',
      'fare.jpg',
      'fil.jpg',
      'gergedan.jpg',
      'horoz.jpg',
      'inek.jpg',
      'kanarya.jpg',
      'kaplan.jpg',
      'karasinek.jpg',
      'kartal.jpg',
      'kaz.jpg',
      'kedi.jpg',
      'kirkayak.jpg',
      'kopek.jpg',
      'kopekbaligi.jpg',
      'kugu.jpg',
      'kurbaga.jpg',
      'kurt.jpg',
      'kus1.jpg',
      'kus2.jpg',
      'kutupayisi.jpg',
      'kuzu.jpg',
      'leylek.jpg',
      'marti.jpg',
      'maymun.jpg',
      'orumcek.jpg',
      'panda.jpg',
      'panter.jpg',
      'pelikan.jpg',
      'penguen.jpg',
      'rakun.jpg',
      'sivrisinek.jpg',
      'solucan.jpg',
      'tavsan.jpg',
      'tilki.jpg',
      'yengec.jpg',
      'yilan1.jpg',
      'yilan2.jpg',
      'yilan3.jpg',
      'yunus.jpg',
      'yusufcuk.jpg',
      'zebra.jpg',
    ],
  };

  List<GameCard> generateCards(
      GameCategory category, GameDifficulty difficulty) {
    final availableImages = _categoryImages[category] ?? [];
    final neededPairs = difficulty.totalCards ~/ 2;

    // Yeterli görsel yoksa varsayılan görseller kullan
    final selectedImages = availableImages.length >= neededPairs
        ? availableImages.take(neededPairs).toList()
        : _generateDefaultImages(neededPairs);

    final cards = <GameCard>[];
    int cardId = 0;

    // Her görsel için iki kart oluştur
    for (final imageName in selectedImages) {
      final imagePath = '${category.assetPath}$imageName';
      cards.add(GameCard(
        imagePath: imagePath,
        id: cardId,
      ));
      cards.add(GameCard(
        imagePath: imagePath,
        id: cardId,
      ));
      cardId++;
    }

    // Kartları karıştır
    cards.shuffle(Random());

    return cards;
  }

  List<String> _generateDefaultImages(int count) {
    // Varsayılan görseller oluştur (gerçek uygulamada assets klasöründe olacak)
    return List.generate(count, (index) => 'default_${index + 1}.png');
  }

  int calculateScore(int moves, int totalCards) {
    // Daha az hamle ile tamamlanan oyunlar daha yüksek puan alır
    final baseScore = totalCards * 5;
    final movePenalty = moves * 2;
    return (baseScore - movePenalty).clamp(0, baseScore);
  }

  bool isGameCompleted(List<GameCard> cards) {
    return cards.every((card) => card.isMatched);
  }
}
