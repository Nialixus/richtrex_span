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
  String text =
      'The <widget="hyperlink:https://github.com/Nialixus;"> link</widget> is here.';
  //'<widget="image-network:https://edinburghuniform.org/wp-content/uploads/2019/11/twitter-logo-png-twitter-logo-vector-png-clipart-library-518.png;image-width:100;image-height:100;"/>';
  //'lorem <style="align:2;">Align</style> <style="font-weight:8;font-size:10;">ipsum</style> dolor <style="font-color:0xFFFF1212;decoration:italic;">sit</style> amet';
  late TextEditingController controller = TextEditingController()
    ..value = TextEditingValue(
        text: text, selection: TextSelection.collapsed(offset: text.length));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: CustomForm(
              icon: Icons.text_fields,
              title: "String Input",
              child: TextField(
                  autofocus: true,
                  controller: controller,
                  onChanged: (text) => setState(() => this.text = text),
                  maxLines: null,
                  decoration: const InputDecoration(
                      isDense: true, border: InputBorder.none)))),
      Expanded(
          child: CustomForm(
              icon: Icons.style,
              title: "Text Span Output",
              child: Scrollbar(
                  child: SingleChildScrollView(
                      child: Text.rich(RichTrexFormat.decode(
                          text,
                          const TextStyle(
                              color: Colors.black, fontSize: 16.0)))))))
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
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.025),
                      border: Border.all(
                          width: 1, color: Colors.black.withOpacity(0.1))),
                  child: child))
        ]));
  }
}
