import 'package:flutter/material.dart';
import 'package:richtrex_format/richtrex_format.dart';

void main() {
  runApp(const MaterialApp(title: "RichTrex: Format", home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var controller = TextEditingController(
      text:
          'lorem <style="font-weight:8;">ipsum</style> dolor <style="font-color:0xFFFF1212;">sit</style> amet');
  late String text = controller.text;
  @override
  void initState() {
    controller.addListener(() => setState(() => text = controller.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: CustomForm(
                    icon: Icons.text_fields,
                    title: "String Source",
                    child: TextField(
                        autofocus: true,
                        controller: controller,
                        maxLines: null,
                        decoration: const InputDecoration(
                            isDense: true, border: InputBorder.none)))),
            Expanded(
                child: CustomForm(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                          child: Text.rich(RichTrexFormat.decode(text))),
                    ),
                    title: "Text Span Result",
                    icon: Icons.style))
          ],
        ),
      ),
    );
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
    Color color = Colors.blue.shade800;
    return Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: color.withOpacity(0.5))),
        child: Column(children: [
          Container(
              height: 45.0,
              decoration: BoxDecoration(color: color),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8.0),
                Text(title,
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))
              ])),
          Expanded(
              child: Padding(padding: const EdgeInsets.all(8.0), child: child))
        ]));
  }
}
