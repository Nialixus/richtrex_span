/// An extended package of `RichTrex` package which is used to encode list of [TextSpan] into [String], and decode [String] into list of [TextSpan].
library richtrex_span;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:richtrex_image/richtrex_image.dart';
import 'package:richtrex_span/src/richtrex_decoder.dart';
import 'package:richtrex_span/src/richtrex_encoder.dart';
import 'package:url_launcher/link.dart';

/// A superclass to translate [TextSpan] or [WidgetSpan] into [String] and the other way round.
class RichTrexSpan extends InlineSpan {
  /// Wrapping all kind of types which later will be translated into [String] or the other way around.
  const RichTrexSpan(
      {this.fontSize,
      this.color,
      this.verticalSpace,
      this.horizontalSpace,
      this.blockquote = false,
      this.padding,
      this.align,
      this.backgroundColor,
      this.hyperlink,
      this.text,
      this.shadow,
      this.fontFamily,
      this.fontWeight,
      this.strikeThrough = false,
      this.underline = false,
      this.overline = false,
      this.italic = false})
      : image = null;

  /// Wrapping only [RichTrexImage] types which later will be translated into [String] or the other way around.
  ///
  /// ```dart
  /// RichTrexSpan.image(image: RichTrexImage.network("https://avatars.githubusercontent.com/u/45191605?v=4", size: Size(70, 70)));
  /// ```
  const RichTrexSpan.image({required this.image})
      : assert(image != null),
        fontSize = null,
        color = null,
        verticalSpace = null,
        horizontalSpace = null,
        blockquote = false,
        padding = null,
        align = null,
        backgroundColor = null,
        hyperlink = null,
        text = null,
        shadow = null,
        fontFamily = null,
        fontWeight = null,
        strikeThrough = false,
        underline = false,
        overline = false,
        italic = false;

