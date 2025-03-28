import 'package:flutter/material.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/extension_function/string_extensions.dart';
import 'package:in_classe/view/partial/line.dart';

import '../constant/measures.dart';
import '../widget/background.dart';
import 'constant/fonts.dart';
import 'model/analisi.dart';

class _Screen {
  final Widget screen;
  final String name, icon;

  const _Screen(this.screen, {required this.name, required this.icon});
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Analisi? analisi;
  String? domandaSelected;

  @override
  Widget build(BuildContext context) {
    if (analisi == null) {
      analisi = (ModalRoute.of(context)!.settings.arguments) as Analisi?;
    }
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
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withAlpha(64),
                              border: Border.all(color: Colors.white, width: 2)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Measures.vMarginMoreThin, horizontal: Measures.hMarginSmall),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                'chevron_left'.toIcon(height: 20),
                                SizedBox(width: Measures.hMarginSmall),
                                Text('Indietro', style: Fonts.regular()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Measures.hMarginBig),
                      Flexible(fit: FlexFit.tight, child: Text('Test di autovalutazione', style: Fonts.bold()))
                    ]),
                  ),
                  SizedBox(height: Measures.vMarginMed),

                  // Lez
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                    child: Text('Lezione ${analisi!.lezione}', style: Fonts.regular(size: 18)),
                  ),

                  SizedBox(height: Measures.vMarginSmall),
                  ...analisi!.test!.map((domanda) => GestureDetector(
                        onTap: () {
                          setState(() {
                            if (domandaSelected == domanda.item1)
                              domandaSelected = null;
                            else
                              domandaSelected = domanda.item1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                      child: Text(
                                    domanda.item1,
                                    style: Fonts.bold(),
                                    maxLines: 9,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  SizedBox(width: Measures.hMarginMed),
                                  'chevron_right'.toIcon(
                                      rotation: domanda.item1 == domandaSelected ? -3.14 / 2 : 3.14 / 2)
                                ],
                              ),
                              if (domanda.item1 == domandaSelected) ...[
                                SizedBox(height: Measures.vMarginThin),
                                Text(domanda.item2, style: Fonts.regular())
                              ],
                              SizedBox(height: Measures.vMarginSmall),
                              Line(text: ''),
                              SizedBox(height: Measures.vMarginSmall),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
