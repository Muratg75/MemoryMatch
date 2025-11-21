import 'package:flutter/material.dart';
import '../models/game_category.dart';
import '../models/game_difficulty.dart';
import '../models/score_model.dart';
import '../services/score_service.dart';
import 'game_screen.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import 'dart:developer' as dev;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GameCategory? selectedCategory;
  GameDifficulty selectedDifficulty = GameDifficulty.easy;
  ScoreModel? userScore;

  @override
  void initState() {
    super.initState();
    _loadUserScore();
  }

  String getDifficultyName(String keyName) {
    if (AppLocalizations.of(context)!.localeName == 'tr') {
      switch (keyName) {
        case 'easy':
          return 'Kolay';
        case 'medium':
          return 'Orta';
        case 'hard':
          return 'Zor';
        case 'expert':
          return 'Uzman';
        case 'professional':
          return 'Profesyonel';
      }
    } else {
      switch (keyName) {
        case 'easy':
          return 'Easy';
        case 'medium':
          return 'Medium';
        case 'hard':
          return 'Hard';
        case 'expert':
          return 'Expert';
        case 'professional':
          return 'Professional';
      }
    }
    return keyName;
  }

  String getCategoryName(String keyName) {
    if (AppLocalizations.of(context)!.localeName == 'tr') {
      switch (keyName) {
        case 'fruits':
          return 'Meyveler';
        case 'vegetables':
          return 'Sebzeler';
        case 'animals':
          return 'Hayvanlar';
        case 'flags':
          return 'Bayraklar';
      }
    } else {
      switch (keyName) {
        case 'fruits':
          return 'Fruits';
        case 'vegetables':
          return 'Vegetables';
        case 'animals':
          return 'Animals';
        case 'flags':
          return 'Flags';
      }
    }
    return keyName;
  }

  Future<void> _loadUserScore() async {
    final score = await ScoreService.loadScore();
    setState(() {
      userScore = score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: ElevatedButton(
            onPressed: selectedCategory != null ? _startGame : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF667eea),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
            ),
            child: Text(
              AppLocalizations.of(context)!.startGame,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
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
              // Üst bar skor gösterimi
              _buildTopBar(),
              // Ana içerik
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Başlık
                        // Text(
                        //   AppLocalizations.of(context)!.appTitle,
                        //   style: const TextStyle(
                        //     fontSize: 32,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.white,
                        //     shadows: [
                        //       Shadow(
                        //         offset: Offset(2, 2),
                        //         blurRadius: 4,
                        //         color: Colors.black26,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(height: 4),
                        // Text(
                        //   AppLocalizations.of(context)!.subtitle,
                        //   style: const TextStyle(
                        //     fontSize: 24,
                        //     fontWeight: FontWeight.w300,
                        //     color: Colors.white70,
                        //   ),
                        // ),
                        const SizedBox(height: 8),

                        // Kategori Seçimi
                        Text(
                          AppLocalizations.of(context)!.selectCategory,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ...GameCategory.values
                            .map((category) => _buildCategoryCard(category))
                            .toList(),

                        const SizedBox(height: 10),

                        // Zorluk Seviyesi
                        Text(
                          AppLocalizations.of(context)!.selectDifficulty,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _buildDifficultySelector(),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Sol taraf - Logo ve başlık
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.psychology,
                  size: 20,
                  color: Color(0xFF667eea),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.appTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Sağ taraf - Skor bilgileri
          Row(
            children: [
              if (userScore != null) ...[
                _buildScoreItem(
                  icon: Icons.stars,
                  label: AppLocalizations.of(context)!.total,
                  value: userScore!.totalScore.toString(),
                ),
                const SizedBox(width: 16),
                _buildScoreItem(
                  icon: Icons.emoji_events,
                  label: AppLocalizations.of(context)!.best,
                  value: userScore!.bestScore.toString(),
                ),
                const SizedBox(width: 16),
                _buildScoreItem(
                  icon: Icons.games,
                  label: AppLocalizations.of(context)!.games,
                  value: userScore!.gamesPlayed.toString(),
                ),
                const SizedBox(width: 16),
              ],
              _buildLanguageMenu(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 16,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language, color: Colors.white),
      onSelected: (value) {
        if (value == 'tr') {
          MemoryMatchApp.of(context)?.setLocale(const Locale('tr'));
        } else if (value == 'en') {
          MemoryMatchApp.of(context)?.setLocale(const Locale('en'));
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'tr',
          child: Text(AppLocalizations.of(context)!.turkish),
        ),
        PopupMenuItem(
          value: 'en',
          child: Text(AppLocalizations.of(context)!.english),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(GameCategory category) {
    final isSelected = selectedCategory == category;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedCategory = category;
          });
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _getCategoryIcon(category),
                color: isSelected ? const Color(0xFF667eea) : Colors.white,
                size: 24,
              ),
              const SizedBox(width: 15),
              Text(
                getCategoryName(category.name),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? const Color(0xFF667eea) : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultySelector() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        textDirection: TextDirection.ltr,
        spacing: 0.0,
        children: GameDifficulty.values.map((difficulty) {
          late String difficultyName = getDifficultyName(difficulty.name);
          final isSelected = selectedDifficulty == difficulty;
          return RadioListTile<GameDifficulty>(
            value: difficulty,
            groupValue: selectedDifficulty,
            onChanged: (value) {
              setState(() {
                selectedDifficulty = value!;
              });
            },
            title: Text(
              difficultyName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            // subtitle: Text(
            //   '${difficulty.totalCards} kart',
            //   style: const TextStyle(
            //     color: Colors.white70,
            //   ),
            // ),
            activeColor: Colors.white,
            selected: isSelected,
          );
        }).toList(),
      ),
    );
  }

  IconData _getCategoryIcon(GameCategory category) {
    switch (category) {
      case GameCategory.fruits:
        return Icons.apple;
      case GameCategory.animals:
        return Icons.pets;
      case GameCategory.flags:
        return Icons.flag;
      case GameCategory.vegetables:
        return Icons.food_bank;
    }
  }

  Future<void> _startGame() async {
    if (selectedCategory != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameScreen(
            category: selectedCategory!,
            difficulty: selectedDifficulty,
          ),
        ),
      );
      // Oyun ekranından dönünce skoru tazele
      await _loadUserScore();
      setState(() {});
    }
  }
}
