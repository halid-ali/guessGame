import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:guessGame/generated/l10n.dart';
import 'package:guessGame/routes.dart';

void main() {
  runApp(GameApp());
}

class GameApp extends StatefulWidget {
  @override
  _GameAppState createState() => _GameAppState();

  static _GameAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_GameAppState>();
}

class _GameAppState extends State<GameApp> {
  Locale _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: RouteGenerator.homePage,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'CascadiaMonoPL'),
    );
  }
}
