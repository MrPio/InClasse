import 'package:flutter/material.dart';
import 'package:in_classe/constant/fonts.dart';
import 'package:in_classe/database/seeders/corso_seeder.dart';
import 'package:in_classe/extension_function/string_extensions.dart';
import 'package:in_classe/view/layout/recycler_view.dart';
import 'package:in_classe/view/partial/bi_color_text.dart';

import '../../../constant/measures.dart';
import '../../../constant/palette.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return RecyclerView(
      children: [
        SizedBox(height: Measures.vMarginMed),
        BiColorText(
            firstText: 'I tuoi ',
            secondText: 'corsi',
            secondColor: [Palette.firstTitle, Palette.thirdTitle]),
        SizedBox(height: Measures.vMarginMed),
        ...CorsoSeeder().seeds.map(
              (corso) => Padding(
                padding: const EdgeInsets.only(bottom: Measures.vMarginThin),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withAlpha(64),
                      border: Border.all(color: Colors.white, width: 2)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child:
                                Text(corso.nome!, style: Fonts.bold(), overflow: TextOverflow.ellipsis),
                          ),
                          'chevron_right'.toIcon()
                        ]),
                        SizedBox(height: Measures.vMarginThin),
                        Text("${corso.docente!} - ${corso.anno}",
                            style: Fonts.regular(fontStyle: FontStyle.italic),
                            overflow: TextOverflow.ellipsis),
                        SizedBox(height: Measures.vMarginThin),
                        Text(corso.descrizione!, style: Fonts.light(), maxLines: 2),
                      ],
                    ),
                  ),
                ),
              ),
            )
      ],
    );
  }
}
