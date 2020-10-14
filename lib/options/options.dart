import 'package:flutter/cupertino.dart';

class Options {
  final int level;
  final bool isSameDigitAllowed;
  final bool isZeroStartAllowed;

  Options(
      {@required this.level,
      @required this.isSameDigitAllowed,
      @required this.isZeroStartAllowed});
}
