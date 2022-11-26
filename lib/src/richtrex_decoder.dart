import 'package:flutter/material.dart';
import 'package:richtrex_image/richtrex_image.dart';
import 'package:richtrex_span/richtrex_span.dart';
import 'package:richtrex_span/src/regex_matcher.dart';

export 'richtrex_decoder.dart' hide RichTrexDecoder;

class RichTrexDecoder {
  const RichTrexDecoder(this.value);
  final String value;

  RichTrexSpan get parse {
    if (parseImage(value) != null) {
      return RichTrexWidget.image(parseImage(value)!);
    } else if (parseAlign(value) != null ||
        parseBlockquote(value) == true ||
        parseHyperlink(value) != null ||
        parsePadding(value) != null) {
      return RichTrexWidget(parseText(value),
          align: parseAlign(value),
          backgroundColor: parseBackgroundColor(value),
          blockquote: parseBlockquote(value),
          color: parseColor(value),
          fontFamily: parseFontFamily(value),
          fontSize: parseFontSize(value),
          fontWeight: parseFontWeight(value),
          horizontalSpace: parseHorizontalSpace(value),
          hyperlink: parseHyperlink(value),
          italic: parseItalic(value),
          overline: parseOverline(value),
          padding: parsePadding(value),
          shadow: parseShadow(value),
          strikeThrough: parseStrikeThrough(value),
          underline: parseUnderline(value),
          verticalSpace: parseVerticalSpace(value));
    } else {
      return RichTrexStyle(parseText(value),
          backgroundColor: parseBackgroundColor(value),
          color: parseColor(value),
          fontFamily: parseFontFamily(value),
          fontSize: parseFontSize(value),
          fontWeight: parseFontWeight(value),
          horizontalSpace: parseHorizontalSpace(value),
          italic: parseItalic(value),
          overline: parseOverline(value),
          shadow: parseShadow(value),
          strikeThrough: parseStrikeThrough(value),
          underline: parseUnderline(value),
          verticalSpace: parseVerticalSpace(value));
    }
  }

  static String parseText(String value) => value.replaceAll(
      RegExp(r'<style=".*?;">|<\/style>|<widget=".*?;"\/>'), "");

  static Color? parseColor(String value) {
    try {
      String? linked = value.matchWith(r'(?<=hyperlink:).*?(?=;)');
      bool quoted = value.contains('decoration:blockquote;');
      if (linked != null) {
        return Colors.blue.shade700;
      } else if (quoted == true) {
        return Colors.grey.shade600;
      } else {
        String text = value.matchWith(r'(?<=font-color:).*?(?=;)')!;
        return Color(int.parse(text));
      }
    } catch (e) {
      return null;
    }
  }

  static Color? parseBackgroundColor(String value) {
    try {
      String text = value.matchWith(r'(?<=background-color:).*?(?=;)')!;
      return Color(int.parse(text));
    } catch (e) {
      return null;
    }
  }

  static FontWeight? parseFontWeight(String value) {
    try {
      String text = value.matchWith(r'(?<=font-weight:).*?(?=;)')!;
      return FontWeight.values[int.parse(text)];
    } catch (e) {
      return null;
    }
  }

  static double? parseFontSize(String value) {
    try {
      String text = value.matchWith(r'(?<=font-size:).*?(?=;)')!;
      return double.parse(text);
    } catch (e) {
      return null;
    }
  }

  static String? parseFontFamily(String value) {
    try {
      String text = value.matchWith(r'(?<=font-family:).*?(?=;)')!;
      return text;
    } catch (e) {
      return null;
    }
  }

  static double? parseHorizontalSpace(String value) {
    try {
      String text = value.matchWith(r'(?<=horizontal-space:).*?(?=;)')!;
      return double.parse(text);
    } catch (e) {
      return null;
    }
  }

  static double? parseVerticalSpace(String value) {
    try {
      String text = value.matchWith(r'(?<=vertical-space:).*?(?=;)')!;
      return double.parse(text);
    } catch (e) {
      return null;
    }
  }

