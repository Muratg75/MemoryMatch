import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:memory_match_game/main.dart';
import 'package:memory_match_game/screens/intro_screen.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('Basic smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text('Hello'))));
    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('App loads IntroScreen', (WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MemoryMatchApp());

    // Verify that the IntroScreen is displayed.
    expect(find.byType(IntroScreen), findsOneWidget);
    
    // Verify that the title is present (Memory Match)
    // Note: Since we use GlassContainer and other custom widgets, 
    // finding by text might need to ensure the text is rendered.
    // We'll just check if the IntroScreen widget is present for now as a smoke test.
  });
}
