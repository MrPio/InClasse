import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackgroundWhite extends StatelessWidget {
  const BackgroundWhite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double adjustedSigma = 40 / MediaQuery.of(context).devicePixelRatio;
    // print(MediaQuery.of(context).devicePixelRatio);
    // return Stack(children: [
    //   Container(color: Colors.black),
    //   SvgPicture.asset(
    //     'assets/svg/background.svg',
    //     fit: BoxFit.fill,
    //   ),
    //   BackdropFilter(
    //     filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
    //     child: Container(
    //       color: Colors.transparent, // Required for BackdropFilter to work
    //     ),
    //   )
    // ]);
    return Positioned.fill(child: Image.asset('assets/images/backgroundWhite.png', fit: BoxFit.fill));
  }
}
