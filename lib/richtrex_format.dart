/// An extended package of `RichTrexPackage`. This package is used to decode [TextSpan] from encoded [String].
library richtrex_format;
/*
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
*/

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:richtrex_image/richtrex_image.dart';

class RichTrexSpan extends InlineSpan {
  const RichTrexSpan(this.child)
      : assert(child is TextSpan || child is WidgetSpan);
  final InlineSpan child;

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

class SpanStyle extends RichTrexSpan {
  const SpanStyle({this.color}) : super(const TextSpan());
  final Color? color;

  @override
  TextSpan get child =>
      TextSpan(text: "TULISAN", style: TextStyle(color: Colors.red));
}

class SpanWidget extends RichTrexSpan {
  const SpanWidget({this.color}) : super(const WidgetSpan(child: SizedBox()));
  final Color? color;

  @override
  WidgetSpan get child => WidgetSpan(child: Text("WIDGET"));
}
