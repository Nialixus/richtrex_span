import 'package:example/src/debug_console.dart';
import 'package:example/src/debug_viewport.dart';
import 'package:flutter/material.dart';
import 'package:richtrex_image/richtrex_image.dart';
import 'package:richtrex_span/richtrex_span.dart';

class EncodeSample extends StatelessWidget {
  const EncodeSample({Key? key}) : super(key: key);

  static const List<RichTrexSpan> span = [
    RichTrexWidget("RichTrex: Format",
        fontWeight: FontWeight.bold, fontSize: 25, align: Alignment.center),
    RichTrexStyle("\n"),
    RichTrexStyle("\n"),
    RichTrexStyle(
        "This is an Example of using RichTrexFormat. Key features of this package is :"),
    RichTrexStyle("\n"),
    RichTrexStyle("1. Font Weight", fontWeight: FontWeight.bold),
    RichTrexStyle("\n"),
    RichTrexStyle("2. Font Color", color: Colors.red),
    RichTrexStyle("\n"),
    RichTrexStyle("3. Font Size", fontSize: 40.0),
    RichTrexStyle("\n"),
    RichTrexStyle("4. Font Family", fontFamily: "Dancing"),
    RichTrexStyle("\n"),
    RichTrexStyle("5. Horizontal Space", horizontalSpace: 5.0),
    RichTrexStyle("\n"),
    RichTrexStyle("6. Vertical Space", verticalSpace: 2.0),
    RichTrexStyle("\n"),
    RichTrexStyle("7. Italic Decoration", italic: true),
    RichTrexStyle("\n"),
    RichTrexStyle("8. Underline Decoration", underline: true),
    RichTrexStyle("\n"),
    RichTrexStyle("9. StrikeThrough Decoration", strikeThrough: true),
    RichTrexStyle("\n"),
    RichTrexStyle("10. Overline Decoration", overline: true),
    RichTrexStyle("\n"),
    RichTrexWidget("11. BlockQuote Decoration", blockquote: true),
    RichTrexStyle("\n"),
    RichTrexStyle("12. Background Color", backgroundColor: Colors.blue),
    RichTrexStyle("\n"),
    RichTrexStyle("13. Shadow",
        shadow:
            Shadow(color: Colors.red, blurRadius: 10, offset: Offset(-1, -1))),
    RichTrexStyle("\n"),
    RichTrexStyle("14. Resizable Image"),
    RichTrexWidget.image(RichTrexImage.network(
        "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg",
        size: Size(30, 30))),
    RichTrexStyle("\n"),
    RichTrexWidget("15. Alignment", align: Alignment.center),
    RichTrexStyle("\n"),
    RichTrexWidget("16. Hyperlink", hyperlink: "https://github.com/Nialixus"),
    RichTrexStyle("\n"),
    RichTrexWidget("17. Padding", padding: EdgeInsets.all(20.0))
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: DebugViewport(
                  label: "rich_trex_span > encode_sample",
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: const Text.rich(TextSpan(children: span))))),
          Expanded(
              child: DebugConsole(
                  label: "Encoder Output",
                  controller:
                      TextEditingController(text: RichTrexSpan.encode(span))))
        ]);
  }
}
