import 'package:flutter/material.dart';
import 'package:in_classe/database/seeders/analisi_seeder.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/extension_function/string_extensions.dart';
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

  @override
  Widget build(BuildContext context) {
    if (args == null) {
      args = (ModalRoute.of(context)!.settings.arguments) as Tuple2<Corso, int>?;
      corso = args!.item1;
      analisiCorso = AnalisiSeeder().seeds.where((e) => e.corso == corso!.uid).toList();
      lezione = args!.item2;
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
                      Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            corso!.nome!,
                            style: Fonts.bold(),
                          )
                          // BiColorText(
                          //     secondText: '${corso!.nome!}',
                          //     firstText: '',
                          //     secondColor: [Palette.thirdTitle, Palette.firstTitle]),
                          ),
                    ]),
                  ),
                  SizedBox(height: Measures.vMarginMed),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
