part of 'package:richtrex_format/richtrex_format.dart';

class RichTrexSpan extends WidgetSpan {
  const RichTrexSpan(
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

  const RichTrexSpan.image({required this.image})
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

extension _RichTrexDecoder on String {
  static List<String> toTextlist(String text) => text.split(RegExp(
      r'(?=<style=")|(?<=<\/style>)|(?=\n)|(?<=\n)|(?=<br>)|(?<=<br>)|(?=<widget)|(?<="\/>)'));

  static String toText(String text) => text.replaceAll(
      RegExp(r'<style=".*?;">|<\/style>|<br>|<widget=".*?;"\/>'), "");

  static Color? toColor(String text) {
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

  static Color? toBackgroundColor(String text) {
    try {
      String value = text.matchWith(r'(?<=background-color:).*?(?=;)')!;
      return Color(int.parse(value));
    } catch (e) {
      return null;
    }
  }

  static FontWeight? toFontWeight(String text) {
    try {
      String value = text.matchWith(r'(?<=font-weight:).*?(?=;)')!;
      return FontWeight.values[int.parse(value)];
    } catch (e) {
      return null;
    }
  }

  static double? toFontSize(String text) {
    try {
      String value = text.matchWith(r'(?<=font-size:).*?(?=;)')!;
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  static String? toFontFamily(String text) {
    try {
      String value = text.matchWith(r'(?<=font-family:).*?(?=;)')!;
      return value;
    } catch (e) {
      return null;
    }
  }

  static double? toHorizontalSpace(String text) {
    try {
      String value = text.matchWith(r'(?<=horizontal-space:).*?(?=;)')!;
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  static double? toVerticalSpace(String text) {
    try {
      String value = text.matchWith(r'(?<=vertical-space:).*?(?=;)')!;
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  static Shadow? toShadow(String text) {
    try {
      String color = text.matchWith(r'(?<=shadow-color:).*?(?=;)')!;
      String blur = text.matchWith(r'(?<=shadow-blur:).*?(?=;)')!;
      String vertical = text.matchWith(r'(?<=shadow-vertical:).*?(?=;)') ?? "0";
      String horizontal =
          text.matchWith(r'(?<=shadow-horizontal:).*?(?=;)') ?? "0";

      return Shadow(
          color: Color(int.parse(color)),
          blurRadius: double.parse(blur),
          offset: Offset(double.parse(horizontal), double.parse(vertical)));
    } catch (e) {
      return null;
    }
  }

  static bool toItalic(String text) {
    return text.contains('decoration:italic;');
  }

  static bool toStrikeThrough(String text) {
    return text.contains('decoration:strikethrough;');
  }

  static bool toUnderline(String text) {
    return text.contains('decoration:underline;');
  }

  static bool toOverline(String text) {
    return text.contains('decoration:overline;');
  }

  static bool toBlockquote(String text) {
    return text.contains('decoration:blockquote;');
  }

  static EdgeInsetsGeometry? toPadding(String text) {
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

  static bool toNewline(String text) {
    return text.contains('\n');
  }

  static bool toBlankSpace(String text) {
    return text.contains("<br>");
  }

  static AlignmentGeometry? toAlign(String text) {
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

  static String? toHyperlink(String text) {
    return text.matchWith(r'(?<=hyperlink:).*?(?=;)');
  }

  static RichTrexImage? toImage(String text) {
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

  TextSpan decode([TextStyle style = const TextStyle(color: Colors.black)]) {
    List<String> texts = toTextlist(this);
    return TextSpan(
        children: List.generate(
            texts.length,
            (x) => toImage(texts[x]) != null
                ? RichTrexSpan.image(image: toImage(texts[x]))
                : RichTrexSpan(
                    style: style,
                    text: toText(texts[x]),
                    align: toAlign(texts[x]),
                    backgroundColor: toBackgroundColor(texts[x]),
                    blockquote: toBlockquote(texts[x]),
                    color: toColor(texts[x]),
                    fontFamily: toFontFamily(texts[x]),
                    fontSize: toFontSize(texts[x]),
                    fontWeight: toFontWeight(texts[x]),
                    horizontalSpace: toHorizontalSpace(texts[x]),
                    hyperlink: toHyperlink(texts[x]),
                    italic: toItalic(texts[x]),
                    newline: toNewline(texts[x]),
                    blankSpace: toBlankSpace(texts[x]),
                    overline: toOverline(texts[x]),
                    strikeThrough: toStrikeThrough(texts[x]),
                    underline: toUnderline(texts[x]),
                    verticalSpace: toVerticalSpace(texts[x]),
                    padding: toPadding(texts[x]),
                    shadow: toShadow(texts[x]))));
  }
}

extension _RichTrexEncoder on RichTrexSpan {
  static String fromText({String? text}) {
    try {
      return text!;
    } catch (e) {
      return "";
    }
  }

  static String fromColor(
      {Color? color, bool blockquote = false, String? hyperlink}) {
    try {
      if (hyperlink != null) {
        return "";
      } else if (blockquote) {
        return "";
      } else if (color != null) {
        return "font-color:0x${color.value.toRadixString(16).toUpperCase()};";
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  static String fromBackgroundColor({Color? backgroundColor}) {
    try {
      return "background-color:0x${backgroundColor!.value.toRadixString(16).toUpperCase()};";
    } catch (e) {
      return "";
    }
  }

  static String fromFontWeight({FontWeight? fontWeight}) {
    try {
      return "font-weight:${fontWeight!.index};";
    } catch (e) {
      return "";
    }
  }

  static String fromFontSize({double? fontSize}) {
    try {
      return "font-size:${fontSize!};";
    } catch (e) {
      return "";
    }
  }

  static String fromFontFamily({String? fontFamily}) {
    try {
      return "font-family:${fontFamily!};";
    } catch (e) {
      return "";
    }
  }

  static String fromHorizontalSpace({double? horizontalSpace}) {
    try {
      return "horizontal-space:${horizontalSpace!};";
    } catch (e) {
      return "";
    }
  }

  static String fromVerticalSpace({double? verticalSpace}) {
    try {
      return "vertical-space:${verticalSpace!};";
    } catch (e) {
      return "";
    }
  }

  static String fromShadow({Shadow? shadow}) {
    try {
      String color = shadow != null
          ? "shadow-color:0x${shadow.color.value.toRadixString(16).toUpperCase()};"
          : "";
      String blur = shadow != null ? "shadow-blur:${shadow.blurRadius};" : "";
      String vertical =
          shadow != null ? "shadow-vertical:${shadow.offset.dy};" : "";
      String horizontal =
          shadow != null ? "shadow-horizontal:${shadow.offset.dx};" : "";

      return "$color$blur$vertical$horizontal";
    } catch (e) {
      return "";
    }
  }

  static String fromItalic({bool italic = false}) {
    if (italic) {
      return "decoration:italic;";
    } else {
      return "";
    }
  }

  static String fromStrikeThrough({bool strikeThrough = false}) {
    if (strikeThrough) {
      return "decoration:strikethrough;";
    } else {
      return "";
    }
  }

  static String fromUnderline({bool underline = false}) {
    if (underline) {
      return "decoration:underline;";
    } else {
      return "";
    }
  }

  static String fromOverline({bool overline = false}) {
    if (overline) {
      return "decoration:overline;";
    } else {
      return "";
    }
  }

  static String fromBlockQuote({bool blockquote = false}) {
    if (blockquote) {
      return "decoration:blockquote;";
    } else {
      return "";
    }
  }

  static String fromPadding({EdgeInsetsGeometry? padding}) {
    try {
      if (padding != null) {
        List<String> edges = (padding
            .add(const EdgeInsets.only(left: 1.3))
            .toString()
            .replaceAll(RegExp(r"EdgeInsets\(|\)"), "")
            .split(RegExp(r"(?<=\..)")));
        return "padding-left:${double.parse(edges[0]) - 1.3};padding-top:${edges[1]};padding-right:${edges[2]};padding-bottom:${edges[3]};";
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  static String fromBlankSpace({bool blankSpace = false}) {
    if (blankSpace) {
      return "<br>";
    } else {
      return "";
    }
  }

  static String fromAlign({AlignmentGeometry? align}) {
    try {
      if (align != null) {
        Offset axis() {
          if (align == Alignment.topLeft) {
            return const Offset(-1, -1);
          } else if (align == Alignment.topCenter) {
            return const Offset(0, -1);
          } else if (align == Alignment.topRight) {
            return const Offset(1, -1);
          } else if (align == Alignment.centerLeft) {
            return const Offset(-1, 0);
          } else if (align == Alignment.center) {
            return const Offset(0, 0);
          } else if (align == Alignment.centerLeft) {
            return const Offset(1, 0);
          } else if (align == Alignment.bottomLeft) {
            return const Offset(-1, 1);
          } else if (align == Alignment.bottomCenter) {
            return const Offset(0, 1);
          } else if (align == Alignment.bottomRight) {
            return const Offset(1, 1);
          } else {
            throw Error();
          }
        }

        return "align-x:${axis().dx};align-y:${axis().dy};";
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  String fromImage({RichTrexImage? image}) {
    try {
      String type() {
        String img = image!.toString();
        if (img.contains("RichTrexNetworkImage")) {
          return "image-network:${image.source};";
        } else if (img.contains("RichTrexMemoryImage")) {
          return "image-memory:${image.source};";
        } else if (img.contains("RichTrexAssetImage")) {
          return "image-asset:${image.source};";
        } else if (img.contains("RichTrexFileImage")) {
          return "image-file:${image.source};";
        } else {
          throw Error();
        }
      }

      return '<widget="${type()}image-width:${image!.size.width};image-height:${image.size.height};"/>';
    } catch (e) {
      return "";
    }
  }

  static String fromHyperlink({String? hyperlink}) {
    try {
      return "hyperlink:${hyperlink!};";
    } catch (e) {
      return "";
    }
  }

  static String fromNewLine({bool newline = false}) {
    if (newline) {
      return "\n";
    } else {
      return "";
    }
  }

  String get encode {
    List<String> styles = [
      fromColor(color: color, blockquote: blockquote, hyperlink: hyperlink),
      fromBackgroundColor(backgroundColor: backgroundColor),
      fromFontWeight(fontWeight: fontWeight),
      fromFontSize(fontSize: fontSize),
      fromFontFamily(fontFamily: fontFamily),
      fromHorizontalSpace(horizontalSpace: horizontalSpace),
      fromVerticalSpace(verticalSpace: verticalSpace),
      fromShadow(shadow: shadow),
      fromItalic(italic: italic),
      fromStrikeThrough(strikeThrough: strikeThrough),
      fromUnderline(underline: underline),
      fromOverline(overline: overline),
      fromBlockQuote(blockquote: blockquote),
      fromPadding(padding: padding),
      fromAlign(align: align),
      fromHyperlink(hyperlink: hyperlink)
    ];

    if (image != null) {
      return fromImage(image: image);
    } else if (styles.where((e) => e == "").length == styles.length) {
      return fromText(text: text) +
          fromNewLine(newline: newline) +
          fromBlankSpace(blankSpace: blankSpace);
    } else {
      return '<style="${styles.toString().replaceAll(" ", "")}">${fromText(text: text)}</style>' +
          fromNewLine(newline: newline) +
          fromBlankSpace(blankSpace: blankSpace);
    }
  }
}
