import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final Function func;

  const CustomButton({
    Key key,
    @required this.color,
    @required this.text,
    this.icon,
    @required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: FlatButton(
        color: color,
        onPressed: () => func(),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  text.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            icon != null
                ? Icon(
                    icon,
                    size: 15,
                    color: Colors.white,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
