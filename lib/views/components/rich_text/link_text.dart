import 'package:flutter/material.dart';

import 'package:insta_whisp/views/components/rich_text/base_text.dart';

class LinkText extends BaseText {
  final VoidCallback onTapped;
  LinkText({
    required this.onTapped,
    required super.str,
    super.textStyle,
  });
}
