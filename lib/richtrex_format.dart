/// An extended package of `RichTrexPackage`. This package is used to decode [TextSpan] from encoded [String].
library richtrex_format;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:richtrex_format/src/regex_matcher.dart';
import 'package:url_launcher/link.dart';
import 'package:richtrex_image/richtrex_image.dart';

part 'src/richtrex_span.dart';

/// A tool to decode [TextSpan] from encoded [String].
class RichTrexFormat extends TextSpan {
  static String encode(List<RichTrexSpan> children) {
    return List.generate(children.length, (x) => children[x].encode())
        .toString()
        .replaceAll(RegExp(r"\[|\]|,"), "");
  }

  /// A tool to decode [TextSpan] from encoded [String].
  ///
  /// ```dart
  /// String text = '<style="font-weight:bold;">Text</style>'
  /// TextSpan decoded = RichTrexFormatDecode(text);
  /// Text richtext = Text.rich(decoded);
  /// ```
  const RichTrexFormat.decode(String text,
      {Locale? locale,
      MouseCursor? mouseCursor,
      TextStyle style = const TextStyle(color: Colors.black),
      bool? spellOut,
      GestureRecognizer? recognizer,
      void Function(PointerEnterEvent)? onEnter,
      void Function(PointerExitEvent)? onExit,
      String? semanticsLabel})
      : super(
            text: text,
            locale: locale,
            mouseCursor: mouseCursor,
            style: style,
            spellOut: spellOut,
            recognizer: recognizer,
            onEnter: onEnter,
            onExit: onExit,
            semanticsLabel: semanticsLabel);

  /// This [text] is not used in [RichTrexFormat].
  @Deprecated("This text is not used in RichTrexFormat")
  @override
  String get text => "";

  /// Parse list of [String] from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="font-weight:8;">bold</style> text""";
  /// List<String> texted = textlist(text);
  /// print(texted); // ["It's a ","<style="font-weight:8;">bold</style>"," text"]
  /// ```
  static List<String> textlist(String text) => text.split(RegExp(
      r'(?=<style=")|(?<=<\/style>)|(?=\n)|(?<=\n)|(?=<br>)|(?<=<br>)|(?=<widget)|(?<="\/>)'));

  /// Parse clean [String] from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="font-weight:8;">bold</style> text""";
  /// String cleaned = string(text);
  /// print(cleaned) // It's a bold text
  /// ```
  static String toText(String text) => text.replaceAll(
      RegExp(r'<style=".*?;">|<\/style>|<br>|<widget=".*?;"\/>'), "");

  /// Parse [Color] from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="font-color:0xff4caf50;">colored</style> text""";
  /// Color? colored = color(text);
  /// Text widget = Text(text, style: TextStyle(color: colored))
  /// ```
  static Color? color(String text) {
    try {
      String? linked = text.matchWith(r'(?<=hyperlink:).*?(?=;)');
      bool quoted = text.contains('decoration:blockquote;');
      if (linked != null) {
        return Colors.blue.shade700;
      } else if (quoted == true) {
        return Colors.grey.shade600;
      } else {
        String value = text.matchWith(r'(?<=font-color:).*?(?=;)')!;
        return Color(int.parse(value));
      }
    } catch (e) {
      return null;
    }
  }

  /// Parse background color from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="font-color:0xff4caf50;">background colored</style> text""";
  /// Color? colored = backgroundColor(text);
  /// Text widget = Text(text, style: TextStyle(color: colored))
  /// ```
  static Color? backgroundColor(String text) {
    try {
      String value = text.matchWith(r'(?<=background-color:).*?(?=;)')!;
      return Color(int.parse(value));
    } catch (e) {
      return null;
    }
  }

  /// Parse [FontWeight] from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="font-weight:8;">bold</style> text""";
  /// FontWeight? bolded = fontWeight(text);
  /// Text widget = Text(text, style: TextStyle(fontWeight: bolded));
  /// ```
  static FontWeight? fontWeight(String text) {
    try {
      String value = text.matchWith(r'(?<=font-weight:).*?(?=;)')!;
      return FontWeight.values[int.parse(value)];
    } catch (e) {
      return null;
    }
  }

