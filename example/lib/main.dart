import 'package:example/src/decode_sample.dart';
import 'package:example/src/encode_sample.dart';
import 'package:flutter/material.dart';
import 'package:richtrex_format/richtrex_format.dart';

/*void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RichTrex: Format",
      home: Scaffold(
          body: SafeArea(
              child: PageView(
                  children: const [DecodeSample(), EncodeSample()])))));
}
*/

void main() {
  runApp(const MaterialApp(
      title: "Test",
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: Text.rich(TextSpan(children: [
            SpanStyle(),
            SpanWidget(),
            TextSpan(text: "SSSS")
          ]))))));
}
