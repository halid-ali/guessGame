import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Text(
            AppLocalizations.of(context).helloWorld,
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
    );
  }
}
