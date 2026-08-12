import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/game_category.dart';
import '../models/game_difficulty.dart';
import '../models/score_model.dart';
import '../services/score_service.dart';
import 'game_screen.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../widgets/animated_background.dart';
import '../widgets/glass_container.dart';
import '../widgets/game_button.dart';
import '../theme/app_theme.dart';

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
        case 'easy': return 'Kolay';
        case 'medium': return 'Orta';
        case 'hard': return 'Zor';
        case 'expert': return 'Uzman';
        case 'professional': return 'Profesyonel';
      }
    } else {
      switch (keyName) {
        case 'easy': return 'Easy';
        case 'medium': return 'Medium';
        case 'hard': return 'Hard';
        case 'expert': return 'Expert';
        case 'professional': return 'Professional';
      }
    }
    return keyName;
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

  Future<void> _loadUserScore() async {
    final score = await ScoreService.loadScore();
    setState(() {
      userScore = score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: selectedCategory == null
                        ? _buildStep1(key: const ValueKey('step1'))
                        : _buildStep2(key: const ValueKey('step2')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1({Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.selectCategory,
          style: AppTheme.displayMedium,
        ).animate().fadeIn().slideX(),
        
        const SizedBox(height: 16),
        
        ...GameCategory.values.asMap().entries.map((entry) {
          return _buildCategoryCard(entry.value, entry.key);
        }),
      ],
    );
  }

  Widget _buildStep2({Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => setState(() => selectedCategory = null),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.selectDifficulty,
                style: AppTheme.displayMedium,
              ),
            ),
          ],
        ).animate().fadeIn().slideX(),
        
        const SizedBox(height: 24),
        
        _buildDifficultySelector(),
      ],
    );
  }

  Widget _buildTopBar() {
    return GlassContainer(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.psychology,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)!.appTitle,
                style: AppTheme.bodyLarge,
              ),
            ],
          ),
          Row(
            children: [
              if (userScore != null) ...[
                _buildScoreItem(
                  icon: Icons.stars_rounded,
                  label: AppLocalizations.of(context)!.total,
                  value: userScore!.totalScore.toString(),
                ),
                const SizedBox(width: 12),
              ],
              _buildLanguageMenu(),
            ],
          ),
        ],
      ),
    ).animate().slideY(begin: -1, end: 0, duration: 500.ms, curve: Curves.easeOutBack);
  }

  Widget _buildScoreItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(
              value,
              style: AppTheme.bodyLarge.copyWith(fontSize: 16),
            ),
            const SizedBox(width: 4),
            Icon(icon, color: AppTheme.tertiaryColor, size: 16),
          ],
        ),
        Text(
          label,
          style: AppTheme.bodyMedium.copyWith(fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildLanguageMenu() {
    return PopupMenuButton<String>(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.language, color: Colors.white, size: 20),
      ),
      color: AppTheme.darkBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
          child: Text('Türkçe', style: AppTheme.bodyMedium),
        ),
        PopupMenuItem(
          value: 'en',
          child: Text('English', style: AppTheme.bodyMedium),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(GameCategory category, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => setState(() => selectedCategory = category),
        child: GlassContainer(
          padding: const EdgeInsets.all(16),
          opacity: 0.05,
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  _getCategoryIcon(category),
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  getCategoryName(category.name),
                  style: AppTheme.bodyLarge.copyWith(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white54,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildDifficultySelector() {
    return GlassContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: GameDifficulty.values.map((difficulty) {
          return InkWell(
            onTap: () {
              selectedDifficulty = difficulty;
              _startGame();
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getDifficultyName(difficulty.name),
                    style: AppTheme.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 18,
                    ),
                  ),
                  const Icon(
                    Icons.play_circle_fill_rounded,
                    color: AppTheme.primaryColor,
                    size: 28,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0);
  }

  IconData _getCategoryIcon(GameCategory category) {
    switch (category) {
      case GameCategory.fruits: return Icons.apple;
      case GameCategory.animals: return Icons.pets;
      case GameCategory.flags: return Icons.flag;
      case GameCategory.vegetables: return Icons.eco;
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
      await _loadUserScore();
      if (mounted) {
        setState(() {
          selectedCategory = null; // Oyun bitip ana ekrana dönüldüğünde kategori seçimiyle başlaması için
        });
      }
    }
  }
}
