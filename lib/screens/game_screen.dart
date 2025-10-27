import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/game_category.dart';
import '../models/game_difficulty.dart';
import '../models/game_card.dart';
import '../models/score_model.dart';
import '../services/game_service.dart';
import '../services/score_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameScreen extends StatefulWidget {
  final GameCategory category;
  final GameDifficulty difficulty;

  const GameScreen({
    super.key,
    required this.category,
    required this.difficulty,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<GameCard> cards;
  late GameService gameService;
  int score = 0;
  int moves = 0;
  bool isGameStarted = false;
  bool isShowingCards = true;
  Timer? showCardsTimer;
  List<int> flippedCards = [];
  int remainingSeconds = 3;

  @override
  void initState() {
    super.initState();
    gameService = GameService();
    _initializeGame();
  }

  void _initializeGame() {
    cards = gameService.generateCards(widget.category, widget.difficulty);
    _startShowCardsTimer();
  }

  void _startShowCardsTimer() {
    remainingSeconds = 3;
    showCardsTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        remainingSeconds--;
      });

      if (remainingSeconds <= 0) {
        timer.cancel();
        setState(() {
          isShowingCards = false;
          isGameStarted = true;
        });
      }
    });
  }

  @override
  void dispose() {
    showCardsTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildGameBoard(),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Geri dön butonu
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          // Skor ve hamle sayısı
          Column(
            children: [
              Text(
                'Skor: $score',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Hamle: $moves',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          // Kategori
          Text(
            widget.category.displayName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameBoard() {
    if (isShowingCards) {
      return _buildShowCardsView();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Ekran boyutlarını al
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        // Padding ve spacing hesaplamaları
        const horizontalPadding = 20.0;
        const verticalPadding = 20.0;
        const cardSpacing = 10.0;

        // Kullanılabilir alan
        final availableWidth = screenWidth - (horizontalPadding * 2);
        final availableHeight = screenHeight - (verticalPadding * 2);

        // Grid boyutları
        final columns = widget.difficulty.columns;
        final rows = widget.difficulty.rows;

        // Kart boyutlarını hesapla
        final cardWidth =
            (availableWidth - (cardSpacing * (columns - 1))) / columns;
        final cardHeight =
            (availableHeight - (cardSpacing * (rows - 1))) / rows;

        // En küçük boyutu kullan (kare şeklinde kalmak için)
        final cardSize = cardWidth < cardHeight ? cardWidth : cardHeight;

        return Container(
          padding: const EdgeInsets.all(horizontalPadding),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: cardSpacing,
              mainAxisSpacing: cardSpacing,
              childAspectRatio: 1,
              mainAxisExtent: cardSize, // Sabit yükseklik belirle
            ),
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return _buildCard(index, cardSize: cardSize);
            },
          ),
        );
      },
    );
  }

  Widget _buildShowCardsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.rememberCards,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '$remainingSeconds saniye kaldı',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Ekran boyutlarını al
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;

              // Padding ve spacing hesaplamaları
              const horizontalPadding = 20.0;
              const verticalPadding = 20.0;
              const cardSpacing = 10.0;

              // Kullanılabilir alan
              final availableWidth = screenWidth - (horizontalPadding * 2);
              final availableHeight = screenHeight - (verticalPadding * 2);

              // Grid boyutları
              final columns = widget.difficulty.columns;
              final rows = widget.difficulty.rows;

              // Kart boyutlarını hesapla
              final cardWidth =
                  (availableWidth - (cardSpacing * (columns - 1))) / columns;
              final cardHeight =
                  (availableHeight - (cardSpacing * (rows - 1))) / rows;

              // En küçük boyutu kullan (kare şeklinde kalmak için)
              final cardSize = cardWidth < cardHeight ? cardWidth : cardHeight;

              return Container(
                padding: const EdgeInsets.all(horizontalPadding),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: cardSpacing,
                    mainAxisSpacing: cardSpacing,
                    childAspectRatio: 1,
                    mainAxisExtent: cardSize, // Sabit yükseklik belirle
                  ),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return _buildCard(index,
                        showCard: true, cardSize: cardSize);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(int index, {bool showCard = false, double? cardSize}) {
    final card = cards[index];
    final isFlipped = showCard || card.isFlipped || card.isMatched;

    // Kart boyutunu hesapla
    final size = cardSize ?? 100.0;
    final borderRadius = size * 0.1; // Kart boyutunun %10'u kadar border radius
    final iconSize = size * 0.3; // Kart boyutunun %30'u kadar icon boyutu

    return GestureDetector(
      onTap: isGameStarted && !card.isMatched && !card.isFlipped
          ? () => _onCardTap(index)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isFlipped ? Colors.white : const Color(0xFF4A5568),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: isFlipped
            ? ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image.asset(
                  card.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        size: iconSize,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF4A5568),
                      Color(0xFF2D3748),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.help_outline,
                  color: Colors.white70,
                  size: iconSize,
                ),
              ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: _restartGame,
            icon: const Icon(Icons.refresh),
            label: Text(AppLocalizations.of(context)!.restart),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF667eea),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.home),
            label: Text(AppLocalizations.of(context)!.home),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF667eea),
            ),
          ),
        ],
      ),
    );
  }

  void _onCardTap(int index) {
    if (flippedCards.length >= 2) return;

    setState(() {
      cards[index] = cards[index].copyWith(isFlipped: true);
      flippedCards.add(index);
    });

    if (flippedCards.length == 2) {
      moves++;
      _checkMatch();
    }
  }

  void _checkMatch() {
    final card1 = cards[flippedCards[0]];
    final card2 = cards[flippedCards[1]];

    if (card1.id == card2.id) {
      // Eşleşme bulundu
      setState(() {
        cards[flippedCards[0]] = card1.copyWith(isMatched: true);
        cards[flippedCards[1]] = card2.copyWith(isMatched: true);
        score += 10;
      });

      flippedCards.clear();

      // Oyun bitti mi kontrol et
      if (_isGameCompleted()) {
        _showGameCompletedDialog();
      }
    } else {
      // Eşleşme bulunamadı
      Timer(const Duration(milliseconds: 1000), () {
        setState(() {
          cards[flippedCards[0]] = card1.copyWith(isFlipped: false);
          cards[flippedCards[1]] = card2.copyWith(isFlipped: false);
        });
        flippedCards.clear();
      });
    }
  }

  bool _isGameCompleted() {
    return cards.every((card) => card.isMatched);
  }

  void _showGameCompletedDialog() async {
    // Puanı kaydet
    await ScoreService.addGameScore(score);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.congrats),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.youFinished),
            const SizedBox(height: 10),
            Text(AppLocalizations.of(context)!.score + ': $score'),
            Text(AppLocalizations.of(context)!.moves + ': $moves'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '+$score ${AppLocalizations.of(context)!.points}!',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _restartGame();
            },
            child: Text(AppLocalizations.of(context)!.playAgain),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.home),
          ),
        ],
      ),
    );
  }

  void _restartGame() {
    showCardsTimer?.cancel();
    setState(() {
      score = 0;
      moves = 0;
      flippedCards.clear();
      isGameStarted = false;
      isShowingCards = true;
      remainingSeconds = 5;
    });
    _initializeGame();
  }
}
