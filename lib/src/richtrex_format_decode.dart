part of 'package:richtrex_format/richtrex_format.dart';

/// A tool to decode [TextSpan] from encoded [String].
class RichTrexFormatDecode extends TextSpan {
  /// A tool to decode [TextSpan] from encoded [String].
  ///
  /// ```dart
  /// String text = '<style="font-weight:bold;">Text</style>'
  /// TextSpan decode = RichTrexFormatDecode(text);
  /// Text richtext = Text.rich(decode);
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
  /// List<String> texts = textlist(text);
  /// print(texts); // ["It's a ","<style="font-weight:8;">bold</style>"," text"]
  /// ```
  List<String> textlist(String text) =>
      text.split(RegExp(r'(?=<style=")|(?<=<\/style>)'));

  /// Parse clean [String] from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="font-weight:8;">bold</style> text""";
  /// String cleantext = string(text);
  /// print(cleantext) // It's a bold text
  /// ```
  String string(String text) =>
      text.replaceAll(RegExp(r'<style=".*?;">|<\/style>'), "");

  /// Parse [Color] from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="font-color:0xff4caf50;">colored</style> text""";
  /// Color? colortext = color(text);
  /// Text styledtext = Text(text, style: TextStyle(color: colortext))
  /// ```
  Color? color(String text) {
    try {
      String value = text.matchWith(r'(?<=font-color:).*?(?=;)')!;
      return Color(int.parse(value));
    } catch (e) {
      return null;
    }
  }

  /// Parse [FontWeight] from input [text].
  ///
  /// ```dart
  /// String text = """It's a <style="font-weight:8;">bold</style> text""";
  /// FontWeight? boldtext = fontWeight(text);
  /// Text styledtext = Text(text, style: TextStyle(fontWeight: boldtext));
  /// ```
  FontWeight? fontWeight(String text) {
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
  /// double? sizedtext = fontSize(text);
  /// Text styledtext = Text(text, style: TextStyle(fontSize: sizedtext));
  /// ```
  double? fontSize(String text) {
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
  /// double? familytext = fontFamily(text);
  /// Text styledtext = Text(text, style: TextStyle(fontFamily: familytext));
  /// ```
  String? fontFamily(String text) {
    try {
      String value = text.matchWith(r'(?<=font-family:).*?(?=;)')!;
      return value;
    } catch (e) {
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
    late List<String> texts = textlist(super.text ?? "");

    return List.generate(
        texts.length,
        (x) => TextSpan(
            text: string(texts[x]),
            style: style?.copyWith(
                color: color(texts[x]),
                fontSize: fontSize(texts[x]),
                fontFamily: fontFamily(texts[x]),
                fontWeight: fontWeight(texts[x]))));
  }
}
