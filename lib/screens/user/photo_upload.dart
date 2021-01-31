import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhotoUpload extends StatefulWidget {
  PhotoUpload({Key key}) : super(key: key);

  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        actions: [],
        title: Container(
          child: Text(
            AppLocalizations.of(context).register,
          ),
        ),
      ),
      body: Container(
        child: Text('photo upload'),
      ),
    );
  }
}
