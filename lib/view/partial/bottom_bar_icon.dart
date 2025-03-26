import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_classe/constant/fonts.dart';
import 'package:in_classe/constant/measures.dart';
import 'package:in_classe/extension_function/string_extensions.dart';

class BottomBarIcon extends StatelessWidget {
  final String title, iconPathOn, iconPathOff;
  final bool active;
  final Function()? onTap;

  const BottomBarIcon(
      {required this.title,
      required this.iconPathOn,
      required this.iconPathOff,
      this.active = true,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (active ? iconPathOn : iconPathOff).toIcon(height: 29),
            const SizedBox(height: 2),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(title, style: Fonts.regular(size: 11)),
            )
          ],
        ),
      ),
    );
  }
}
