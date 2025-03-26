import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_classe/constant/palette.dart';

extension StringExtensions on String {
  bool match(String other, {bool contains = false}) =>
      contains ? simplify.contains(other.simplify) : simplify == other.simplify;

  String get simplify => toLowerCase().trim().replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

  bool get isEmail => RegExp(r'^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$').hasMatch(this);

  bool get isUsername => length >= 3 && RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(this);

  /// Load a SVG or PNG from string.
  ///
  /// E.g. 'home' -> 'assets/home.svg'
  /// E.g. 'home.png' -> 'assets/home.png'
  Widget toIcon(
      {double height = 24,
      Function()? onTap,
      padding = const EdgeInsets.all(8.0),
      margin = EdgeInsets.zero,
      color = Palette.onBackground,
      double rotation = 0}) {
    var icon = contains('.png')
        ? Image.asset('assets/icons/$this', height: height, color: color)
        : SvgPicture.asset('assets/icons/$this${contains('.svg') ? '' : '.svg'}', height: height, color: color);
    if (onTap == null) {
      return Padding(
        padding: margin,
        child: Transform.rotate(angle: rotation, child: icon),
      );
    } else {
      return Padding(
        padding: margin,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Transform.rotate(angle: rotation, child: icon),
          ),
        ),
      );
    }
  }
}
