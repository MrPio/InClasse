import 'package:flutter/cupertino.dart';

import '../../constant/fonts.dart';

class Line extends StatelessWidget {
  final String text;
  final Color color;

  const Line({Key? key, this.text = "Oppure", this.color = CupertinoColors.systemGrey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: color,
          ),
        ),
        if (text.length > 0)
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Text(text, style: Fonts.regular(color: color)),
          ),
        Expanded(
          child: Container(
            height: 1,
            color: color,
          ),
        ),
      ],
    );
  }
}
