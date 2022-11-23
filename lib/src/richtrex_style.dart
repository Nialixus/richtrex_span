part of '../richtrex_span.dart';

class RichTrexStyle extends RichTrexSpan {
  const RichTrexStyle(String text,
      {double? fontSize,
      Color? color,
      double? verticalSpace,
      double? horizontalSpace,
      Color? backgroundColor,
      Shadow? shadow,
      String? fontFamily,
      FontWeight? fontWeight,
      bool strikeThrough = false,
      bool underline = false,
      bool overline = false,
      bool italic = false})
      : super(const TextSpan(),
            backgroundColor: backgroundColor,
            color: color,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
            horizontalSpace: horizontalSpace,
            italic: italic,
            overline: overline,
            shadow: shadow,
            strikeThrough: strikeThrough,
            text: text,
            underline: underline,
            verticalSpace: verticalSpace);

  @override
  TextSpan get child => TextSpan(
      text: text,
      style: TextStyle(
          color: color,
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
