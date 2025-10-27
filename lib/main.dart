import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MemoryMatchApp());
}

class MemoryMatchApp extends StatefulWidget {
  const MemoryMatchApp({super.key});

  static _MemoryMatchAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MemoryMatchAppState>();
  }

  @override
  State<MemoryMatchApp> createState() => _MemoryMatchAppState();
}

class _MemoryMatchAppState extends State<MemoryMatchApp> {
  Locale? _locale;

  static const String _prefsKeyLanguageCode = 'languageCode';

  @override
  void initState() {
    super.initState();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKeyLanguageCode);
    if (code != null && code.isNotEmpty) {
      setState(() {
        _locale = Locale(code);
      });
    }
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKeyLanguageCode, locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: const IntroScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
