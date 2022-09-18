import 'package:flutter/material.dart';
import 'package:richtrex_format/richtrex_format.dart';

class DecodeSample extends StatefulWidget {
  const DecodeSample({Key? key}) : super(key: key);

  static const String text =
      """<style="font-weight:8;font-size:25;align-x:0;">RichTrex: Format</style>
<br>
This is an example of using RichTrexFormat. Key features of this package is :
1. <style="font-weight:8;">Font Weight.</style>
2. <style="font-color:0xFF4CAF50;">Font Color.</style>
3. <style="font-size:20;">Font Size.</style>
4. <style="font-family:Dancing;">Font Family.</style>
5. <style="horizontal-space:10;">Horizontal Space.</style>
6. <style="vertical-space:3;">Vertical Space.</style>
7. <style="decoration:italic;">Italic Decoration.</style>
8. <style="decoration:underline;">Underline Decoration.</style>
9. <style="decoration:strikethrough;">StrikeThrough Decoration.</style>
10. <style="decoration:overline;">Overline Decoration.</style>
<style="decoration:blockquote;">11. BlockQuote Decoration.</style>
12. <style="background-color:0xFF4CAF50;">Background Color.</style>
13. <style="shadow-color:0xFF4CAF50;shadow-blur:10;">Shadow.</style>
14. Resizable Image. <widget="image-network:https://www.kindpng.com/picc/b/355-3557482_package-icon-png.png;image-width:30;image-height:30;"/>
<style="align-x:0;align-y:0;">15. Alignment.</style>
16. <style="hyperlink:https://github.com/Nialixus;">Hyperlink.</style>
17. <style="padding-left:10.5;padding-top:10.5;">Padding.</style>""";

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
