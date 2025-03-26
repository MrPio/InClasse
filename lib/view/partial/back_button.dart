import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_classe/constant/measures.dart';

import '../../constant/fonts.dart';
import '../../constant/palette.dart';

class BackButtonCustom extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color iconColor;
  final Color backgroundColor;

  const BackButtonCustom({
    Key? key,
    this.onPressed,
    this.iconColor = Palette.onBackground,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      child: Row(
        children: [
          Icon(CupertinoIcons.back, color: iconColor, size: 16),
          SizedBox(width: Measures.hMarginThin),
          Text("Indietro", style: Fonts.regular(size: 14)),
        ],
      ),
    );
  }
}
