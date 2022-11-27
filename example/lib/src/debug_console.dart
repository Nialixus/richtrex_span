import 'package:flutter/material.dart';

class DebugConsole extends StatelessWidget {
  const DebugConsole(
      {Key? key,
      required this.controller,
      required this.label,
      this.onChanged,
      this.editable = false})
      : super(key: key);
  final String label;
  final TextEditingController controller;
  final bool editable;
  final void Function(String text)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
            color: Color(0xff1E1E1E),
            border:
                Border(top: BorderSide(width: 1, color: Color(0xff3C3C3C)))),
        child: Column(children: [
          DecoratedBox(
              decoration: const BoxDecoration(
                  color: Color(0xff1E1E1E),
                  boxShadow: [BoxShadow(color: Colors.black)]),
              child: Row(children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.white))),
                    child: Text(label.toUpperCase(),
                        style: const TextStyle(
                            color: Color(0xffC7D1CD),
                            fontWeight: FontWeight.w400,
                            fontSize: 11.0))),
                const Spacer()
              ])),
          Expanded(
              child: Scrollbar(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: TextField(
                              maxLines: null,
                              autofocus: true,
                              enabled: editable,
                              controller: controller,
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff2D77D3)),
                              decoration: const InputDecoration(
                                  isDense: true, border: InputBorder.none))))))
        ]));
  }
}
