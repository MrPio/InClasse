import 'package:flutter/material.dart';
import 'package:in_classe/database/seeders/analisi_seeder.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/extension_function/string_extensions.dart';
import 'package:in_classe/view/partial/line.dart';
import 'package:tuple/tuple.dart';

import '../constant/measures.dart';
import '../widget/background.dart';
import 'constant/fonts.dart';
import 'model/analisi.dart';
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

class _LezionePageState extends State<LezionePage> {
  Tuple2<Corso, int>? args;

  Corso? corso;
  List<Analisi>? analisiCorso;
  int? lezione;
  String? domandaSelected;

  @override
  Widget build(BuildContext context) {
    if (args == null) {
      args = (ModalRoute.of(context)!.settings.arguments) as Tuple2<Corso, int>?;
      corso = args!.item1;
      analisiCorso = AnalisiSeeder().seeds.where((e) => e.corso == corso!.uid).toList();
      lezione = args!.item2;
    }
    final analisi = analisiCorso?.firstWhere((e) => e.lezione == lezione);
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
                      Flexible(fit: FlexFit.tight, child: Text(corso!.nome!, style: Fonts.bold())
                          // BiColorText(
                          //     secondText: '${corso!.nome!}',
                          //     firstText: '',
                          //     secondColor: [Palette.thirdTitle, Palette.firstTitle]),
                          ),
                    ]),
                  ),
                  SizedBox(height: Measures.vMarginMed),

                  // Date
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: Measures.hPadding),
                        ...corso!.lezioni!.map((l) => Opacity(
                              opacity: analisiCorso!.any((e) => e.lezione == l) ? 1 : 0.5,
                              child: Padding(
                                padding: const EdgeInsets.only(right: Measures.hMarginMed),
                                child: GestureDetector(
                                  onTap: () {
                                    if (analisiCorso!.any((e) => e.lezione == l))
                                      setState(() {
                                        domandaSelected = null;
                                        lezione = l;
                                      });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black.withAlpha(64),
                                        border: l == lezione
                                            ? Border.all(color: Colors.white, width: 2)
                                            : Border.all(color: Colors.transparent, width: 2)),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          // Text(lezione.toString(), style: Fonts.bold()),
                                          Text(["LUN", "MAR", "MER", "GIO", "VER", "SAB", "DOM"][l % 5],
                                              style: Fonts.bold()),
                                          Text("$l OTT", style: Fonts.regular()),
                                        ],
                                      ),
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

                  // Summary
                  SizedBox(height: Measures.vMarginSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                    child: Text(analisi!.summary!,
                        style: Fonts.regular(), maxLines: 6, overflow: TextOverflow.ellipsis),
                  ),

                  // Topics
                  SizedBox(height: Measures.vMarginSmall),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: Measures.hPadding),
                        ...analisi.topics!.map((topic) => Padding(
                              padding: const EdgeInsets.only(right: Measures.hMarginMed),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withAlpha(64),
                                    border: Border.all(color: Colors.white, width: 2)),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(topic, style: Fonts.regular()),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),

                  // goto Questions
                  SizedBox(height: Measures.vMarginSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                    child: Line(text: ''),
                  ),
                  SizedBox(height: Measures.vMarginSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                    child: GestureDetector(
                      onTap: () {
                        context.goto('/quiz', args: analisi);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withAlpha(64),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SizedBox(width: Measures.hMarginSmall),
                              'quiz'.toIcon(height: 36),
                              SizedBox(width: Measures.hMarginMed + Measures.hMarginSmall),
                              Expanded(
                                  child: Text("Test di autovalutazione", style: Fonts.bold(size: 18))),
                              'chevron_right'.toIcon(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Chat
                  SizedBox(height: Measures.vMarginSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withAlpha(64),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SizedBox(width: Measures.hMarginSmall),
                            'chat'.toIcon(height: 36),
                            SizedBox(width: Measures.hMarginMed + Measures.hMarginSmall),
                            Expanded(child: Text("Chatta con il tutor AI", style: Fonts.bold(size: 18))),
                            'chevron_right'.toIcon(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Link
                  SizedBox(height: Measures.vMarginSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withAlpha(64),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SizedBox(width: Measures.hMarginSmall),
                            'link'.toIcon(height: 36),
                            SizedBox(width: Measures.hMarginMed + Measures.hMarginSmall),
                            Expanded(child: Text("Collegamenti", style: Fonts.bold(size: 18))),
                            'chevron_right'.toIcon(),
                          ],
                        ),
                      ),
                    ),
                  ),

// PDF
                  SizedBox(height: Measures.vMarginSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withAlpha(64),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SizedBox(width: Measures.hMarginSmall),
                            'pdf'.toIcon(height: 36),
                            SizedBox(width: Measures.hMarginMed + Measures.hMarginSmall),
                            Expanded(child: Text("Esporta in PDF", style: Fonts.bold(size: 18))),
                            'chevron_right'.toIcon(),
                          ],
                        ),
                      ),
                    ),
                  ),

/*
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                    child: Row(
                      children: [
                        'quiz'.toIcon(height: 36),
                        SizedBox(width: Measures.hMarginMed),
                        Flexible(
                            child: Text('Test di autovalutazione',
                                style: Fonts.black(size: 20), overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),

                  SizedBox(height: Measures.vMarginSmall),
                  ...analisi.test!.map((domanda) => GestureDetector(
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
                                  Flexible(child: Text(domanda.item1, style: Fonts.bold(),maxLines: 9,overflow: TextOverflow.ellipsis,)),
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
*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
