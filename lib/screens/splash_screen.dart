import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guessGame/data/database.dart';
import 'package:guessGame/screens/user/register.dart';
import 'package:guessGame/screens/user/user_list.dart';
import 'package:guessGame/utils/constants.dart';
import 'package:guessGame/widgets/app_bar.dart';
import 'package:guessGame/widgets/fade_transition.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var db = DatabaseProvider.dbProvider.database;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Constants.appBarHeight),
          child: CustomAppBar(title: 'Splash Screen'),
        ),
        body: Center(
          child: Container(
            color: Colors.amber,
            child: Text(
              AppLocalizations.of(context).helloWorld,
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.pink,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  DrawerHeader(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: Text('Logo Here'),
                    ),
                  ),
                  getDivider(),
                  getFlatMenu(AppLocalizations.of(context).sign_in, () {}),
                  getDivider(),
                  getFlatMenu(AppLocalizations.of(context).register, () {
                    Navigator.push(
                      context,
                      FadeRouteTransition(
                        page: RegisterScreen(),
                      ),
                    );
                  }),
                  getDivider(),
                  getFlatMenu('Users(l10n)', () {
                    Navigator.push(
                      context,
                      FadeRouteTransition(
                        page: UserListScreen(),
                      ),
                    );
                  }),
                  getDivider(),
                  getFlatMenu('About(l10n)', () {}),
                  getDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getDivider() {
    return Divider(
      height: 5,
      thickness: 1,
      color: Colors.pink[700],
    );
  }

  Widget getFlatMenu(String title, Function func) {
    return Container(
      child: FlatButton(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        onPressed: func,
      ),
    );
  }
}
