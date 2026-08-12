import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2D2F41),
                Color(0xFF1F1D2B),
                Color(0xFF4834D4),
              ],
            ),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .shimmer(
          duration: 5.seconds,
          color: const Color(0xFF6C63FF).withOpacity(0.2),
          angle: 0.5,
        ),

        // Floating shapes for depth
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFF6584).withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6584).withOpacity(0.2),
                  blurRadius: 100,
                  spreadRadius: 20,
                ),
              ],
            ),
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .moveY(begin: 0, end: 50, duration: 4.seconds, curve: Curves.easeInOut),
        ),

        Positioned(
          bottom: -50,
          left: -50,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF43D9AD).withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF43D9AD).withOpacity(0.2),
                  blurRadius: 100,
                  spreadRadius: 20,
                ),
              ],
            ),
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .moveY(begin: 0, end: -50, duration: 5.seconds, curve: Curves.easeInOut),
        ),

        // Content
        child,
      ],
    );
  }
}
