import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_classe/constant/palette.dart';

import '../../constant/measures.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final bool obscureText;

  const InputField({
    Key? key,
    required this.controller,
    this.label = '',
    this.inputType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Palette.background.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Palette.background.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),

        child: CupertinoTextField(
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          placeholder: label,
          placeholderStyle: TextStyle(color: Palette.onBackground.withOpacity(0.4)),
          style: TextStyle(color: Palette.onBackground),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Palette.onBackground,
              width: 1.5,
            ),
            color: Colors.transparent,
          ),
        ),
    );
  }
}