  /// The value of [RichTrexSpan], it could be [TextSpan] or [WidgetSpan].
  InlineSpan get child {
    if (image != null ||
        align != null ||
        blockquote ||
        padding != null && padding != EdgeInsets.zero ||
        hyperlink != null) {
      return WidgetSpan(
          child: image != null
              ? image!
              : Container(
                  decoration: blockquote
                      ? BoxDecoration(
                          color: Colors.grey.shade200,
                          border: const Border(
                              left: BorderSide(width: 4, color: Colors.grey)))
                      : null,
                  padding: blockquote ? const EdgeInsets.all(4.0) : padding,
                  constraints: blockquote
                      ? const BoxConstraints(minWidth: double.infinity)
                      : null,
                  alignment: align,
                  child: Link(
                      uri: hyperlink == null ? null : Uri.parse(hyperlink!),
                      builder: (_, onTap) => Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Colors.blue.withOpacity(0.1),
                              highlightColor: Colors.blue.withOpacity(0.1),
                              onTap: onTap,
                              child: Text(text ?? "",
                                  textAlign: align?.x == 0
                                      ? TextAlign.center
                                      : align?.x == 1
                                          ? TextAlign.end
                                          : TextAlign.start,
                                  style: TextStyle(
                                      leadingDistribution:
                                          TextLeadingDistribution.even,
                                      backgroundColor: backgroundColor,
                                      fontStyle: italic == true
                                          ? FontStyle.italic
                                          : FontStyle.normal,
                                      shadows: [if (shadow != null) shadow!],
                                      height: verticalSpace,
                                      letterSpacing: horizontalSpace,
                                      color: blockquote == true
                                          ? Colors.black.withOpacity(0.5)
                                          : hyperlink != null
                                              ? Colors.blue
                                              : color,
                                      fontSize: fontSize,
                                      fontFamily: fontFamily,
                                      fontWeight: fontWeight,
                                      decoration: TextDecoration.combine([
                                        if (strikeThrough == true)
                                          TextDecoration.lineThrough,
                                        if (underline == true)
                                          TextDecoration.underline,
                                        if (overline == true)
                                          TextDecoration.overline
                                      ]))))))));
    } else {
      return TextSpan(
          text: text,
          style: TextStyle(
              color: color,
              leadingDistribution: TextLeadingDistribution.even,
              height: verticalSpace,
              letterSpacing: horizontalSpace,
              shadows: [if (shadow != null) shadow!],
              backgroundColor: backgroundColor,
              fontFamily: fontFamily,
              fontSize: fontSize,
              fontStyle: italic ? FontStyle.italic : null,
              fontWeight: fontWeight,
              decoration: TextDecoration.combine([
                if (strikeThrough) TextDecoration.lineThrough,
                if (overline) TextDecoration.overline,
                if (underline) TextDecoration.underline
              ])));
    }
  }

  /// How to decode:
  /// ```dart
  ///   String value = '<style="font-size:30;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text:"value", fontSize: 30.0)]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text:"value", fontSize: 30.0)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="font-size:30;">value</style>'
  /// ```
  final double? fontSize;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="font-color:0xFFF44336;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text:"value", color: Color(0xFFF44336))]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text:"value", color: Colors.red)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="font-color:0xFFF44336;">value</style>'
  /// ```
  final Color? color;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="vertical-space:10;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text:"value", verticalSpace: 10.0)]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text:"value", verticalSpace: 10.0)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="vertical-space:10;">value</style>'
  /// ```
  final double? verticalSpace;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="horizontal-space:10;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text:"value", horizontalSpace: 10.0)]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text:"value", horizontalSpace: 10.0)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="horizontal-space:10;">value</style>'
  /// ```
  final double? horizontalSpace;

  /// How to decode:
  /// ```dart
  ///   String value = '<widget="image-network:https://avatars.githubusercontent.com/u/45191605?v=4;image-width:70;image-height:70;"/>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan.image(image: RichTrexImage.network("https://avatars.githubusercontent.com/u/45191605?v=4",size: Size(70, 70)))]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [
  ///     RichTrexSpan.image(image:
  ///       RichTrexImage.network("https://avatars.githubusercontent.com/u/45191605?v=4",
  ///         size: Size(70, 70)),
  ///     )];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<widget="image-network:https://avatars.githubusercontent.com/u/45191605?v=4;image-width:70;image-height:70;"/>'
  /// ```
  final RichTrexImage? image;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="decoration:blockquote;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text:"value", blockquote: true)]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text:"value", blockquote: true)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="decoration:blockquote;">value</style>'
  /// ```
  final bool blockquote;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="padding-left:20.0;padding-top: 20.0;padding-right: 20.0;padding-bottom: 20.0;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text: "value", padding: EdgeInsets.all(20.0))]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text: "value", padding: EdgeInsets.all(20.0))];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="padding-left:20.0;padding-top: 20.0;padding-right: 20.0;padding-bottom: 20.0;">value</style>'
  /// ```
  final EdgeInsetsGeometry? padding;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="align-x:0.0;align-y:0.0;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text: "value", align: Alignment.center)]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text: "value", align: Alignment.center)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="align-x:0.0;align-y:0.0;">value</style>'
  /// ```
  final Alignment? align;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="background-color:0xFFF44336;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text:"value", backgroundColor: Color(0xFFF44336))]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text:"value", backgroundColor: Colors.red)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="background-color:0xFFF44336;">value</style>'
  /// ```
  final Color? backgroundColor;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="hyperlink:https://github.com/Nialixus;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text: "value", hyperlink: "https://github.com/Nialixus")]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text: "value", hyperlink: "https://github.com/Nialixus")];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="hyperlink:https://github.com/Nialixus;">value</style>'
  /// ```
  final String? hyperlink;

  /// How to decode:
  /// ```dart
  ///   String value = 'value';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text: "value")]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text: "value")];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // 'value'
  /// ```
  final String? text;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="shadow-color:0xFFF44336;shadow-blur:10.0;shadow-vertical:-1.0;shadow-horizontal:-1.0;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text: "value", shadow: Shadow(color: Colors.red, blurRadius: 10, offset: Offset(-1, -1)))]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text: "value", shadow: Shadow(color: Colors.red, blurRadius: 10, offset: Offset(-1, -1)))];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="shadow-color:0xFFF44336;shadow-blur:10.0;shadow-vertical:-1.0;shadow-horizontal:-1.0;">value</style>'
  /// ```
  final Shadow? shadow;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="font-family:Dancing;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text: "value", fontFamily: "Dancing")]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text: "value", fontFamily: "Dancing")];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="font-family:Dancing;">value</style>'
  /// ```
  final String? fontFamily;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="font-weight:6;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text: "value", fontWeight: FontWeight.values[6])]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text: "value", fontWeight: FontWeight.bold)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="font-weight:6;">value</style>'
  /// ```
  final FontWeight? fontWeight;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="decoration:strikethrough;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text: "value", strikeThrough: true)]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text: "value", strikeThrough: true)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="decoration:strikethrough;">value</style>'
  /// ```
  final bool strikeThrough;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="decoration:underline;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text: "value", underline: true)]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text: "value", underline: true)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="decoration:underline;">value</style>'
  /// ```
  final bool underline;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="decoration:overline;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text: "value", overline: true)]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text: "value", overline: true)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="decoration:overline;">value</style>'
  /// ```
  final bool overline;

  /// How to decode:
  /// ```dart
  ///   String value = '<style="decoration:italic;">value</style>';
  ///   List<RichTrexSpan> result = RichTrexSpan.decode(value);
  ///   print(result); // [RichTrexSpan(text: "value", italic: true)]
  /// ```
  ///
  /// How to encode:
  /// ```dart
  ///   List<RichTrexSpan> value = [RichTrexSpan(text: "value", italic: true)];
  ///   String result = RichTrexSpan.encode(value);
  ///   print(result); // '<style="decoration:italic;">value</style>'
  /// ```
  final bool italic;

  /// Encoding list of [RichTrexSpan] into [String].
  static String encode(List<RichTrexSpan> span) =>
      span.map((e) => RichTrexEncoder(e).parse).join();

  /// Decoding encoded [String] to list of [RichTrexSpan].
  static List<RichTrexSpan> decode(String text) {
    List<String> list = text
        .split(RegExp(r'(?=<style=")|(?<=<\/style>)|(?=<widget)|(?<="\/>)'))
        .toList();

    return list.map((e) => RichTrexDecoder(e).parse).toList();
  }

  @override
  void build(ParagraphBuilder builder,
          {double textScaleFactor = 1.0,
          List<PlaceholderDimensions>? dimensions}) =>
      child.build(builder,
          dimensions: dimensions, textScaleFactor: textScaleFactor);

  @override
  int? codeUnitAtVisitor(int index, Accumulator offset) =>
      child.codeUnitAtVisitor(index, offset);

  @override
  RenderComparison compareTo(InlineSpan other) => child.compareTo(other);

  @override
  void computeSemanticsInformation(
    List<InlineSpanSemanticsInformation> collector, {
    Locale? inheritedLocale,
    bool inheritedSpellOut = false,
  }) {
    if (child is TextSpan) {
      TextSpan child = this.child as TextSpan;
      return child.computeSemanticsInformation(collector,
          inheritedLocale: inheritedLocale,
          inheritedSpellOut: inheritedSpellOut);
    }
  }

  @override
  void computeToPlainText(StringBuffer buffer,
          {bool includeSemanticsLabels = true,
          bool includePlaceholders = true}) =>
      child.computeToPlainText(buffer,
          includeSemanticsLabels: includeSemanticsLabels,
          includePlaceholders: includePlaceholders);

  @override
  InlineSpan? getSpanForPositionVisitor(
          TextPosition position, Accumulator offset) =>
      child.getSpanForPositionVisitor(position, offset);

  @override
  bool visitChildren(InlineSpanVisitor visitor) => child.visitChildren(visitor);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    if (image != null) {
      return "RichTrexSpan.image(image: $image)";
    } else {
      return "RichTrexSpan(${{
        if (align != null) "align": align,
        if (backgroundColor != null) "backgroundColor": backgroundColor,
        if (blockquote) "blockquote": blockquote,
        if (color != null) "color": color,
        if (fontFamily != null) "fontFamily": fontFamily,
        if (fontSize != null) "fontSize": fontSize,
        if (fontWeight != null) "fontWeight": fontWeight,
        if (horizontalSpace != null) "horizontalSpace": horizontalSpace,
        if (hyperlink != null) "hyperlink": hyperlink,
        if (italic) "italic": italic,
        if (overline) "overline": overline,
        if (padding != null && padding != EdgeInsets.zero) "padding": padding,
        if (shadow != null) "shadow": shadow,
        if (strikeThrough) "strikeThrough": strikeThrough,
        if (text != null) "text": text,
        if (underline) "underline": underline,
        if (verticalSpace != null) "verticalSpace": verticalSpace
      }})"
          .replaceAll(RegExp(r'\{|\}'), "");
    }
  }
}
