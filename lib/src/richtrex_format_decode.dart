part of 'package:richtrex_format/richtrex_format.dart';

/// A tool to decode [TextSpan] from encoded [String].
class RichTrexFormatDecode extends TextSpan {
  /// A tool to decode [TextSpan] from encoded [String].
  ///
  /// ```dart
  /// String text = '<style="font-weight:bold;">Text</style>'
  /// TextSpan decoded = RichTrexFormatDecode(text);
  /// Text richtext = Text.rich(decoded);
  /// ```
  const RichTrexFormatDecode(String text,
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
  static String string(String text) => text.replaceAll(
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
  static List<Shadow>? shadow(String text) {
    try {
      String color = text.matchWith(r'(?<=shadow-color:).*?(?=;)')!;
      String blur = text.matchWith(r'(?<=shadow-blur:).*?(?=;)')!;
      String vertical = text.matchWith(r'(?<=shadow-vertical:).*?(?=;)') ?? "0";
      String horizontal =
          text.matchWith(r'(?<=shadow-horizontal:).*?(?=;)') ?? "0";

      return [
        Shadow(
            color: Color(int.parse(color)),
            blurRadius: double.parse(blur),
            offset: Offset(double.parse(horizontal), double.parse(vertical)))
      ];
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
  static FontStyle? italic(String text) {
    try {
      bool value = text.contains('decoration:italic;');
      return value == true ? FontStyle.italic : null;
    } catch (e) {
      return null;
    }
  }

  /// Parse a striketrough [TextDecoration] style from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="decoration:striketrough;">striketrough</style> text""";
  /// TextDecoration strikeTroughed = strikeTrough(text);
  /// Text widget = Text(text, style: TextStyle(decoration: strikeThroughed));
  /// ```
  static TextDecoration strikeThrough(String text) {
    try {
      bool value = text.contains('decoration:strikethrough;');
      return value == true ? TextDecoration.lineThrough : TextDecoration.none;
    } catch (e) {
      return TextDecoration.none;
    }
  }

  /// Parse an underline [TextDecoration] style from input [text].
  ///
  /// ```dart
  /// String text = """It's an <style="decoration:underline;">underline</style> text""";
  /// TextDecoration underlined = underline(text);
  /// Text widget = Text(text, style: TextStyle(decoration: underlined));
  /// ```
  static TextDecoration underline(String text) {
    try {
      bool value = text.contains('decoration:underline;');
      return value == true ? TextDecoration.underline : TextDecoration.none;
    } catch (e) {
      return TextDecoration.none;
    }
  }

  /// Parse an overline [TextDecoration] style from input [text].
  ///
  /// ```dart
  /// String text = """It's an <style="decoration:overline;">overline</style> text""";
  /// TextDecoration overlined = underline(text);
  /// Text widget = Text(text, style: TextStyle(decoration: overlined));
  /// ```
  static TextDecoration overline(String text) {
    try {
      bool value = text.contains('decoration:overline;');
      return value == true ? TextDecoration.overline : TextDecoration.none;
    } catch (e) {
      return TextDecoration.none;
    }
  }

  /// Parse a blockquote [BoxDecoration] style from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="decoration:blockquote;">blockquote</style> text""";
  /// BoxDecoration? quoted = blockquote(text);
  /// Widget decorated = DecoratedBox(decoration: quoted);
  /// ```
  static BoxDecoration? blockquote(String text) {
    try {
      bool value = text.contains('decoration:blockquote;');
      return value == true
          ? BoxDecoration(
              color: Colors.grey.shade200,
              border:
                  const Border(left: BorderSide(width: 4, color: Colors.grey)))
          : null;
    } catch (e) {
      return null;
    }
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
  static BoxConstraints? newline(String text) {
    try {
      bool newline = text.contains('\n');
      bool breakline = text.contains("<br>");
      bool quoted = text.contains('decoration:blockquote;');
      return quoted == true
          ? const BoxConstraints(minWidth: double.infinity)
          : breakline == true
              ? const BoxConstraints(minWidth: double.infinity, minHeight: 20)
              : newline == true
                  ? const BoxConstraints(
                      minWidth: double.infinity, maxHeight: 0)
                  : null;
    } catch (e) {
      return null;
    }
  }

  /// Parse [Alignment] from input [text].
  ///
  /// ```dart
  /// String text = """It's an <style="align-x:1;align-y:-1;">aligned</style> text""";
  /// AlignmentGeometry? aligned = alignment(text);
  /// Widget widget = Align(alignment: aligned);
  /// ```
  static AlignmentGeometry? alignment(String text) {
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
  static Uri? hyperlink(String text) {
    try {
      String value = text.matchWith(r'(?<=hyperlink:).*?(?=;)')!;
      return Uri.parse(value);
    } catch (e) {
      return null;
    }
  }

  /// Parse [RichTrexImage] from input [text].
  ///
  /// ```dart
  /// String text = """It's an <widget="image-network:https://www.kindpng.com/picc/b/355-3557482_package-icon-png.png;image-width:30;image-height:30;"/>""";
  /// RichTrexImage? widget = image(text);
  /// ```
  RichTrexImage? image(String text) {
    if (text.contains(RegExp(r'<widget=".*?/>'))) {
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
        (x) => WidgetSpan(
            baseline: TextBaseline.alphabetic,
            alignment: PlaceholderAlignment.baseline,
            child: image(texts[x]) ??
                Container(
                    decoration: blockquote(texts[x]),
                    padding: padding(texts[x]),
                    constraints: newline(texts[x]),
                    alignment: alignment(texts[x]),
                    child: Link(
                        uri: hyperlink(texts[x]),
                        builder: (_, onTap) => Material(
                            color: Colors.transparent,
                            child: InkWell(
                                splashColor: Colors.blue.withOpacity(0.1),
                                highlightColor: Colors.blue.withOpacity(0.1),
                                onTap: onTap,
                                child: Text(string(texts[x]),
                                    style: style?.copyWith(
                                        leadingDistribution:
                                            TextLeadingDistribution.even,
                                        backgroundColor:
                                            backgroundColor(texts[x]),
                                        fontStyle: italic(texts[x]),
                                        shadows: shadow(texts[x]),
                                        height: verticalSpace(texts[x]),
                                        letterSpacing:
                                            horizontalSpace(texts[x]),
                                        color: color(texts[x]),
                                        fontSize: fontSize(texts[x]),
                                        fontFamily: fontFamily(texts[x]),
                                        fontWeight: fontWeight(texts[x]),
                                        decoration: TextDecoration.combine([
                                          strikeThrough(texts[x]),
                                          underline(texts[x]),
                                          overline(texts[x])
                                        ])))))))));
  }
}
