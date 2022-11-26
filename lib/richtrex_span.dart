/// An extended package of `RichTrexPackage`. This package is used to decode [TextSpan] from encoded [String].
library richtrex_span;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:richtrex_image/richtrex_image.dart';
import 'package:richtrex_span/src/richtrex_decoder.dart';
import 'package:richtrex_span/src/richtrex_encoder.dart';
import 'package:url_launcher/link.dart';
part 'src/richtrex_widget.dart';
part 'src/richtrex_style.dart';

class RichTrexSpan extends InlineSpan {
  const RichTrexSpan(
      {this.fontSize,
      this.color,
      this.verticalSpace,
      this.horizontalSpace,
      this.image,
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
      : child = const TextSpan(
            text:
                "Don't use RichTrexSpan, use RichTrexStyle or RichTrexWidget instead.");
  final InlineSpan child;
  final double? fontSize;
  final Color? color;
  final double? verticalSpace;
  final double? horizontalSpace;
  final RichTrexImage? image;
  final bool blockquote;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? align;
  final Color? backgroundColor;
  final String? hyperlink;
  final String? text;
  final Shadow? shadow;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final bool strikeThrough;
  final bool underline;
  final bool overline;
  final bool italic;

  static String encode(List<RichTrexSpan> span) =>
      span.map((e) => RichTrexEncoder(e).parse).join("\n");

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
}
