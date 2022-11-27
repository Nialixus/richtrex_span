import 'package:example/src/debug_console.dart';
import 'package:example/src/debug_viewport.dart';
import 'package:flutter/material.dart';
import 'package:richtrex_span/richtrex_span.dart';

class DecodeSample extends StatefulWidget {
  const DecodeSample({Key? key}) : super(key: key);

  @override
  State<DecodeSample> createState() => _DecodeSampleState();
}

class _DecodeSampleState extends State<DecodeSample> {
  String text =
      """<style="font-weight:6;font-size:25.0;align-x:0.0;align-y:0.0;">RichTrex: Format</style>

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
14. Resizable Image<widget="image-network:https://avatars.githubusercontent.com/u/45191605?v=4;image-width:70.0;image-height:70.0;"/>
<style="align-x:0.0;align-y:0.0;">15. Alignment</style>
<style="hyperlink:https://github.com/Nialixus;">16. Hyperlink</style>
<style="padding-left:20.0;padding-top: 20.0;padding-right: 20.0;padding-bottom: 20.0;">17. Padding</style>""";

  late TextEditingController controller = TextEditingController(text: text);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: DebugConsole(
                  label: "String Input",
                  editable: true,
                  controller: controller
                    ..addListener(() {
                      setState(() => text = controller.text);
                    }))),
          Expanded(
              child: DebugViewport(
                  label: "rich_trex_span > decode_sample",
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Text.rich(
                          TextSpan(children: RichTrexSpan.decode(text)),
                          key: UniqueKey()))))
        ]);
  }
}
