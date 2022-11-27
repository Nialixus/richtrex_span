import 'package:example/src/debug_header.dart';
import 'package:example/src/decode_sample.dart';
import 'package:example/src/encode_sample.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RichTrex: Span",
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      DebugHeader(
          active: (x) => index == x, onTap: (x) => setState(() => index = x)),
      Expanded(child: const [EncodeSample(), DecodeSample()][index])
    ])));
  }
}
