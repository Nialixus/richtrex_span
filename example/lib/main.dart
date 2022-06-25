import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:richtrex_format/richtrex_format.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RichTrex: Format",
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String text =
      """<widget="align-horizontal:0;font-weight:8;font-size:25;">RichTrex: Format</widget>

This is an example of using RichTrexFormat. Key features of this package is :
1. <style="font-weight:8;">Font Weight.</style>
2. <style="font-color:0xFF4CAF50;">Font Color.</style>
3. <style="font-size:20;">Font Size.</style>
4. <style="font-family:Dancing;">Font Family.</style>
5. <style="font-space:10;">Font Space.</style>
6. <style="height:3;">Height.</style>
7. <style="decoration:italic;">Italic Decoration.</style>
8. <style="decoration:underline;">Underline Decoration.</style>
9. <style="decoration:strikethrough;">StrikeThrough Decoration.</style>
10. <style="decoration:overline;">Overline Decoration.</style>
<widget="decoration:blockquote;"> 11. BlockQuote Decoration.</widget>
12. <style="background-color:0xFF4CAF50;">Background Color.</style>
13. <style="shadow-color:0xFF4CAF50;shadow-blur:10;">Shadow.</style>
14. Resizable Image. <widget="image-network:https://www.kindpng.com/picc/b/355-3557482_package-icon-png.png;image-width:30;image-height:30;"/>
<widget="align-horizontal:1;">15. Alignment.</widget>
16. <widget="hyperlink:https://github.com/Nialixus;">Hyperlink.</widget>
""";

  String newt = '2. <style="font-color:0xFF4CAF50;">Font Color.</style>';

  late TextEditingController controller = TextEditingController()
    ..value = TextEditingValue(
        text: text, selection: TextSelection.collapsed(offset: text.length));

  @override
  Widget build(BuildContext context) {
    var decode = RichTrexFormat.decode(newt,
        style: const TextStyle(color: Colors.black, height: 1.5));
    Future.value(decode).then((value) {
      var a = RichTrexFormat.encode(value);
      log(a);
    });
    return Scaffold(
        body: SafeArea(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: CustomForm(
              icon: Icons.text_fields,
              title: "String Input",
              child: Scrollbar(
                  child: TextField(
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
      Expanded(
          child: CustomForm(
              icon: Icons.style,
              title: "Text Span Output",
              child: Scrollbar(
                  child: SingleChildScrollView(child: Text.rich(decode)))))
    ])));
  }
}

class CustomForm extends StatelessWidget {
  const CustomForm(
      {Key? key, required this.child, required this.title, required this.icon})
      : super(key: key);
  final Widget child;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: const BoxDecoration(color: Colors.white),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              child: Container(
                  child: child,
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.025),
                      border: Border.all(
                          width: 1, color: Colors.black.withOpacity(0.1)))))
        ]));
  }
}
