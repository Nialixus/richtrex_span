part of 'package:richtrex_format/richtrex_format.dart';

/// A tool to decode [TextSpan] from encoded [String].
class RichTrexFormatDecode extends TextSpan {
  /// A tool to decode [TextSpan] from encoded [String].
  ///
  /// ```dart
  /// TextSpan decode = RichTrexFormatDecode(text);
  /// ```
  const RichTrexFormatDecode(this.input,
      {this.textStyle = const TextStyle(color: Colors.black)})
      : super();

  /// Required [String] input.
  final String input;

  /// Required default [TextStyle].
  final TextStyle textStyle;

  /// Default [TextStyle].
  @override
  TextStyle? get style => textStyle;

  /// Output text.
  @override
  String? get text => _text(input);

  // Clean Text from Tag.
  String _text(String text) {
    try {
      return text.replaceAll(
          RegExp(
              r'<style=".*?">|<\/style>|<widget=.*?;"\/>|(<widget=".*?;">)|(<\/widget>)'),
          "");
    } catch (e) {
      return text;
    }
  }

  @override
  List<InlineSpan>? get children {
    return List.generate(textList.length, (x) {
      // Generated style when tag exist.
      TextStyle generatedStyle = style!.copyWith(
          leadingDistribution: TextLeadingDistribution.even,
          color: color(textList[x]),
          height: verticalSpace(textList[x]),
          shadows: shadow(textList[x]),
          fontStyle: italic(textList[x]),
          fontSize: fontSize(textList[x]),
          fontWeight: fontWeight(textList[x]),
          fontFamily: fontFamily(textList[x]),
          letterSpacing: horizontalSpace(textList[x]),
          backgroundColor: backgroundColor(textList[x]),
          decoration: TextDecoration.combine([
            overline(textList[x]),
            underline(textList[x]),
            strikeThrough(textList[x])
          ]));

      // Generated [TextSpan] from <style ... ></style> tag.
      TextSpan textSpan =
          TextSpan(text: _text(textList[x]), style: generatedStyle);

      // Generated [WidgetSpan] from <widget ... ></widget> tag.
      WidgetSpan widgetSpan({required Widget child}) => WidgetSpan(
          style: style,
          child: Container(
              alignment: align(textList[x]),
              decoration: blockQuote(textList[x]),
              constraints: (align(textList[x]) == null &&
                      blockQuote(textList[x]) == null)
                  ? null
                  : const BoxConstraints(minWidth: double.infinity),
              child: child));

      if (textList[x].contains(RegExp(r'<style=.*?\/style>'))) {
        // textList[x] with `<style ... ></style>` tag.
        return textSpan;
      } else if (textList[x]
          .contains(RegExp(r'<widget=.*?;"\/>|<widget=.*?<\/widget>'))) {
        // textList[x] with `<widget ... />` or <widget ... ></widget> tag.
        List<Widget?> child = [
          image(textList[x]),
          hyperlink(textList[x], span: textSpan)
        ];
        try {
          return widgetSpan(
              child: child.lastWhere((element) => element != null)!);
        } catch (e) {
          return widgetSpan(child: Text.rich(textSpan));
        }
      } else {
        // if textList[x] has no style, just return basic textspan.
        return TextSpan(text: textList[x]);
      }
    });
  }

  // Split text between Tagged Text and Plain Text.
  List<String> get textList => input.split(RegExp(
      r'(?=<style=)|(?<=<\/style>)|(?=<widget=)|(?<=;"\/>)|(?<=<\/widget>)'));

  /// Shortcut of find matched text with [RegExp].
  String? _regMatch(String text, String pattern) =>
      RegExp(pattern).stringMatch(text);

  // Get Color from Tag.
  Color? color(String text) {
    try {
      String value = _regMatch(text, r'(?<=font-color:).*?(?=;)')!;
      return Color(int.parse(value));
    } catch (e) {
      return null;
    }
  }

  // Get Background-Color from Tag.
  Color? backgroundColor(String text) {
    try {
      String value = _regMatch(text, r'(?<=background-color:).*?(?=;)')!;
      return Color(int.parse(value));
    } catch (e) {
      return null;
    }
  }

  // Get Font-Weight from Tag.
  FontWeight? fontWeight(String text) {
    try {
      String value = _regMatch(text, r'(?<=font-weight:).*?(?=;)')!;
      return FontWeight.values[int.parse(value)];
    } catch (e) {
      return null;
    }
  }

