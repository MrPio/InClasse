import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_classe/constant/palette.dart';

class Fonts {
  static _font([Color? color = Palette.onBackground, double size = 14, FontWeight? fontWeight]) =>
      GoogleFonts.poppins(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      );

  static light({Color color = Palette.onBackground, double size = 10}) =>
      _font(color, size, FontWeight.w300);

  static regular({Color color = Palette.onBackground, double size = 12}) =>
      _font(color, size, FontWeight.w400);

  static bold({Color color = Palette.onBackground, double size = 14}) =>
      _font(color, size, FontWeight.w700);

  static black({Color color = Palette.onBackground, double size = 32}) =>
      _font(color, size, FontWeight.w800).copyWith(height: 1.075);
}
