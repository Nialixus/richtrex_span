part of 'package:richtrex_format/richtrex_format.dart';

class RichTrexEncoder extends WidgetSpan {
  @override
  String toPlainText(
      {bool includeSemanticsLabels = true, bool includePlaceholders = true}) {
    return "$text";
  }

  const RichTrexEncoder(
      {this.text,
      TextStyle? style,
      this.blockquote = false,
      this.padding,
      this.newline = false,
      this.align,
      this.backgroundColor,
      this.hyperlink,
      this.shadow,
      this.horizontalSpace,
      this.verticalSpace,
      this.color,
      this.fontSize,
      this.fontFamily,
      this.fontWeight,
      this.overline = false,
      this.strikeThrough = false,
      this.underline = false,
      this.blankSpace = false,
      this.italic = false})
      : image = null,
        super(child: const SizedBox(), style: style ?? const TextStyle());

  const RichTrexEncoder.image({required this.image})
      : blockquote = false,
        padding = null,
        fontFamily = null,
        newline = false,
        backgroundColor = null,
        align = null,
        blankSpace = false,
        hyperlink = null,
        text = null,
        italic = false,
        shadow = null,
        color = null,
        fontSize = null,
        fontWeight = null,
        verticalSpace = null,
        horizontalSpace = null,
        strikeThrough = false,
        overline = false,
        underline = false,
        assert(image != null),
        super(child: const SizedBox(), style: const TextStyle());

  @override
  PlaceholderAlignment get alignment => PlaceholderAlignment.baseline;

  @override
  TextBaseline? get baseline => TextBaseline.alphabetic;

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
  final bool newline;
  final bool blankSpace;

  @override
  Widget get child {
    if (image != null) {
      return image!;
    } else {
      return Container(
          decoration: blockquote == true
              ? BoxDecoration(
                  color: Colors.grey.shade200,
                  border: const Border(
                      left: BorderSide(width: 4, color: Colors.grey)))
              : null,
          padding: blockquote == true ? const EdgeInsets.all(4.0) : padding,
          constraints: blockquote == true
              ? const BoxConstraints(minWidth: double.infinity)
              : blankSpace == true
                  ? const BoxConstraints(
                      minWidth: double.infinity, minHeight: 20)
                  : newline == true
                      ? const BoxConstraints(
                          minWidth: double.infinity, maxHeight: 0)
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
                              leadingDistribution: TextLeadingDistribution.even,
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
                                if (underline == true) TextDecoration.underline,
                                if (overline == true) TextDecoration.overline
                              ])))))));
    }
  }
}
