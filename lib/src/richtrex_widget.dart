part of '../richtrex_span.dart';

class RichTrexWidget extends RichTrexSpan {
  const RichTrexWidget(String text,
      {double? fontSize,
      Color? color,
      double? verticalSpace,
      double? horizontalSpace,
      bool blockquote = false,
      EdgeInsetsGeometry? padding,
      AlignmentGeometry? align,
      Color? backgroundColor,
      String? hyperlink,
      Shadow? shadow,
      String? fontFamily,
      FontWeight? fontWeight,
      bool strikeThrough = false,
      bool underline = false,
      bool overline = false,
      bool italic = false})
      : super(
            align: align,
            backgroundColor: backgroundColor,
            blockquote: blockquote,
            color: color,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
            horizontalSpace: horizontalSpace,
            hyperlink: hyperlink,
            italic: italic,
            overline: overline,
            padding: padding,
            shadow: shadow,
            strikeThrough: strikeThrough,
            text: text,
            underline: underline,
            verticalSpace: verticalSpace);

  const RichTrexWidget.image({required RichTrexImage image})
      : super(image: image);

  @override
  WidgetSpan get child => WidgetSpan(
      child: image != null
          ? image!
          : Container(
              decoration: blockquote == true
                  ? BoxDecoration(
                      color: Colors.grey.shade200,
                      border: const Border(
                          left: BorderSide(width: 4, color: Colors.grey)))
                  : null,
              padding: blockquote == true ? const EdgeInsets.all(4.0) : padding,
              constraints: blockquote == true
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
                              style: style?.copyWith(
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
}
