import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guessGame/routes.dart';

void main() {
  runApp(GameApp());
}

class GameApp extends StatefulWidget {
  @override
  _GameAppState createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  bool isGameStarted = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: RouteGenerator.homePage,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'CascadiaMonoPL'),
    );
  }
}
