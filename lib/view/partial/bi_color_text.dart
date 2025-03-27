import 'package:flutter/material.dart';
import 'package:in_classe/constant/fonts.dart';
import 'package:in_classe/constant/palette.dart';

class BiColorText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final dynamic firstColor;
  final dynamic secondColor;
  final TextAlign textAlign;

  /// Displays a text made of two parts with different colors, on the same line.
  const BiColorText({
    super.key,
    required this.firstText,
    this.secondText = "",
    this.firstColor = Palette.onBackground,
    this.secondColor = Palette.primary,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: [
          firstColor is List
              ? WidgetSpan(
                  child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(colors: firstColor).createShader(bounds),
                  child: Text(firstText, style: Fonts.black()),
                ))
              : TextSpan(text: firstText, style: Fonts.black(color: firstColor)),
          secondColor is List
              ? WidgetSpan(
                  child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(colors: secondColor).createShader(bounds),
                  child: Transform.translate(offset: Offset(0, 4),child: Text(secondText, style: Fonts.black())),
                ))
              : TextSpan(text: secondText, style: Fonts.black(color: secondColor)),
        ],
      ),
    );
  }
}
