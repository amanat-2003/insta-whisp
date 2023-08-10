import 'package:flutter/material.dart';
import 'package:insta_whisp/extensions/string/remove_all.dart';

extension ColorFromHex on String {
  Color hexToColor() => Color(
        int.parse(
          removeAll([
            '0x',
            '#',
          ]).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
}
