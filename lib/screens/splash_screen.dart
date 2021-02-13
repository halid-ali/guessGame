import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guessGame/data/database.dart';
import 'package:guessGame/data/models/user_model.dart';
import 'package:guessGame/screens/user/register.dart';
import 'package:guessGame/screens/user/user_list.dart';
import 'package:guessGame/utils/constants.dart';
import 'package:guessGame/widgets/app_bar.dart';
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
                hint: Text('Select User'),
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
                child: Text('Button is here'),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.black,
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
                  getFlatMenu(AppLocalizations.of(context).users, () {
                    Navigator.push(
                      context,
                      FadeRouteTransition(
                        page: UserListScreen(),
                      ),
                    );
                  }),
                  getDivider(),
                  getFlatMenu(AppLocalizations.of(context).about, () {}),
                  getDivider(),
                ],
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

  Widget getDivider() {
    return Divider(
      height: 5,
      thickness: 1,
      color: Colors.grey[700],
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
