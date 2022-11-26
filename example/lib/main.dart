import 'package:example/src/encode_sample.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RichTrex: Span",
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  PageController get controller => PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Row(children: [
        for (int x = 0; x < 2; x++)
          Expanded(
              child: InkWell(
                  onTap: () => controller.animateToPage(x,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn),
                  child: Text(["Encoder", "Decoder"][x])))
      ]),
      Expanded(
          child: PageView(
              controller: controller,
              children: const [EncodeSample(), Text("data")]))
    ])));
  }
}
