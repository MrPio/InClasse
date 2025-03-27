import 'dart:math';

import 'package:flutter/material.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/extension_function/string_extensions.dart';
import 'package:in_classe/view/partial/bi_color_text.dart';
import 'package:tuple/tuple.dart';

import '../constant/measures.dart';
import '../widget/background.dart';
import 'constant/fonts.dart';
import 'constant/palette.dart';
import 'model/corso.dart';

class _Screen {
  final Widget screen;
  final String name, icon;

  const _Screen(this.screen, {required this.name, required this.icon});
}

class LezionePage extends StatefulWidget {
  const LezionePage({super.key});

  @override
  State<LezionePage> createState() => _LezionePageState();
}

class _LezionePageState extends State<LezionePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)!.settings.arguments) as Tuple2<Corso, int>?;
    final corso = args!.item1;
    final lezione = args!.item2;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Background(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Measures.vMarginMed),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                    child: Row(children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withAlpha(64),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'chevron_left'.toIcon(),
                              SizedBox(width: Measures.hMarginMed),
                              Text('Indietro', style: Fonts.regular()),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: BiColorText(
                            secondText: '${corso.nome!}',
                            firstText: '',
                            secondColor: [Palette.thirdTitle, Palette.firstTitle]),
                      ),
                    ]),
                  ),
                  SizedBox(height: Measures.vMarginMed),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...(corso.lezioni! + [3, 4, 5, 6, 11, 13]).map((l) => Padding(
                              padding: const EdgeInsets.only(right: Measures.hMarginMed),
                              child: GestureDetector(
                                onTap: () {
                                  context.goto('/lezione', args: Tuple2(corso, l));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withAlpha(64),
                                      border: l == lezione
                                          ? Border.all(color: Colors.white, width: 2)
                                          : null),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        // Text(lezione.toString(), style: Fonts.bold()),
                                        Text(
                                            [
                                              "LUN",
                                              "MAR",
                                              "MER",
                                              "GIO",
                                              "VER",
                                              "SAB",
                                              "DOM"
                                            ][Random().nextInt(5)],
                                            style: Fonts.bold()),
                                        Text("$lezione OTT", style: Fonts.regular()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: Measures.vMarginMed),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                    child: Text('Lezione $lezione', style: Fonts.regular(size: 18)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
