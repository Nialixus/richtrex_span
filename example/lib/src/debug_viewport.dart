import 'package:flutter/material.dart';

class DebugViewport extends StatelessWidget {
  const DebugViewport({Key? key, required this.child, required this.label})
      : super(key: key);
  final Widget child;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Color(0xff1e1e1e)),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(label,
                  style: const TextStyle(
                      color: Color(0xffC7D1CD),
                      fontWeight: FontWeight.w400,
                      fontSize: 13.0))),
          Expanded(
              child: Scrollbar(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(), child: child)))
        ]));
  }
}
