import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guessGame/data/models/user_model.dart';
import 'package:guessGame/screens/user/photo_upload.dart';
import 'package:guessGame/utils/constants.dart';
import 'package:guessGame/widgets/app_bar.dart';
import 'package:guessGame/widgets/button.dart';
import 'package:guessGame/widgets/step_indicator.dart';
import 'package:guessGame/widgets/enter_exit_transition.dart';
import 'package:guessGame/widgets/text_form_field.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Constants.appBarHeight),
          child: CustomAppBar(title: AppLocalizations.of(context).register),
        ),
        backgroundColor: Colors.grey[200],
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
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
                            //Username
                            CustomTextFormField(
                              isRequired: true,
                              hintText: AppLocalizations.of(context).username,
                              iconData: Icons.account_box_rounded,
                              validateFunc: _validateUsername,
                              controller: _usernameContoller,
                            ),
                            SizedBox(height: 20),
                            //Password
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
                            //Password Repeat
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
                            //Email
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
                                  var _user = User(
                                    username: _usernameContoller.text,
                                    password: _passwordContoller.text,
                                    email: _emailContoller.text,
                                    registerDate: DateTime.now(),
                                    status: false,
                                    photo: null,
                                  );
                                  Navigator.push(
                                    context,
                                    EnterExitRouteTransition(
                                      exitPage: widget,
                                      enterPage: PhotoUpload(user: _user),
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
      ),
    );
  }

  String _validateUsername(String username) {
    if (username == null || username.isEmpty) {
      return AppLocalizations.of(context).username_empty;
    }

    if (username.length < 5 || username.length > 15) {
      return AppLocalizations.of(context).username_invalid_length;
    }

    return null;
  }

  String _validatePassword(String password) {
    if (password == null || password.isEmpty) {
      return AppLocalizations.of(context).password_empty;
    }

    if (password.length < 7 || password.length > 20) {
      return AppLocalizations.of(context).password_invalid_length;
    }

    var bufferPrefix = AppLocalizations.of(context).password_buffer_prefix;
    var buffer = StringBuffer();

    if (!password.contains(RegExp(r'[A-Z]'))) {
      buffer.write(AppLocalizations.of(context).password_contains_uppercase);
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      buffer.write(AppLocalizations.of(context).password_contains_lowercase);
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      buffer.write(AppLocalizations.of(context).password_contains_digit);
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      buffer.write(
          AppLocalizations.of(context).password_contains_special_character);
    }

    return buffer.isNotEmpty ? bufferPrefix + buffer.toString() : null;
  }

  String _validatePasswordRepeat(String password) {
    if (password != _passwordContoller.text) {
      return AppLocalizations.of(context).password_not_match;
    }

    if (_passwordRepeatContoller.text.isEmpty) {
      return '';
    }

    return null;
  }

  String _validateMail(String mail) {
    if (mail == null || mail.isEmpty) {
      return AppLocalizations.of(context).email_empty;
    }

    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    if (!RegExp(pattern).hasMatch(mail)) {
      return AppLocalizations.of(context).email_invalid;
    }

    return null;
  }
}
