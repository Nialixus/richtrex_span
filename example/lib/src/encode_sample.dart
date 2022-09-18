import 'package:flutter/material.dart';
import 'package:richtrex_format/richtrex_format.dart';
import 'package:richtrex_image/richtrex_image.dart';

class EncodeSample extends StatelessWidget {
  const EncodeSample({Key? key}) : super(key: key);

  static const List<RichTrexEncoder> span = [
    RichTrexEncoder(
        text: "RichTrex: Format",
        fontWeight: FontWeight.bold,
        fontSize: 25,
        align: Alignment.center),
    RichTrexEncoder(blankSpace: true),
    RichTrexEncoder(
        text:
            "This is an Example of using RichTrexFormat. Key features of this package is :"),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "1. Font Weight", fontWeight: FontWeight.bold),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "2. Font Color", color: Colors.red),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "3. Font Size", fontSize: 40.0),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "4. Font Family", fontFamily: "Dancing"),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "5. Horizontal Space", horizontalSpace: 5.0),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "6. Vertical Space", verticalSpace: 2.0),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "7. Italic Decoration", italic: true),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "8. Underline Decoration", underline: true),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "9. StrikeThrough Decoration", strikeThrough: true),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "10. Overline Decoration", overline: true),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "11. BlockQuote Decoration", blockquote: true),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "12. Background Color", backgroundColor: Colors.blue),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(
        text: "13. Shadow",
        shadow:
            Shadow(color: Colors.red, blurRadius: 10, offset: Offset(-1, -1))),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "14. Resizable Image"),
    RichTrexEncoder.image(
        image: RichTrexImage.network(
            "https://www.kindpng.com/picc/b/355-3557482_package-icon-png.png",
            size: Size(30, 30))),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "15. Alignment", align: Alignment.center),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(
        text: "16. Hyperlink", hyperlink: "https://github.com/Nialixus"),
    RichTrexEncoder(newline: true),
    RichTrexEncoder(text: "17. Padding", padding: EdgeInsets.all(20.0))
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("TextSpan Input",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          Expanded(
              child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.blue)),
                  child: const Scrollbar(
                      child: SingleChildScrollView(
                          padding: EdgeInsets.all(10),
                          child: Text.rich(TextSpan(children: span)))))),
          const Text("String Output",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          Expanded(
              child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.blue)),
                  child: Scrollbar(
                      child: TextField(
                          scrollPadding: const EdgeInsets.all(10),
                          maxLines: null,
                          autofocus: true,
                          controller: TextEditingController(
                              text: RichTrexFormat.encode(span)),
                          style: const TextStyle(
                              fontSize: 12.0,
                              height: 1.5,
                              fontWeight: FontWeight.w400),
                          decoration: const InputDecoration(
                              isDense: true, border: InputBorder.none)))))
        ]);
  }
}
