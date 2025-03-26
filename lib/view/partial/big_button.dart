import 'package:flutter/cupertino.dart';
import 'package:in_classe/constant/fonts.dart';
import 'package:in_classe/constant/palette.dart';

class BigButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final dynamic textColor;
  final bool hasBorder;
  final bool isEnabled;
  final Function()? onPressed;
  /// Displays a button with text and optional icon.
  ///
  /// The button have a border if [hasBorder] is true and is transparent by default.
  /// The [textColor] defaults to white, and can be a list to make a horizontal gradient.
  const BigButton(
      this.text, {
        this.textColor = Palette.onBackground,
        this.backgroundColor,
        this.hasBorder = false,
        this.isEnabled = true,
        this.onPressed,
        this.icon,
        super.key,
      });

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.9,
      child:CupertinoButton(
        onPressed: isEnabled ? onPressed : null,
        color: backgroundColor,
        padding: EdgeInsets.zero,
        child: Container(
          decoration: hasBorder
              ? BoxDecoration(
            border: Border.all(color: Palette.onBackground, width: 1),
            borderRadius: BorderRadius.circular(12.0),
          )
              : null,
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Default di Cupertino
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                ],
                textColor is List
                    ? ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(colors: textColor).createShader(bounds),
                  child: Text(text, style: Fonts.bold()),
                )
                    : Text(text, style: Fonts.bold(color: textColor))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
