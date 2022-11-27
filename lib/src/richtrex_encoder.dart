import 'package:flutter/material.dart';
import 'package:richtrex_image/richtrex_image.dart';
import 'package:richtrex_span/richtrex_span.dart';

export 'richtrex_encoder.dart' hide RichTrexEncoder;

class RichTrexEncoder {
  const RichTrexEncoder(this.value);
  final RichTrexSpan value;

  String get parse {
    List<String> styles = [
      parseColor(
          color: value.color,
          blockquote: value.blockquote,
          hyperlink: value.hyperlink),
      parseBackgroundColor(backgroundColor: value.backgroundColor),
      parseFontWeight(fontWeight: value.fontWeight),
      parseFontSize(fontSize: value.fontSize),
      parseFontFamily(fontFamily: value.fontFamily),
      parseHorizontalSpace(horizontalSpace: value.horizontalSpace),
      parseVerticalSpace(verticalSpace: value.verticalSpace),
      parseShadow(shadow: value.shadow),
      parseItalic(italic: value.italic),
      parseStrikeThrough(strikeThrough: value.strikeThrough),
      parseUnderline(underline: value.underline),
      parseOverline(overline: value.overline),
      parseBlockQuote(blockquote: value.blockquote),
      parsePadding(padding: value.padding),
      parseAlign(align: value.align),
      parseHyperlink(hyperlink: value.hyperlink)
    ];
    if (value.image != null) {
      return parseImage(image: value.image);
    } else if (styles.where((e) => e == "").length == styles.length) {
      return parseText(text: value.text);
    } else {
      return '<style="${styles.where((e) => e.isNotEmpty).join()}">${parseText(text: value.text)}</style>';
    }
  }

  static String parseText({String? text}) {
    try {
      return text!;
    } catch (e) {
      return "";
    }
  }

  static String parseColor(
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

  static String parseBackgroundColor({Color? backgroundColor}) {
    try {
      return "background-color:0x${backgroundColor!.value.toRadixString(16).toUpperCase()};";
    } catch (e) {
      return "";
    }
  }

  static String parseFontWeight({FontWeight? fontWeight}) {
    try {
      return "font-weight:${fontWeight!.index};";
    } catch (e) {
      return "";
    }
  }

  static String parseFontSize({double? fontSize}) {
    try {
      return "font-size:${fontSize!};";
    } catch (e) {
      return "";
    }
  }

  static String parseFontFamily({String? fontFamily}) {
    try {
      return "font-family:${fontFamily!};";
    } catch (e) {
      return "";
    }
  }

  static String parseHorizontalSpace({double? horizontalSpace}) {
    try {
      return "horizontal-space:${horizontalSpace!};";
    } catch (e) {
      return "";
    }
  }

  static String parseVerticalSpace({double? verticalSpace}) {
    try {
      return "vertical-space:${verticalSpace!};";
    } catch (e) {
      return "";
    }
  }

  static String parseShadow({Shadow? shadow}) {
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

  static String parseItalic({bool italic = false}) {
    if (italic) {
      return "decoration:italic;";
    } else {
      return "";
    }
  }

  static String parseStrikeThrough({bool strikeThrough = false}) {
    if (strikeThrough) {
      return "decoration:strikethrough;";
    } else {
      return "";
    }
  }

  static String parseUnderline({bool underline = false}) {
    if (underline) {
      return "decoration:underline;";
    } else {
      return "";
    }
  }

  static String parseOverline({bool overline = false}) {
    if (overline) {
      return "decoration:overline;";
    } else {
      return "";
    }
  }

  static String parseBlockQuote({bool blockquote = false}) {
    if (blockquote) {
      return "decoration:blockquote;";
    } else {
      return "";
    }
  }

  static String parsePadding({EdgeInsetsGeometry? padding}) {
    try {
      if (padding != null) {
        List<String> edges = padding
            .add(const EdgeInsets.only(left: 1.3))
            .toString()
            .replaceAll(RegExp(r'EdgeInsets\(|\)'), "")
            .split(",");
        return "padding-left:${double.parse(edges[0]) - 1.3};padding-top:${edges[1]};padding-right:${edges[2]};padding-bottom:${edges[3]};";
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  static String parseAlign({AlignmentGeometry? align}) {
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

  static String parseImage({RichTrexImage? image}) {
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

  static String parseHyperlink({String? hyperlink}) {
    try {
      return "hyperlink:${hyperlink!};";
    } catch (e) {
      return "";
    }
  }
}
