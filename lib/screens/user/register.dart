import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guessGame/screens/user/photo_upload.dart';
import 'package:guessGame/widgets/button.dart';
import 'package:guessGame/widgets/step_indicator.dart';
import 'package:guessGame/widgets/enter_exit_transition.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordAgainController = TextEditingController();
  final _emailController = TextEditingController();

  Color _usernameSuffixIconColor = Colors.white;
  Color _passwordSuffixIconColor = Colors.white;
  Color _passwordAgainSuffixIconColor = Colors.white;
  Color _emailSuffixIconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    _usernameController.addListener(() {
      setState(() {
        _usernameSuffixIconColor =
            _validateUsername(_usernameController.text) == null
                ? Colors.green
                : Colors.white;
      });
    });
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
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _usernameController,
                            validator: _validateUsername,
                            decoration: InputDecoration(
                              errorMaxLines: 2,
                              helperText: '* Required(l10n)',
                              hintText: AppLocalizations.of(context).username,
                              icon: Icon(
                                Icons.account_box_rounded,
                                size: 33,
                                color: Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.check,
                                color: _usernameSuffixIconColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              errorMaxLines: 2,
                              helperText: '*Required(l10n)',
                              hintText: AppLocalizations.of(context).password,
                              icon: Icon(
                                Icons.lock_rounded,
                                size: 33,
                                color: Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.check,
                                color: _passwordSuffixIconColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _passwordAgainController,
                            obscureText: true,
                            decoration: InputDecoration(
                              errorMaxLines: 2,
                              helperText: '*Required(l10n)',
                              hintText:
                                  AppLocalizations.of(context).repeat_password,
                              icon: Icon(
                                Icons.lock_rounded,
                                size: 33,
                                color: Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.check,
                                color: _passwordAgainSuffixIconColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              errorMaxLines: 2,
                              helperText: '',
                              hintText: AppLocalizations.of(context).email,
                              icon: Icon(
                                Icons.email_rounded,
                                size: 33,
                                color: Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.check,
                                color: _emailSuffixIconColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          CustomButton(
                            color: Color(0xFF56CD4D),
                            text: AppLocalizations.of(context).next,
                            func: () {
                              Navigator.push(
                                context,
                                EnterExitRouteTransition(
                                  exitPage: widget,
                                  enterPage: PhotoUpload(),
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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();
    _emailController.dispose();
    super.dispose();
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
}
