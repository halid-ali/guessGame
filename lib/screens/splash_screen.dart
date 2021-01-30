import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  child: Text(
                    AppLocalizations.of(context).helloWorld,
                    style: TextStyle(fontSize: 35),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context).sign_in,
                ),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context).register,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
