/// An extended package of `RichTrexPackage`. This package is used to decode [TextSpan] from encoded [String].
library richtrex_span;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:richtrex_image/richtrex_image.dart';
import 'package:richtrex_span/src/regex_matcher.dart';
import 'package:url_launcher/link.dart';
part 'src/richtrex_widget.dart';
part 'src/richtrex_style.dart';

class RichTrexSpan extends InlineSpan {
  const RichTrexSpan(this.child,
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
      : assert(child is TextSpan || child is WidgetSpan);
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

  static String encode(List<RichTrexSpan> span) {
    String fromText({String? text}) {
      try {
        return text!;
      } catch (e) {
        return "";
      }
    }

    String fromColor(
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

    String fromBackgroundColor({Color? backgroundColor}) {
      try {
        return "background-color:0x${backgroundColor!.value.toRadixString(16).toUpperCase()};";
      } catch (e) {
        return "";
      }
    }

    String fromFontWeight({FontWeight? fontWeight}) {
      try {
        return "font-weight:${fontWeight!.index};";
      } catch (e) {
        return "";
      }
    }

    String fromFontSize({double? fontSize}) {
      try {
        return "font-size:${fontSize!};";
      } catch (e) {
        return "";
      }
    }

    String fromFontFamily({String? fontFamily}) {
      try {
        return "font-family:${fontFamily!};";
      } catch (e) {
        return "";
      }
    }

    String fromHorizontalSpace({double? horizontalSpace}) {
      try {
        return "horizontal-space:${horizontalSpace!};";
      } catch (e) {
        return "";
      }
    }

    String fromVerticalSpace({double? verticalSpace}) {
      try {
        return "vertical-space:${verticalSpace!};";
      } catch (e) {
        return "";
      }
    }

    String fromShadow({Shadow? shadow}) {
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

    String fromItalic({bool italic = false}) {
      if (italic) {
        return "decoration:italic;";
      } else {
        return "";
      }
    }

    String fromStrikeThrough({bool strikeThrough = false}) {
      if (strikeThrough) {
        return "decoration:strikethrough;";
      } else {
        return "";
      }
    }

    String fromUnderline({bool underline = false}) {
      if (underline) {
        return "decoration:underline;";
      } else {
        return "";
      }
    }

    String fromOverline({bool overline = false}) {
      if (overline) {
        return "decoration:overline;";
      } else {
        return "";
      }
    }

    String fromBlockQuote({bool blockquote = false}) {
      if (blockquote) {
        return "decoration:blockquote;";
      } else {
        return "";
      }
    }

    String fromPadding({EdgeInsetsGeometry? padding}) {
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

    String fromAlign({AlignmentGeometry? align}) {
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

    String fromHyperlink({String? hyperlink}) {
      try {
        return "hyperlink:${hyperlink!};";
      } catch (e) {
        return "";
      }
    }

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
      return fromText(text: text);
    } else {
      return '<style="${styles.where((e) => e.isNotEmpty).toString().replaceAll(RegExp(r'\(|\)'), "")}">${fromText(text: text)}</style>';
    }
  }

  static RichTrexSpan decode(String text) {
    List<String> toTextlist(String text) => text
        .replaceAll("\n", "<br>")
        .split(RegExp(
            r'(?=<style=")|(?<=<\/style>)|(?=<br>)|(?<=<br>)|(?=<widget)|(?<="\/>)'))
        .where((e) => e != " ")
        .toList();

    String toText(String text) => text.replaceAll(
        RegExp(r'<style=".*?;">|<\/style>|<br>|<widget=".*?;"\/>'), "");

    Color? toColor(String text) {
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

    Color? toBackgroundColor(String text) {
      try {
        String value = text.matchWith(r'(?<=background-color:).*?(?=;)')!;
        return Color(int.parse(value));
      } catch (e) {
        return null;
      }
    }

    FontWeight? toFontWeight(String text) {
      try {
        String value = text.matchWith(r'(?<=font-weight:).*?(?=;)')!;
        return FontWeight.values[int.parse(value)];
      } catch (e) {
        return null;
      }
    }

    double? toFontSize(String text) {
      try {
        String value = text.matchWith(r'(?<=font-size:).*?(?=;)')!;
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }

    String? toFontFamily(String text) {
      try {
        String value = text.matchWith(r'(?<=font-family:).*?(?=;)')!;
        return value;
      } catch (e) {
        return null;
      }
    }

    double? toHorizontalSpace(String text) {
      try {
        String value = text.matchWith(r'(?<=horizontal-space:).*?(?=;)')!;
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }

    double? toVerticalSpace(String text) {
      try {
        String value = text.matchWith(r'(?<=vertical-space:).*?(?=;)')!;
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }

    Shadow? toShadow(String text) {
      try {
        String color = text.matchWith(r'(?<=shadow-color:).*?(?=;)')!;
        String blur = text.matchWith(r'(?<=shadow-blur:).*?(?=;)')!;
        String vertical =
            text.matchWith(r'(?<=shadow-vertical:).*?(?=;)') ?? "0";
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

    bool toItalic(String text) {
      return text.contains('decoration:italic;');
    }

    bool toStrikeThrough(String text) {
      return text.contains('decoration:strikethrough;');
    }

    bool toUnderline(String text) {
      return text.contains('decoration:underline;');
    }

    bool toOverline(String text) {
      return text.contains('decoration:overline;');
    }

    bool toBlockquote(String text) {
      return text.contains('decoration:blockquote;');
    }

    EdgeInsetsGeometry? toPadding(String text) {
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

    AlignmentGeometry? toAlign(String text) {
      try {
        String? x = text.matchWith(r'(?<=align-x:).*?(?=;)');
        String? y = text.matchWith(r'(?<=align-y:).*?(?=;)');
        if (x == null && y == null) {
          return null;
        } else {
          return Alignment(x == null ? 0 : double.parse(x),
              y == null ? 0.0 : double.parse(y));
        }
      } catch (e) {
        return null;
      }
    }

    String? toHyperlink(String text) {
      return text.matchWith(r'(?<=hyperlink:).*?(?=;)');
    }

    RichTrexImage? toImage(String text) {
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

    return RichTrexStyle("text");
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
