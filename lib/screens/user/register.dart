import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guessGame/screens/user/photo_upload.dart';
import 'package:guessGame/widgets/button.dart';
import 'package:guessGame/widgets/step_indicator.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordAgainController = TextEditingController();
  final _emailController = TextEditingController();

  String _usernameErrorMessage;
  String _passwordErrorMessage;
  String _passwordAgainErrorMessage;
  String _emailErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Container(
          child: Text(
            AppLocalizations.of(context).register,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                child: StepIndicator(
                  stepCount: 3,
                  currentStep: 1,
                ),
              ),
              Form(
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[500]),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              errorText: _usernameErrorMessage,
                              hintText: 'Username',
                            ),
                          ),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText: _passwordErrorMessage,
                              hintText: 'Password',
                            ),
                          ),
                          TextField(
                            controller: _passwordAgainController,
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText: _passwordAgainErrorMessage,
                              hintText: 'Repeat password',
                            ),
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              errorText: _emailErrorMessage,
                              hintText: 'Email',
                            ),
                          ),
                          CustomButton(
                            color: Color(0xFF56CD4D),
                            text: AppLocalizations.of(context).next,
                            func: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PhotoUpload(),
                                ),
                              );
                            },
                            icon: Icons.arrow_forward_ios,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
