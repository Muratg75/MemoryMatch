import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/game_category.dart';
import '../models/game_difficulty.dart';
import '../models/game_card.dart';
import '../services/game_service.dart';
import '../services/score_service.dart';
import '../l10n/app_localizations.dart';
import '../widgets/animated_background.dart';
import '../widgets/glass_container.dart';
import '../widgets/game_button.dart';
import '../theme/app_theme.dart';

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

  String getCategoryName(String keyName) {
    if (AppLocalizations.of(context)!.localeName == 'tr') {
      switch (keyName) {
        case 'fruits': return 'Meyveler';
        case 'vegetables': return 'Sebzeler';
        case 'animals': return 'Hayvanlar';
        case 'flags': return 'Bayraklar';
      }
    } else {
      switch (keyName) {
        case 'fruits': return 'Fruits';
        case 'vegetables': return 'Vegetables';
        case 'animals': return 'Animals';
        case 'flags': return 'Flags';
      }
    }
    return keyName;
  }

  IconData _getCategoryIcon(GameCategory category) {
    switch (category) {
      case GameCategory.fruits: return Icons.apple;
      case GameCategory.animals: return Icons.pets;
      case GameCategory.flags: return Icons.flag;
      case GameCategory.vegetables: return Icons.eco;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
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
    return GlassContainer(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.score}: $score',
                      style: AppTheme.bodyLarge,
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.moves}: $moves',
                      style: AppTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: isShowingCards,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Text(
              '$remainingSeconds',
              style: AppTheme.displayLarge.copyWith(
                fontSize: 32,
                color: AppTheme.secondaryColor,
              ),
            ).animate(onPlay: (c) => c.repeat()).scale(duration: 1.seconds),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getCategoryIcon(widget.category),
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      getCategoryName(widget.category.name),
                      style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: -1, end: 0);
  }

  Widget _buildGameBoard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        const horizontalPadding = 20.0;
        const verticalPadding = 10.0;
        const cardSpacing = 10.0;
        final availableWidth = screenWidth - (horizontalPadding * 2);
        final availableHeight = screenHeight - (verticalPadding * 2);
        final columns = widget.difficulty.columns;
        final rows = widget.difficulty.rows;
        final cardWidth = (availableWidth - (cardSpacing * (columns - 1))) / columns;
        final cardHeight = (availableHeight - (cardSpacing * (rows - 1))) / rows;
        final cardSize = cardWidth < cardHeight ? cardWidth : cardHeight;

        return Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: cardSpacing,
                mainAxisSpacing: cardSpacing,
                childAspectRatio: 1,
                mainAxisExtent: cardSize,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return _buildCard(index, showCard: isShowingCards, cardSize: cardSize);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard(int index, {bool showCard = false, double? cardSize}) {
    final card = cards[index];
    final isFlipped = showCard || card.isFlipped || card.isMatched;
    final size = cardSize ?? 100.0;
    final borderRadius = size * 0.15;
    final iconSize = size * 0.4;

    return GestureDetector(
      onTap: isGameStarted && !card.isMatched && !card.isFlipped
          ? () => _onCardTap(index)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutBack,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(isFlipped ? 0 : pi),
        transformAlignment: Alignment.center,
        child: isFlipped
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Image.asset(
                      card.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported_rounded,
                            size: iconSize,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(pi),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppTheme.mainGradient,
                    borderRadius: BorderRadius.circular(borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.question_mark_rounded,
                      color: Colors.white.withOpacity(0.8),
                      size: iconSize,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildFooter() {
    return GlassContainer(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GameButton(
            text: AppLocalizations.of(context)!.restart,
            icon: Icons.refresh_rounded,
            onPressed: _restartGame,
            width: 140,
            height: 50,
            color: AppTheme.secondaryColor,
          ),
          GameButton(
            text: AppLocalizations.of(context)!.home,
            icon: Icons.home_rounded,
            onPressed: () => Navigator.pop(context),
            width: 140,
            height: 50,
            color: AppTheme.primaryColor,
          ),
        ],
      ),
    ).animate().slideY(begin: 1, end: 0);
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
      setState(() {
        cards[flippedCards[0]] = card1.copyWith(isMatched: true);
        cards[flippedCards[1]] = card2.copyWith(isMatched: true);
        score += 10;
      });

      flippedCards.clear();

      if (_isGameCompleted()) {
        _showGameCompletedDialog();
      }
    } else {
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
    await ScoreService.addGameScore(score);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                size: 80,
                color: Colors.amber,
              ).animate().scale(curve: Curves.elasticOut, duration: 800.ms).shimmer(),
              
              const SizedBox(height: 20),
              
              Text(
                AppLocalizations.of(context)!.congrats,
                style: AppTheme.displayMedium.copyWith(color: AppTheme.secondaryColor),
              ),
              
              const SizedBox(height: 10),
              
              Text(
                AppLocalizations.of(context)!.youFinished,
                style: AppTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 20),
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildResultRow(AppLocalizations.of(context)!.score, '$score'),
                    const Divider(color: Colors.white24),
                    _buildResultRow(AppLocalizations.of(context)!.moves, '$moves'),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              GameButton(
                text: AppLocalizations.of(context)!.playAgain,
                icon: Icons.replay_rounded,
                onPressed: () {
                  Navigator.pop(context);
                  _restartGame();
                },
                width: double.infinity,
              ),
              
              const SizedBox(height: 10),
              
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.home,
                  style: AppTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTheme.bodyMedium),
        Text(
          value,
          style: AppTheme.bodyLarge.copyWith(color: AppTheme.tertiaryColor),
        ),
      ],
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
