import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_classe/constant/palette.dart';

class Fonts {
  static _font(
          [Color? color = Palette.onBackground,
          double size = 14,
          FontWeight? fontWeight,
          FontStyle? fontStyle]) =>
      GoogleFonts.poppins(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      );

  static light(
          {Color color = Palette.onBackground,
          double size = 14,
          FontStyle fontStyle = FontStyle.normal}) =>
      _font(color, size, FontWeight.w200, fontStyle);

  static regular(
          {Color color = Palette.onBackground,
          double size = 14,
          FontStyle fontStyle = FontStyle.normal}) =>
      _font(color, size, FontWeight.w400, fontStyle);

  static bold(
          {Color color = Palette.onBackground,
          double size = 16,
          FontStyle fontStyle = FontStyle.normal}) =>
      _font(color, size, FontWeight.w700, fontStyle);

  static black(
          {Color color = Palette.onBackground,
          double size = 34,
          FontStyle fontStyle = FontStyle.normal}) =>
      _font(color, size, FontWeight.w800, fontStyle).copyWith(height: 1.075);
}
