import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guessGame/data/database.dart';
import 'package:guessGame/screens/user/register.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var db = DatabaseProvider.dbProvider.database;
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
                child: Text(
                  AppLocalizations.of(context).sign_in,
                ),
                onPressed: () {},
              ),
              RaisedButton(
                child: Text(
                  AppLocalizations.of(context).register,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
