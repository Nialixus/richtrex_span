import 'package:example/src/debug_console.dart';
import 'package:example/src/debug_viewport.dart';
import 'package:flutter/material.dart';
import 'package:richtrex_image/richtrex_image.dart';
import 'package:richtrex_span/richtrex_span.dart';

class EncodeSample extends StatelessWidget {
  const EncodeSample({Key? key}) : super(key: key);

  static const List<RichTrexSpan> span = [
    RichTrexSpan(
        text: "RichTrex: Format",
        fontWeight: FontWeight.bold,
        fontSize: 25,
        align: Alignment.center),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(
        text:
            "This is an Example of using RichTrexFormat. Key features of this package is :"),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "1. Font Weight", fontWeight: FontWeight.bold),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "2. Font Color", color: Colors.red),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "3. Font Size", fontSize: 40.0),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "4. Font Family", fontFamily: "Dancing"),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "5. Horizontal Space", horizontalSpace: 5.0),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "6. Vertical Space", verticalSpace: 2.0),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "7. Italic Decoration", italic: true),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "8. Underline Decoration", underline: true),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "9. StrikeThrough Decoration", strikeThrough: true),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "10. Overline Decoration", overline: true),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "11. BlockQuote Decoration", blockquote: true),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "12. Background Color", backgroundColor: Colors.blue),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(
        text: "13. Shadow",
        shadow:
            Shadow(color: Colors.red, blurRadius: 10, offset: Offset(-1, -1))),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "14. Resizable Image"),
    RichTrexSpan.image(
        image: RichTrexImage.network(
            "https://avatars.githubusercontent.com/u/45191605?v=4",
            size: Size(70, 70))),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "15. Alignment", align: Alignment.center),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(
        text: "16. Hyperlink", hyperlink: "https://github.com/Nialixus"),
    RichTrexSpan(text: "\n"),
    RichTrexSpan(text: "17. Padding", padding: EdgeInsets.all(20.0))
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
