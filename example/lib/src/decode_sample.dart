import 'package:flutter/material.dart';
import 'package:richtrex_format/richtrex_format.dart';

class DecodeSample extends StatefulWidget {
  const DecodeSample({Key? key}) : super(key: key);

  static const String text =
      """<style="font-weight:6;font-size:25.0;align-x:0.0;align-y:0.0;">RichTrex: Format</style>
      <br>
This is an Example of using RichTrexFormat. Key features of this package is : 
<style="font-weight:6;">1. Font Weight</style> 
<style="font-color:0xFFF44336;">2. Font Color</style> 
<style="font-size:40.0;">3. Font Size</style> 
<style="font-family:Dancing;">4. Font Family</style> 
<style="horizontal-space:5.0;">5. Horizontal Space</style> 
<style="vertical-space:2.0;">6. Vertical Space</style> 
<style="decoration:italic;">7. Italic Decoration</style> 
<style="decoration:underline;">8. Underline Decoration</style> 
<style="decoration:strikethrough;">9. StrikeThrough Decoration</style> 
<style="decoration:overline;">10. Overline Decoration</style> 
<style="decoration:blockquote;">11. BlockQuote Decoration</style> 
<style="background-color:0xFF2196F3;">12. Background Color</style> 
<style="shadow-color:0xFFF44336;shadow-blur:10.0;shadow-vertical:-1.0;shadow-horizontal:-1.0;">13. Shadow</style> 
14. Resizable Image <widget="image-network:https://www.kindpng.com/picc/b/355-3557482_package-icon-png.png;image-width:30.0;image-height:30.0;"/> 
<style="align-x:0.0;align-y:0.0;">15. Alignment</style> 
<style="hyperlink:https://github.com/Nialixus;">16. Hyperlink</style> 
<style="padding-left:20.0;padding-top:20.0;padding-right:20.0;padding-bottom:20.0;">17. Padding</style>""";

  @override
  State<DecodeSample> createState() => _DecodeSampleState();
}

class _DecodeSampleState extends State<DecodeSample> {
  String text = DecodeSample.text;
  late TextEditingController controller = TextEditingController(text: text);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      const Text("String Input",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
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
                      controller: controller,
                      onChanged: (text) => setState(() => this.text = text),
                      style: const TextStyle(
                          fontSize: 12.0,
                          height: 1.5,
                          fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                          isDense: true, border: InputBorder.none))))),
      const Text("TextSpan Output",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
      Expanded(
          child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.blue)),
              child: Scrollbar(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: Text.rich(RichTrexFormat.decode(text))))))
    ]);
  }
}
