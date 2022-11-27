import 'package:flutter/material.dart';

class DebugHeader extends StatelessWidget {
  const DebugHeader({Key? key, required this.active, required this.onTap})
      : super(key: key);
  final bool Function(int x) active;
  final void Function(int x) onTap;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (int x = 0; x < 2; x++)
        Expanded(
            child: Material(
                color: active(x)
                    ? const Color(0xff1e1e1e)
                    : const Color(0xff2D2D2D),
                child: InkWell(
                    onTap: () => onTap(x),
                    highlightColor: Colors.transparent,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Row(children: [
                          const Icon(Icons.telegram,
                              color: Colors.blue, size: 18.0),
                          const SizedBox(width: 8.0),
                          Expanded(
                              child: Text(["Encoder", "Decoder"][x],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12.0))),
                          if (active(x))
                            const Icon(Icons.clear,
                                color: Colors.white, size: 12.0)
                        ])))))
    ]);
  }
}
