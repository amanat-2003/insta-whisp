import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:insta_whisp/views/components/rich_text/link_text.dart';
import 'package:insta_whisp/views/login/base_text_list.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    Key? key,
    this.styleForAll,
  }) : super(key: key);

  final TextStyle? styleForAll;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: BaseTextList.baseTextList.map((baseText) {
          if (baseText is LinkText) {
            return TextSpan(
              text: baseText.str,
              recognizer: TapGestureRecognizer()..onTap = baseText.onTapped,
              style: styleForAll?.merge(baseText.textStyle),
            );
          } else {
            return TextSpan(
              text: baseText.str,
              style: styleForAll?.merge(baseText.textStyle),
            );
          }
        }).toList(),
      ),
    );
  }
}
