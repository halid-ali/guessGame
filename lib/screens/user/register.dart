import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guessGame/screens/user/photo_upload.dart';
import 'package:guessGame/widgets/button.dart';
import 'package:guessGame/widgets/step_indicator.dart';
import 'package:guessGame/widgets/enter_exit_transition.dart';
import 'package:guessGame/widgets/textformfield.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameContoller = TextEditingController();
  final _passwordContoller = TextEditingController();
  final _passwordRepeatContoller = TextEditingController();
  final _emailContoller = TextEditingController();

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
                  stepCount: 2,
                  currentStep: 0,
                ),
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[500]),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CustomTextFormField(
                            isRequired: true,
                            hintText: AppLocalizations.of(context).username,
                            iconData: Icons.account_box_rounded,
                            validateFunc: _validateUsername,
                            controller: _usernameContoller,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            isRequired: true,
                            isObscureText: true,
                            errorLines: 5,
                            hintText: AppLocalizations.of(context).password,
                            iconData: Icons.lock_rounded,
                            validateFunc: _validatePassword,
                            controller: _passwordContoller,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            isRequired: true,
                            isObscureText: true,
                            hintText:
                                AppLocalizations.of(context).repeat_password,
                            iconData: Icons.lock_rounded,
                            validateFunc: _validatePasswordRepeat,
                            controller: _passwordRepeatContoller,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            isRequired: true,
                            hintText: AppLocalizations.of(context).email,
                            iconData: Icons.mail_rounded,
                            validateFunc: _validateMail,
                            controller: _emailContoller,
                          ),
                          SizedBox(height: 20.0),
                          CustomButton(
                            color: Color(0xFF56CD4D),
                            text: AppLocalizations.of(context).next,
                            func: () {
                              if (_formKey.currentState.validate()) {
                                Navigator.push(
                                  context,
                                  EnterExitRouteTransition(
                                    exitPage: widget,
                                    enterPage: PhotoUpload(),
                                  ),
                                );
                              }
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

  String _validateUsername(String username) {
    if (username == null || username.isEmpty) {
      return 'Username cannot be null.(l10n)';
    }

    if (username.length < 5 || username.length > 15) {
      return 'Username length must be between 5 and 15.(l10n)';
    }

    return null;
  }

  String _validatePassword(String password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be null.(l10n)';
    }

    if (password.length < 7 || password.length > 20) {
      return 'Password lenght must be between 7 and 20.(l10n)';
    }

    var bufferPrefix = 'Password must contain(l10n)';
    var buffer = StringBuffer();

    if (!password.contains(RegExp(r'[A-Z]'))) {
      buffer.write('\nat least one upper case letter(l10n)');
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      buffer.write('\nat least one lower case letter(l10n)');
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      buffer.write('\nat least one digit(l10n)');
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      buffer.write('\nat least one special character(l10n)');
    }

    return buffer.isNotEmpty ? bufferPrefix + buffer.toString() : null;
  }

  String _validatePasswordRepeat(String password) {
    if (password != _passwordContoller.text) {
      return 'Password doesn\'t match.(l10n)';
    }

    return null;
  }

  String _validateMail(String mail) {
    if (mail == null || mail.isEmpty) {
      return 'Mail cannot be null.(l10n)';
    }

    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    if (!RegExp(pattern).hasMatch(mail)) {
      return 'Invalid mail address.(l10n)';
    }

    return null;
  }
}
