import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guessGame/data/database.dart';
import 'package:guessGame/data/models/user_model.dart';
import 'package:guessGame/main.dart';
import 'package:guessGame/screens/user/register.dart';
import 'package:guessGame/screens/user/user_list.dart';
import 'package:guessGame/screens/game/game_main.dart';
import 'package:guessGame/utils/constants.dart';
import 'package:guessGame/widgets/app_bar.dart';
import 'package:guessGame/widgets/button.dart';
import 'package:guessGame/widgets/fade_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<User> _users = List<User>();
  User _selectedUser;

  @override
  void initState() {
    super.initState();
    _populateUsers();
    AppLocalizations.delegate.load(Locale('de'));
  }

  @override
  Widget build(BuildContext context) {
    _populateUsers();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Constants.appBarHeight),
          child: CustomAppBar(title: AppLocalizations.of(context).appTitle),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  color: Colors.red,
                  child: Text('Logo is here'),
                ),
              ),
              Expanded(child: Container()),
              DropdownButton<User>(
                value: _selectedUser,
                hint: Text(AppLocalizations.of(context).select_user),
                items: _users.map((User user) {
                  return DropdownMenuItem<User>(
                    value: user,
                    child: Text(user.username),
                  );
                }).toList(),
                onChanged: (User value) {
                  setState(() {
                    _selectedUser = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.blue,
                child: Text('Password box is here'),
              ),
              SizedBox(height: 20),
              CustomButton(
                  color: Color(0xFF56CD4D),
                  text: AppLocalizations.of(context).sign_in,
                  func: () {
                    Navigator.push(
                      context,
                      FadeRouteTransition(page: GameMainScreen()),
                    );
                  },
                  icon: Icons.login_sharp),
              Expanded(child: Container()),
            ],
          ),
        ),
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Drawer(
            child: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _getLanguageButton('EN', 'en'),
                            Text('|', style: TextStyle(color: Colors.white)),
                            _getLanguageButton('DE', 'de'),
                            Text('|', style: TextStyle(color: Colors.white)),
                            _getLanguageButton('TR', 'tr'),
                          ],
                        ),
                      ),
                    ),
                    DrawerHeader(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: Text('Logo Here'),
                      ),
                    ),
                    _getDivider(),
                    _getFlatMenu(
                      AppLocalizations.of(context).settings,
                      () {},
                      Icons.settings_sharp,
                    ),
                    _getDivider(),
                    _getFlatMenu(
                      AppLocalizations.of(context).register,
                      () {
                        Navigator.push(
                          context,
                          FadeRouteTransition(
                            page: RegisterScreen(),
                          ),
                        );
                      },
                      Icons.receipt_long_sharp,
                    ),
                    _getDivider(),
                    _getFlatMenu(
                      AppLocalizations.of(context).users,
                      () {
                        Navigator.push(
                          context,
                          FadeRouteTransition(
                            page: UserListScreen(),
                          ),
                        );
                      },
                      Icons.person_sharp,
                    ),
                    _getDivider(),
                    _getFlatMenu(
                      AppLocalizations.of(context).about,
                      () {},
                      Icons.info_outlined,
                    ),
                    _getDivider(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _populateUsers() async {
    var users = await DatabaseProvider.dbProvider.getUsers();
    setState(() {
      _users = users;
    });
  }

  Widget _getLanguageButton(String text, String countryCode) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () => GameApp.of(context)
          .setLocale(Locale.fromSubtags(languageCode: countryCode)),
    );
  }

  Widget _getDivider() {
    return Divider(
      height: 5,
      thickness: 1,
      color: Colors.grey[700],
    );
  }

  Widget _getFlatMenu(String title, Function func, IconData icon) {
    return Container(
      child: FlatButton(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(
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
            ),
            Icon(icon, color: Colors.white),
          ],
        ),
        onPressed: func,
      ),
    );
  }
}