  static Shadow? parseShadow(String value) {
    try {
      String color = value.matchWith(r'(?<=shadow-color:).*?(?=;)')!;
      String blur = value.matchWith(r'(?<=shadow-blur:).*?(?=;)')!;
      String vertical =
          value.matchWith(r'(?<=shadow-vertical:).*?(?=;)') ?? "0";
      String horizontal =
          value.matchWith(r'(?<=shadow-horizontal:).*?(?=;)') ?? "0";
      return Shadow(
          color: Color(int.parse(color)),
          blurRadius: double.parse(blur),
          offset: Offset(double.parse(horizontal), double.parse(vertical)));
    } catch (e) {
      return null;
    }
  }

  static bool parseItalic(String value) {
    return value.contains('decoration:italic;');
  }

  static bool parseStrikeThrough(String value) {
    return value.contains('decoration:strikethrough;');
  }

  static bool parseUnderline(String value) {
    return value.contains('decoration:underline;');
  }

  static bool parseOverline(String value) {
    return value.contains('decoration:overline;');
  }

  static bool parseBlockquote(String value) {
    return value.contains('decoration:blockquote;');
  }

  static EdgeInsetsGeometry? parsePadding(String value) {
    try {
      bool quoted = value.contains('decoration:blockquote;');
      if (quoted == true) {
        return const EdgeInsets.all(4.0);
      } else {
        String? left = value.matchWith(r'(?<=padding-left:).*?(?=;)');
        String? right = value.matchWith(r'(?<=padding-right:).*?(?=;)');
        String? top = value.matchWith(r'(?<=padding-top:).*?(?=;)');
        String? bottom = value.matchWith(r'(?<=padding-bottom:).*?(?=;)');
        return EdgeInsets.fromLTRB(
            left == null ? 0 : double.parse(left),
            top == null ? 0 : double.parse(top),
            right == null ? 0 : double.parse(right),
            bottom == null ? 0 : double.parse(bottom));
      }
    } catch (e) {
      return null;
    }
  }

  static AlignmentGeometry? parseAlign(String value) {
    try {
      String? x = value.matchWith(r'(?<=align-x:).*?(?=;)');
      String? y = value.matchWith(r'(?<=align-y:).*?(?=;)');
      if (x == null && y == null) {
        return null;
      } else {
        return Alignment(
            x == null ? 0 : double.parse(x), y == null ? 0.0 : double.parse(y));
      }
    } catch (e) {
      return null;
    }
  }

  static String? parseHyperlink(String value) {
    return value.matchWith(r'(?<=hyperlink:).*?(?=;)');
  }

  static bool parseBreakline(String value) {
    return value.contains(RegExp("\n|<br>"));
  }

  static RichTrexImage? parseImage(String value) {
    if (value.contains(RegExp(r'<widget=".*?/>'))) {
      try {
        String? file = value.matchWith('(?<=image-file:).*?(?=;)');
        String? width = value.matchWith('(?<=image-width:).*?(?=;)');
        String? asset = value.matchWith('(?<=image-asset:).*?(?=;)');
        String? memory = value.matchWith('(?<=image-memory:).*?(?=;)');
        String? resize = value.matchWith('(?<=image-resize:).*?(?=;)');
        String? height = value.matchWith('(?<=image-height:).*?(?=;)');
        String? network = value.matchWith('(?<=image-network:).*?(?=;)');
        // Parsed [size] from [width] and [height].
        Size size =
            Size(double.parse(width ?? "100"), double.parse(height ?? "100"));
        // Check whether user allowed to resize or not.
        bool allowed = resize == null ? true : resize == "true";
        if (network != null) {
          return RichTrexImage.network(network, size: size, resize: allowed);
        } else if (memory != null) {
          return RichTrexImage.memory(memory, size: size, resize: allowed);
        } else if (file != null) {
          return RichTrexImage.file(file, size: size, resize: allowed);
        } else if (asset != null) {
          return RichTrexImage.asset(asset, size: size, resize: allowed);
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
