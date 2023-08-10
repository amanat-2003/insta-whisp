import 'package:flutter/foundation.dart' show immutable;
import 'package:url_launcher/url_launcher.dart';

import 'package:insta_whisp/views/components/rich_text/base_text.dart';
import 'package:insta_whisp/views/constants/strings.dart';

@immutable
class BaseTextList {
  static List<BaseText> baseTextList = [
    BaseText.plain(str: Strings.dontHaveAnAccount),
    BaseText.plain(str: Strings.signUpOn),
    BaseText.link(
        str: Strings.google,
        onTap: () {
          launchUrl(Uri.parse(Strings.googleSignupUrl));
        })
  ];

  const BaseTextList._();
}
