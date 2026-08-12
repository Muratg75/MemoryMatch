import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'home_screen.dart';
import '../l10n/app_localizations.dart';
import '../widgets/animated_background.dart';
import '../widgets/glass_container.dart';
import '../widgets/game_button.dart';
import '../theme/app_theme.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Section
                  GlassContainer(
                    padding: const EdgeInsets.all(30),
                    borderRadius: BorderRadius.circular(40),
                    child: const Icon(
                      Icons.psychology,
                      size: 80,
                      color: AppTheme.primaryColor,
                    ),
                  )
                  .animate()
                  .scale(duration: 600.ms, curve: Curves.elasticOut)
                  .then()
                  .shimmer(duration: 2.seconds, delay: 1.seconds),

                  const SizedBox(height: 40),

                  // Title Section
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.appTitle,
                        style: AppTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
                      
                      const SizedBox(height: 10),
                      
                      Text(
                        AppLocalizations.of(context)!.subtitle,
                        style: AppTheme.displayMedium.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
                      
                      const SizedBox(height: 20),
                      
                      GlassContainer(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        child: Text(
                          AppLocalizations.of(context)!.tagline,
                          style: AppTheme.bodyMedium,
                        ),
                      ).animate().fadeIn(delay: 400.ms).scale(),
                    ],
                  ),

                  const SizedBox(height: 60),

                  // Play Button
                  GameButton(
                    text: AppLocalizations.of(context)!.playNow,
                    onPressed: () => _navigateToHome(context),
                    width: 250,
                    height: 65,
                    icon: Icons.play_arrow_rounded,
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.5, end: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
