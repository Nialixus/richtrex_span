import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:richtrex_image/richtrex_image.dart';
import 'package:richtrex_span/richtrex_span.dart';

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
      home: Scaffold(backgroundColor: Colors.white, body: Test())));
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const List<RichTrexSpan> spans = [
      RichTrexStyle("asas", color: Colors.red),
      RichTrexWidget("sasa", align: Alignment.center),
      RichTrexWidget.image(
          image: RichTrexImage.network(
              "https://w7.pngwing.com/pngs/193/507/png-transparent-black-survival-character-concept-art-design-game-video-game-fictional-character-thumbnail.png",
              size: Size(40, 40)))
    ];
    log(spans.map((e) => e.encode).toString());
    return const Center(child: Text.rich(TextSpan(children: spans)));
  }
}
