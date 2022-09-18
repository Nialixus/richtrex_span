import 'package:example/src/decode_sample.dart';
import 'package:example/src/encode_sample.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RichTrex: Format",
      home: Scaffold(
          body: SafeArea(
              child: PageView(
                  children: const [DecodeSample(), EncodeSample()])))));
}