  /// Parse Font-Size from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="font-size:40;">big</style> text""";
  /// double? sized = fontSize(text);
  /// Text widget = Text(text, style: TextStyle(fontSize: sized));
  /// ```
  static double? fontSize(String text) {
    try {
      String value = text.matchWith(r'(?<=font-size:).*?(?=;)')!;
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  /// Parse Font-Family from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="font-family:Arial;">family</style> text""";
  /// double? styled = fontFamily(text);
  /// Text widget = Text(text, style: TextStyle(fontFamily: styled));
  /// ```
  static String? fontFamily(String text) {
    try {
      String value = text.matchWith(r'(?<=font-family:).*?(?=;)')!;
      return value;
    } catch (e) {
      return null;
    }
  }

  /// Parse horizontal space from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="horizontal-space:10;">wide</style> text""";
  /// double? wide = horizontalSpace(text);
  /// Text widget = Text(text, style: TextStyle(letterSpacing: wide));
  /// ```
  static double? horizontalSpace(String text) {
    try {
      String value = text.matchWith(r'(?<=horizontal-space:).*?(?=;)')!;
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  /// Parse vertical space from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="vertical-space:10;">tall</style> text""";
  /// double? tall = verticalSpace(text);
  /// Text widget = Text(text, style: TextStyle(height: tall));
  /// ```
  static double? verticalSpace(String text) {
    try {
      String value = text.matchWith(r'(?<=vertical-space:).*?(?=;)')!;
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  /// Parse shadow from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="shadow-color:0xFF000000;shadow-blur:10;shadow-horizontal:2;shadow-vertical:2;">shadow</style> text""";
  /// List<Shadow>? shadowed = shadow(text);
  /// Text widget = Text(text, style: TextStyle(shadows: shadowed));
  /// ```
  static Shadow? shadow(String text) {
    try {
      String color = text.matchWith(r'(?<=shadow-color:).*?(?=;)')!;
      String blur = text.matchWith(r'(?<=shadow-blur:).*?(?=;)')!;
      String vertical = text.matchWith(r'(?<=shadow-vertical:).*?(?=;)') ?? "0";
      String horizontal =
          text.matchWith(r'(?<=shadow-horizontal:).*?(?=;)') ?? "0";

      return Shadow(
          color: Color(int.parse(color)),
          blurRadius: double.parse(blur),
          offset: Offset(double.parse(horizontal), double.parse(vertical)));
    } catch (e) {
      return null;
    }
  }

  /// Parse italic style from input [text].
  ///
  /// ```dart
  /// String text = """It's an <style="decoration:italic;">italic</style> text""";
  /// FontStyle? skewed = italic(text);
  /// Text widget = Text(text, style: TextStyle(fontStyle: skewed));
  /// ```
  static bool italic(String text) {
    return text.contains('decoration:italic;');
  }

  /// Parse a striketrough [TextDecoration] style from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="decoration:striketrough;">striketrough</style> text""";
  /// TextDecoration strikeTroughed = strikeTrough(text);
  /// Text widget = Text(text, style: TextStyle(decoration: strikeThroughed));
  /// ```
  static bool strikeThrough(String text) {
    return text.contains('decoration:strikethrough;');
  }

  /// Parse an underline [TextDecoration] style from input [text].
  ///
  /// ```dart
  /// String text = """It's an <style="decoration:underline;">underline</style> text""";
  /// TextDecoration underlined = underline(text);
  /// Text widget = Text(text, style: TextStyle(decoration: underlined));
  /// ```
  static bool underline(String text) {
    return text.contains('decoration:underline;');
  }

  /// Parse an overline [TextDecoration] style from input [text].
  ///
  /// ```dart
  /// String text = """It's an <style="decoration:overline;">overline</style> text""";
  /// TextDecoration overlined = underline(text);
  /// Text widget = Text(text, style: TextStyle(decoration: overlined));
  /// ```
  static bool overline(String text) {
    return text.contains('decoration:overline;');
  }

  /// Parse a blockquote [BoxDecoration] style from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="decoration:blockquote;">blockquote</style> text""";
  /// BoxDecoration? quoted = blockquote(text);
  /// Widget decorated = DecoratedBox(decoration: quoted);
  /// ```
  static bool blockquote(String text) {
    return text.contains('decoration:blockquote;');
  }

  /// Parse padding from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="padding-left:4;padding-top:8;padding-right:12;padding-bottom:16;">padding</style> text""";
  /// EdgeInsets? padded = padding(text);
  /// Widget widget = Padding(padding: padded);
  /// ```
  static EdgeInsetsGeometry? padding(String text) {
    try {
      bool quoted = text.contains('decoration:blockquote;');
      if (quoted == true) {
        return const EdgeInsets.all(4.0);
      } else {
        String? left = text.matchWith(r'(?<=padding-left:).*?(?=;)');
        String? right = text.matchWith(r'(?<=padding-right:).*?(?=;)');
        String? top = text.matchWith(r'(?<=padding-top:).*?(?=;)');
        String? bottom = text.matchWith(r'(?<=padding-bottom:).*?(?=;)');
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

  /// Parse new line from input [text].
  ///
  /// ```dart
  /// String text = """It's a \n New Line text""";
  /// BoxConstraints? breakline = newline(text);
  /// Widget widget = ConstrainedBox(constraints: breakline);
  /// ```
  static bool newline(String text) {
    return text.contains('\n');
  }

  static bool blankspace(String text) {
    return text.contains("<br>");
  }

  /// Parse [AlignmentGeometry] from input [text].
  ///
  /// ```dart
  /// String text = """It's an <style="align-x:1;align-y:-1;">aligned</style> text""";
  /// AlignmentGeometry? aligned = align(text);
  /// Widget widget = Align(alignment: aligned);
  /// ```
  static AlignmentGeometry? align(String text) {
    try {
      String? x = text.matchWith(r'(?<=align-x:).*?(?=;)');
      String? y = text.matchWith(r'(?<=align-y:).*?(?=;)');
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

  /// Parse hyperlink [Uri] from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="hyperlink:https://github.com/Nialixus;">hyperlink</style> text""";
  /// Uri? linked = hyperlink(text);
  /// Widget widget = Link(uri: linked);
  /// ```
  static String? hyperlink(String text) {
    return text.matchWith(r'(?<=hyperlink:).*?(?=;)');
  }

  /// Parse [RichTrexImage] from input [text].
  ///
  /// ```dart
  /// String text = """It's an <widget="image-network:https://www.kindpng.com/picc/b/355-3557482_package-icon-png.png;image-width:30;image-height:30;"/>""";
  /// RichTrexImage? widget = image(text);
  /// ```
  RichTrexImage? image(String text) {
    if (text.contains(RegExp(r'<widget=".*?"/>'))) {
      try {
        String? file = text.matchWith('(?<=image-file:).*?(?=;)');
        String? width = text.matchWith('(?<=image-width:).*?(?=;)');
        String? asset = text.matchWith('(?<=image-asset:).*?(?=;)');
        String? memory = text.matchWith('(?<=image-memory:).*?(?=;)');
        String? resize = text.matchWith('(?<=image-resize:).*?(?=;)');
        String? height = text.matchWith('(?<=image-height:).*?(?=;)');
        String? network = text.matchWith('(?<=image-network:).*?(?=;)');

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

  /// Decoded list of [InlineSpan] from input [super.text].
  ///
  ///```dart
  /// Text richtext = Text.rich(children ?? <InlineSpan>[]);
  /// ```
  @override
  List<InlineSpan>? get children {
    List<String> texts = textlist(super.text ?? "");

    return List.generate(
        texts.length,
        (x) => image(texts[x]) != null
            ? RichTrexSpan.image(image: image(texts[x])!)
            : RichTrexSpan(
                style: style,
                text: toText(texts[x]),
                align: align(texts[x]),
                backgroundColor: backgroundColor(texts[x]),
                blockquote: blockquote(texts[x]),
                color: color(texts[x]),
                fontFamily: fontFamily(texts[x]),
                fontSize: fontSize(texts[x]),
                fontWeight: fontWeight(texts[x]),
                horizontalSpace: horizontalSpace(texts[x]),
                hyperlink: hyperlink(texts[x]),
                italic: italic(texts[x]),
                newline: newline(texts[x]),
                blankSpace: blankspace(texts[x]),
                overline: overline(texts[x]),
                strikeThrough: strikeThrough(texts[x]),
                underline: underline(texts[x]),
                verticalSpace: verticalSpace(texts[x]),
                padding: padding(texts[x]),
                shadow: shadow(texts[x])));
  }
}
