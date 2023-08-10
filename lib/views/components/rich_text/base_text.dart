import 'package:flutter/material.dart'
    show Colors, TextDecoration, TextStyle, VoidCallback;
import 'package:insta_whisp/views/components/rich_text/link_text.dart';

class BaseText {
  final String str;
  final TextStyle? textStyle;

  const BaseText({
    required this.str,
    this.textStyle,
  });

  factory BaseText.plain({
    required String str,
    TextStyle? textStyle,
  }) =>
      BaseText(
        str: str,
        textStyle: textStyle,
      );

  factory BaseText.link({
    required String str,
    required VoidCallback onTap,
    TextStyle? textStyle = const TextStyle(
      decoration: TextDecoration.underline,
      color: Colors.blue,
    ),
  }) =>
      LinkText(
        onTapped: onTap,
        str: str,
        textStyle: textStyle,
      );
}
