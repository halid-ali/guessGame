import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomTextFormField extends StatefulWidget {
  final bool isObscureText;
  final bool isRequired;
  final String hintText;
  final int errorLines;
  final IconData iconData;
  final Function validateFunc;
  final TextEditingController controller;

  CustomTextFormField({
    Key key,
    this.isObscureText = false,
    this.isRequired = false,
    this.errorLines = 2,
    @required this.hintText,
    this.iconData,
    this.validateFunc,
    @required this.controller,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  Color _suffixIconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(() {
      setState(() {
        _suffixIconColor = widget.validateFunc(widget.controller.text) == null
            ? Colors.green
            : Colors.white;
      });
    });
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isObscureText,
      validator: widget.validateFunc,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 9),
        errorMaxLines: widget.errorLines,
        helperText: widget.isRequired
            ? AppLocalizations.of(context).required_field
            : '',
        hintText: widget.hintText,
        icon: Icon(
          this.widget.iconData,
          size: 33,
          color: Colors.grey,
        ),
        suffixIcon: Icon(
          Icons.check,
          color: _suffixIconColor,
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
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