  // Get Font-Family from Tag.
  String? fontFamily(String text) {
    try {
      String value = _regMatch(text, r'(?<=font-family:).*?(?=;)')!;
      return value;
    } catch (e) {
      return null;
    }
  }

  // Get Font-Size from Tag.
  double? fontSize(String text) {
    try {
      String value = _regMatch(text, r'(?<=font-size:).*?(?=;)')!;
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  // Get Horizontal-Space from Tag.
  double? horizontalSpace(String text) {
    try {
      String value = _regMatch(text, r'(?<=horizontal-space:).*?(?=;)')!;
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  // Get Vertical-Space from Tag.
  double? verticalSpace(String text) {
    try {
      String value = _regMatch(text, r'(?<=vertical-space:).*?(?=;)')!;
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  // Get Shadow from Tag.
  List<Shadow>? shadow(String text) {
    try {
      String? horizontal = _regMatch(text, r'(?<=shadow-horizontal:).*?(?=;)');
      String? vertical = _regMatch(text, r'(?<=shadow-vertical:).*?(?=;)');
      String color = _regMatch(text, r'(?<=shadow-color:).*?(?=;)')!;
      String blurRadius = _regMatch(text, r'(?<=shadow-blur:).*?(?=;)')!;
      return [
        Shadow(
            color: Color(int.parse(color)),
            blurRadius: double.parse(blurRadius),
            offset: Offset(
                double.parse(horizontal ?? "0"), double.parse(vertical ?? "0")))
      ];
    } catch (e) {
      return null;
    }
  }

  // Get Italic from Tag.
  FontStyle? italic(String text) {
    try {
      bool value = text.contains('decoration:italic;');
      return value == true ? FontStyle.italic : null;
    } catch (e) {
      return null;
    }
  }

  // Get Strikethrough from Tag.
  TextDecoration strikeThrough(String text) {
    try {
      bool value = text.contains('decoration:strikethrough;');
      return value == true ? TextDecoration.lineThrough : TextDecoration.none;
    } catch (e) {
      return TextDecoration.none;
    }
  }

  // Get Underline from Tag.
  TextDecoration underline(String text) {
    try {
      bool value = text.contains('decoration:underline;');
      return value == true ? TextDecoration.underline : TextDecoration.none;
    } catch (e) {
      return TextDecoration.none;
    }
  }

  // Get Overline from Tag.
  TextDecoration overline(String text) {
    try {
      bool value = text.contains('decoration:overline;');
      return value == true ? TextDecoration.overline : TextDecoration.none;
    } catch (e) {
      return TextDecoration.none;
    }
  }

  // Get BlockQuote from Tag.
  Decoration? blockQuote(String text) {
    try {
      bool value = text.contains("decoration:blockquote;");
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

  // Get Align from Tag.
  AlignmentGeometry? align(String text) {
    try {
      String? vertical = _regMatch(text, r'(?<=align-vertical:).*?(?=;)');
      String horizontal = _regMatch(text, r'(?<=align-horizontal:).*?(?=;)')!;
      return Alignment(double.parse(horizontal), double.parse(vertical ?? "0"));
    } catch (e) {
      return null;
    }
  }

  // Get Image from Tag.
  RichTrexImage? image(String text) {
    if (text.contains(RegExp(r'<widget=".*?/>'))) {
      try {
        String? file = _regMatch(text, r'(?<=image-file:).*?(?=;)');
        String? width = _regMatch(text, r'(?<=image-width:).*?(?=;)');
        String? asset = _regMatch(text, r'(?<=image-asset:).*?(?=;)');
        String? memory = _regMatch(text, r'(?<=image-memory:).*?(?=;)');
        String? resize = _regMatch(text, r'(?<=image-resize:).*?(?=;)');
        String? height = _regMatch(text, r'(?<=image-height:).*?(?=;)');
        String? network = _regMatch(text, r'(?<=image-network:).*?(?=;)');

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

  // Get Hyperlink URL from Tag.
  Link? hyperlink(String text, {required TextSpan span}) {
    try {
      String value = _regMatch(text, r'(?<=hyperlink:).*?(?=;)')!;
      return Link(
          uri: Uri.parse(value),
          builder: (_, onTap) => Material(
              child: InkWell(
                  splashColor: Colors.blue.withOpacity(0.1),
                  highlightColor: Colors.blue.withOpacity(0.1),
                  onTap: onTap,
                  child: Text.rich(TextSpan(
                      text: span.text,
                      style: span.style!.copyWith(
                          color: Colors.blue.shade700, height: 1.0))))));
    } catch (e) {
      return null;
    }
  }
}
