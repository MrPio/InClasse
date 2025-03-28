import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_classe/constant/fonts.dart';
import 'package:in_classe/database/seeders/corso_seeder.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/extension_function/string_extensions.dart';
import 'package:in_classe/view/partial/bi_color_text.dart';
import 'package:in_classe/view/partial/line.dart';
import 'package:tuple/tuple.dart';
import 'package:in_classe/view/add_lesson.dart';

import '../../../constant/measures.dart';
import '../../../constant/palette.dart';
import '../../../database/seeders/analisi_seeder.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  State<HomeScreenWeb> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenWeb> {
  String? selected = null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 75),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Measures.vMarginMed),
            BiColorText(
              firstText: 'I tuoi ',
              secondText: 'corsi',
              secondColor: [Palette.firstTitle, Palette.thirdTitle],
            ),
            const SizedBox(height: Measures.vMarginMed),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Ciao ',
                    style: Fonts.regular(size: 18),
                  ),
                  TextSpan(
                    text: 'DOMENICO',
                    style: Fonts.bold(size: 25).copyWith(color: Colors.blueAccent), // 👈 solo "Domenico" in grassetto
                  ),
                  TextSpan(
                    text: ', seleziona uno dei tuoi corsi per iniziare la lezione',
                    style: Fonts.regular(size: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Measures.vMarginSmall),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
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
                      Text('2024/2025', style: Fonts.bold()),
                      SizedBox(width: Measures.hMarginMed),
                      'chevron_down'.toIcon(height: 20)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Measures.vMarginThin),
            ...CorsoSeeder().seeds
                .where((corso) => corso.docente == 'Domenico URSINO')
                .map(
                  (corso) {
                final analisiCorso = AnalisiSeeder().seeds.where((e) => e.corso == corso.uid).toList();
                return Padding(
                  padding: const EdgeInsets.only(bottom: Measures.vMarginThin),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = corso.uid;
                      });
                    },
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 800),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withAlpha(64),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Text(corso.nome!,
                                    style: Fonts.bold(), overflow: TextOverflow.ellipsis),
                              ),
                              'chevron_right'
                                  .toIcon(rotation: corso.uid == selected ? -3.14 / 2 : 3.14 / 2)
                            ]),
                            SizedBox(height: Measures.vMarginThin),
                            Text("${corso.docente!} (${corso.anno})",
                                style: Fonts.regular(fontStyle: FontStyle.italic),
                                overflow: TextOverflow.ellipsis),
                            SizedBox(height: Measures.vMarginThin),
                            Text(corso.descrizione!, style: Fonts.light(), maxLines: 1),
                            if (corso.uid == selected) ...[
                              SizedBox(height: Measures.vMarginSmall),
                              Line(text: ''),
                              SizedBox(height: Measures.vMarginSmall),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ...(corso.lezioni!).map((lezione) => Opacity(
                                      opacity: analisiCorso.any((e) => e.lezione == lezione) ? 1 : 0.5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: Measures.hMarginMed),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (analisiCorso.any((e) => e.lezione == lezione)) {
                                              context.goto('/lezione', args: Tuple2(corso, lezione));
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.black.withAlpha(64),
                                              border: Border.all(color: Colors.white, width: 2),
                                            ),
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Text(
                                                  ["LUN", "MAR", "MER", "GIO", "VER", "SAB", "DOM"][lezione % 5],
                                                  style: Fonts.bold(),
                                                ),
                                                Text("$lezione OTT", style: Fonts.regular()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),

                                    // 👉 Pulsante + (aggiunta lezione)
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (_) => const AddLesson()),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(left: Measures.hMarginMed),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.black.withAlpha(64), // stesso colore sfondo dei cubi data
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: SvgPicture.asset(
                                          'assets/icons/plus.svg',
                                          height: 24,
                                          width: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
