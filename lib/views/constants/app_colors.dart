import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Colors;
import 'package:insta_whisp/extensions/string/hex_to_color.dart';

@immutable
class AppColors {
  static final loginButtonColor = '#cfc9c2'.hexToColor();
  static const loginButtonTextColor = Colors.black;
  static final googleColor = '#4285F4'.hexToColor();
  static final facebookColor = '#3b5998'.hexToColor();
  const AppColors._();
}
