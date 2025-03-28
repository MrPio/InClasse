import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/extension_function/string_extensions.dart';

import '../constant/measures.dart';
import '../widget/background.dart';
import 'constant/fonts.dart';
import 'model/analisi.dart';

class _Screen {
  final Widget screen;
  final String name, icon;

  const _Screen(this.screen, {required this.name, required this.icon});
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Analisi? analisi;
  String? domandaSelected;
  final TextEditingController controller = TextEditingController();

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
            child: Padding(
              padding: const EdgeInsets.only(bottom: 86),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Measures.vMarginMed),

                  // Indietro
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
                      Flexible(fit: FlexFit.tight, child: Text('Tutor AI', style: Fonts.bold()))
                    ]),
                  ),
                  SizedBox(height: Measures.vMarginSmall),

                  // Chat
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                        child: Column(
                          children: [
                            SizedBox(height: Measures.vMarginBig),
                            ...(analisi!.chat!).map((chat) => Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: 300,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.black.withAlpha(64),
                                            border: Border.all(color: Colors.white, width: 2)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: Measures.vMarginMoreThin,
                                              horizontal: Measures.hMarginSmall),
                                          child: Text(chat.item1, style: Fonts.regular(size: 17)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Measures.vMarginSmall),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: MarkdownBody(
                                        data: chat.item2,
                                        styleSheet: MarkdownStyleSheet(
                                          textAlign: WrapAlignment.start,
                                          p: Fonts.regular(size: 17),
                                          tableBody: Fonts.regular(size: 12),
                                          listBullet: Fonts.regular(size: 15),
                                          tableCellsPadding: const EdgeInsets.all(4),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Measures.vMarginSmall),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Write
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    color: Colors.white.withAlpha(40)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Measures.hPadding, vertical: Measures.vMarginSmall),
                  child: Row(children: [
                    Expanded(
                      child: Opacity(
                          opacity: 0.85,
                          child: Text('Fai una domanda sulla lezione',
                              style: Fonts
                                  .regular()) //InputField(controller: controller,label: 'Fai una domanda sulla lezione')
                          ),
                    ),
                    SizedBox(width: Measures.hMarginSmall),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black87.withAlpha(210), borderRadius: BorderRadius.circular(999)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: 'mic'.toIcon(height: 28),
                      ),
                    ),
                    SizedBox(width: Measures.hMarginSmall),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withAlpha(210), borderRadius: BorderRadius.circular(999)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: 'chevron_down'.toIcon(height: 28, rotation: pi, color: Colors.black),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
