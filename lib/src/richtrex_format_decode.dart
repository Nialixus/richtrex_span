part of 'package:richtrex_format/richtrex_format.dart';

/// A tool to decode [TextSpan] from encoded [String].
class RichTrexFormatDecode extends TextSpan {
  /// A tool to decode [TextSpan] from encoded [String].
  ///
  /// ```dart
  /// TextSpan decode = RichTrexFormatDecode(text);
  /// ```
  const RichTrexFormatDecode(String text,
      {Locale? locale,
      MouseCursor? mouseCursor,
      TextStyle? style,
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

  /// Parse list of [String] from input [super.text].
  List<String> get textlist => super.text!.split(RegExp(
      r'(?=<widget=".+;">)|(?<=<\/widget>)|(?<=[^;">])(?=<style=")|(?<=<\/style>)<\/widget>|(?=<widget=".+;"\/>)|(?<=[(<widget=".*;"\/>)]$)'));

  /// Parse clean [String] from input [text].
  String rawText(String text) => text.replaceAll(
      RegExp(
          r'<widget=".*?;">|<\/widget>|<widget=".*;"\/>|<style=".*;">|<\/style>'),
      "");

  /// Parse [Color] from input [text].
  Color? color(String text) {
    try {
      String value = text.matchWith(r'(?<=font-color:).*?(?=;)')!;
      return Color(int.parse(value));
    } catch (e) {
      return null;
    }
  }

  @override
  List<InlineSpan>? get children => List.generate(
      textlist.length,
      (x) => TextSpan(
          text: rawText(textlist[x]),
          style: (style ?? const TextStyle(color: Colors.black))
              .copyWith(color: color(textlist[x]))));
}
