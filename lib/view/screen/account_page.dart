import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:in_classe/model/user.dart';

import '../../constant/measures.dart';
import '../../constant/palette.dart';
import '../../widget/background.dart';

class AccountPage extends StatelessWidget {
  //final User? user;


  const AccountPage({
    Key? key,
    //required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
        Background(),
    Padding(
    padding: const EdgeInsets.all(Measures.hPadding),
    child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          ],
        ),
      ),
    ),],);
  }
}
