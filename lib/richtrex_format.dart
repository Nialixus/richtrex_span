library richtrex_format;

import 'package:flutter/material.dart';
import 'package:richtrex_image/richtrex_image.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class RichTrexFormat {
  static TextSpan decode(String text, [TextStyle? style]) {
    // Split text between Tagged Text and Plain Text.
    List<String> textlist = text.split(RegExp(
        r'(?=<style=)|(?<=<\/style>)|(?=<widget=)|(?<=;"\/>)|(?<=<\/widget>)'));

    // Clean Text from Tag.
    String newText(String text) {
      try {
        return text.replaceAll(
            RegExp(
                r'<style=".*?">|<\/style>|<widget=.*?;"\/>|(<widget=".*?;">)|(<\/widget>)'),
            "");
      } catch (e) {
        return text;
      }
    }

    // Get Color from Tag.
    Color? color(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-color:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return Color(int.parse(value));
      } catch (e) {
        return null;
      }
    }

    // Get Background-Color from Tag.
    Color? backgroundColor(String text) {
      try {
        RegExp regex = RegExp(r'(?<=background-color:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return Color(int.parse(value));
      } catch (e) {
        return null;
      }
    }

    // Get Font-Weight from Tag.
    FontWeight? fontWeight(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-weight:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return FontWeight.values[int.parse(value)];
      } catch (e) {
        return null;
      }
    }

    // Get Font-Height from Tag.
    //
    // Removed due vertical align is not centered.
    double? fontHeight(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-height:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }

    // Get Font-Family from Tag.
    String? fontFamily(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-family:).*?(?=;)');
        return regex.stringMatch(text)!;
      } catch (e) {
        return null;
      }
    }

    // Get Font-Size from Tag.
    double? fontSize(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-size:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }

    // Get Font-Height from Tag.
    double? fontSpace(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-space:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }

    // Get Shadow from Tag.
    Shadow shadow(String text) {
      try {
        String blurRadius =
            RegExp(r'(?<=shadow-blur:).*?(?=;)').stringMatch(text)!;
        String x = RegExp(r'(?<=shadow-x:).*?(?=;)').stringMatch(text)!;
        String y = RegExp(r'(?<=shadow-y:).*?(?=;)').stringMatch(text)!;
        String color = RegExp(r'(?<=shadow-color:).*?(?=;)').stringMatch(text)!;
        return Shadow(
            color: Color(int.parse(color)),
            blurRadius: double.parse(blurRadius),
            offset: Offset(double.parse(x), double.parse(y)));
      } catch (e) {
        return const Shadow(
            blurRadius: 0.0, color: Colors.transparent, offset: Offset(0, 0));
      }
    }

    // Get Italic from Tag.
    FontStyle? italic(String text) {
      try {
        bool value = text.contains('decoration:italic;');
        return value == true ? FontStyle.italic : null;
      } catch (e) {
        return null;
      }
    }

    // Get Strikethrough from Tag.
    TextDecoration strikeThrough(String text) {
      try {
        bool value = text.contains('decoration:strikethrough;');
        return value == true ? TextDecoration.lineThrough : TextDecoration.none;
      } catch (e) {
        return TextDecoration.none;
      }
    }

    // Get Underline from Tag.
    TextDecoration underline(String text) {
      try {
        bool value = text.contains('decoration:underline;');
        return value == true ? TextDecoration.underline : TextDecoration.none;
      } catch (e) {
        return TextDecoration.none;
      }
    }

    // Get Overline from Tag.
    TextDecoration overline(String text) {
      try {
        bool value = text.contains('decoration:overline;');
        return value == true ? TextDecoration.overline : TextDecoration.none;
      } catch (e) {
        return TextDecoration.none;
      }
    }

    // Get Text-Align from Tag.
    TextAlign? textAlign(String text) {
      try {
        RegExp regex = RegExp(r'(?<=text-align:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return TextAlign.values[int.parse(value)];
      } catch (e) {
        return null;
      }
    }

    // Get Image from Tag.
    RichTrexImage? image(String text) {
      try {
        String? network =
            RegExp(r'(?<=image-network:).*?(?=;)').stringMatch(text);
        String? memory =
            RegExp(r'(?<=image-memory:).*?(?=;)').stringMatch(text);
        String? file = RegExp(r'(?<=image-file:).*?(?=;)').stringMatch(text);
        String? asset = RegExp(r'(?<=image-asset:).*?(?=;)').stringMatch(text);
        String? resize =
            RegExp(r'(?<=image-resize:).*?(?=;)').stringMatch(text);
        String height =
            RegExp(r'(?<=image-height:).*?(?=;)').stringMatch(text)!;
        String width = RegExp(r'(?<=image-width:).*?(?=;)').stringMatch(text)!;

        // Parsed [size] from [width] and [height].
        Size size = Size(double.parse(width), double.parse(height));

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
    }

    Future<bool>? hyperlink(String text) {
      try {
        RegExp regex = RegExp(r'(?<=hyperlink:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return launchUrl(Uri.parse(value));
      } catch (e) {
        return null;
      }
    }

    BoxBorder? blockQuote(String text) {
      try {
        bool value = text.contains("decoration:blockquote;");
        if (value == true) {
          return const Border(left: BorderSide(width: 4, color: Colors.grey));
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    }

    // Generated InlineSpan from Tag.
    return TextSpan(
        children: List.generate(textlist.length, (x) {
      TextStyle textStyle = (style ?? const TextStyle(color: Colors.black))
          .copyWith(
              leadingDistribution: TextLeadingDistribution.even,
              color: color(textlist[x]),
              fontStyle: italic(textlist[x]),
              height: fontHeight(textlist[x]),
              fontSize: fontSize(textlist[x]),
              shadows: [shadow(textlist[x])],
              fontWeight: fontWeight(textlist[x]),
              fontFamily: fontFamily(textlist[x]),
              letterSpacing: fontSpace(textlist[x]),
              backgroundColor: backgroundColor(textlist[x]),
              decoration: TextDecoration.combine([
                overline(textlist[x]),
                underline(textlist[x]),
                strikeThrough(textlist[x])
              ]));
      // Generated [TextSpan].
      TextSpan textSpan =
          TextSpan(text: newText(textlist[x]), style: textStyle);

      // Generated [WidgetSpan].
      WidgetSpan widgetSpan = WidgetSpan(
          child: Container(
              decoration: BoxDecoration(border: blockQuote(textlist[x])),
              constraints: (textAlign(textlist[x]) == null &&
                      blockQuote(textlist[x]) == null)
                  ? null
                  : const BoxConstraints(minWidth: double.infinity),
              child: Material(
                  child: InkWell(
                      onTap: hyperlink(textlist[x]) == null
                          ? null
                          : () => hyperlink(textlist[x]),
                      child: Text.rich(textSpan,
                          textAlign: textAlign(textlist[x]))))));

      // [TextSpan] with `<style ... ></style>` tag.
      if (textlist[x].contains(RegExp(r'<style=.*?\/style>'))) {
        return textSpan;

        // [WidgetSpan] with `<widget ... ></widget>` tag.
      } else if (textlist[x]
          .contains(RegExp(r'(<widget=.*?;"\/>)|(<widget=.*?<\/widget>)'))) {
        // Available widgets.
        List<Widget?> child = [image(textlist[x])];

        // Put the last available widget into [WidgetSpan].
        try {
          return WidgetSpan(child: child.lastWhere((e) => e != null)!);

          // Just put [widgetSpan].
        } catch (e) {
          return widgetSpan;
        }

        // Default put [textSpan].
      } else {
        return textSpan;
      }
    }));
  }
}
