/// An extended package of `RichTrexPackage`. This package is used to decode [TextSpan] from encoded [String].
library richtrex_format;

import 'package:flutter/material.dart';
import 'package:richtrex_format/src/regex_matcher.dart';
import 'package:url_launcher/link.dart';
import 'package:richtrex_image/richtrex_image.dart';

part 'src/richtrex_span.dart';

/// A tool to decode [TextSpan] from encoded [String].
class RichTrexFormat extends Object {
  static String encode(List<RichTrexSpan> children) {
    return List.generate(children.length, (x) => children[x].encode)
        .toString()
        .replaceAll(RegExp(r"\[|\]|,"), "");
  }

  static TextSpan decode(String text,
      [TextStyle style = const TextStyle(color: Colors.black)]) {
    return text.decode(style);
  }
}
