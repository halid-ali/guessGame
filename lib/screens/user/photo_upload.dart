import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guessGame/data/database.dart';
import 'package:guessGame/data/models/user_model.dart';
import 'package:guessGame/screens/splash_screen.dart';
import 'package:guessGame/utils/constants.dart';
import 'package:guessGame/widgets/app_bar.dart';
import 'package:guessGame/widgets/fade_transition.dart';
import 'package:guessGame/widgets/step_indicator.dart';
import 'package:guessGame/widgets/button.dart';

class PhotoUpload extends StatefulWidget {
  final User user;
  PhotoUpload({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Constants.appBarHeight),
        child: CustomAppBar(title: AppLocalizations.of(context).upload_photo),
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
                          Container(
                            child: Text(
                              AppLocalizations.of(context).profile_picture,
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(30.0),
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.grey[700],
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 118,
                              ),
                            ),
                          ),
                          Text(AppLocalizations.of(context).upload_photo),
                          SizedBox(height: 30.0),
                          Text(AppLocalizations.of(context).take_picture),
                          SizedBox(height: 30.0),
                          CustomButton(
                            color: Color(0xFF56CD4D),
                            text: AppLocalizations.of(context).finish,
                            func: () {
                              var result = DatabaseProvider.dbProvider
                                  .addUser(widget.user);
                              print(result);
                              Navigator.push(
                                context,
                                FadeRouteTransition(
                                  page: SplashScreen(),
                                ),
                              );
                            },
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
