import 'package:flutter/material.dart';
import 'package:guessGame/data/database.dart';
import 'package:guessGame/data/models/user_model.dart';
import 'package:guessGame/generated/l10n.dart';
import 'package:guessGame/main.dart';
import 'package:guessGame/screens/user/register.dart';
import 'package:guessGame/screens/user/user_list.dart';
import 'package:guessGame/screens/game/game_main.dart';
import 'package:guessGame/utils/constants.dart';
import 'package:guessGame/widgets/app_bar.dart';
import 'package:guessGame/widgets/button.dart';
import 'package:guessGame/widgets/fade_transition.dart';
import 'package:guessGame/widgets/text_form_field.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController;
  List<User> _users = List<User>();
  String _selectedUser;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _populateUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Constants.appBarHeight),
          child: CustomAppBar(title: S.of(context).appTitle),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.translucent,
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          child: Container(
                            color: Colors.red,
                            child: Text('Logo is here'),
                          ),
                        ),
                        //Expanded(child: Container()),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedUser,
                          hint: Text(S.of(context).select_user),
                          items: _users.map((User user) {
                            return DropdownMenuItem<String>(
                              value: user.username,
                              child: Text(user.username),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              _selectedUser = value;
                            });
                            print(_selectedUser);
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          isRequired: true,
                          isObscureText: true,
                          hintText: S.of(context).password,
                          validateFunc: _validatePassword,
                          controller: _passwordController,
                        ),
                        //Expanded(child: Container()),
                        CustomButton(
                            color: Color(0xFF56CD4D),
                            text: S.of(context).sign_in,
                            func: () {
                              Navigator.push(
                                context,
                                FadeRouteTransition(page: GameMainScreen()),
                              );
                            },
                            icon: Icons.login_sharp),
                        SizedBox(height: 20),
                        Text('Not a user? Register'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                      S.of(context).settings,
                      () {},
                      Icons.settings_sharp,
                    ),
                    _getDivider(),
                    _getFlatMenu(
                      S.of(context).register,
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
                      S.of(context).users,
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
                      S.of(context).about,
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

  String _validatePassword(String password) {
    //in login screen password field doesn't require validation
    return '';
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

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }
}
