/// An extended package of `RichTrexPackage`. This package is used to decode [TextSpan] from encoded [String].
library richtrex_format;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:richtrex_format/src/regex_matcher.dart';
import 'package:url_launcher/link.dart';
import 'package:richtrex_image/richtrex_image.dart';

part 'src/richtrex_format_decode.dart';
part 'src/richtrex_format_encode.dart';

/// This is used as a tool to convert [String] into [TextSpan] or decoded [TextSpan] from [String].
class RichTrexFormat {
  static RichTrexFormatEncode encode() =>
      throw UnimplementedError("Feature Is Not Available");

  static RichTrexFormatDecode decode({required String text}) =>
      RichTrexFormatDecode(text);
}
