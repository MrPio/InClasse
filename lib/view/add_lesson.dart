import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_classe/constant/measures.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/extension_function/string_extensions.dart';
import 'package:in_classe/mixin/loadable.dart';
import 'package:in_classe/view/partial/input_field.dart';
import 'package:in_classe/view/partial/bi_color_text.dart';
import 'package:in_classe/view/partial/line.dart';
import 'package:in_classe/view/partial/big_button.dart';
import 'package:in_classe/view/screen/home/account_screen.dart';
import 'package:in_classe/view/screen/home/home_screen_web.dart';
import 'package:in_classe/view/screen/home/settings_screen.dart';
import '../widget/background.dart';

class AddLesson extends StatefulWidget {
  const AddLesson({super.key});

  @override
  State<AddLesson> createState() => _AddLessonState();
}

class _Screen {
  final Widget screen;
  final String name, icon;

  const _Screen(this.screen, {required this.name, required this.icon});
}

class _AddLessonState extends State<AddLesson> with Loadable {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  int _index = 2; // Per selezionare "Aggiungi file" nella sidebar

  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screens = [
      _Screen(HomeScreenWeb(), name: 'Lezioni', icon: 'news'),
      _Screen(SettingsScreen(), name: 'Registra', icon: 'speech_to_text'),
      _Screen(const AddLesson(), name: 'Aggiungi file', icon: 'add'),
      _Screen(SettingsScreen(), name: 'Statistiche', icon: 'stats'),
      _Screen(AccountScreen(), name: 'Account', icon: 'account'),
      _Screen(SettingsScreen(), name: 'Impostazioni', icon: 'cog'),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.black87),
          SafeArea(
            child: Row(
              children: [
                // Sidebar
                Container(
                  width: 200,
                  color: Colors.black26,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      ..._screens.map((screen) {
                        final i = _screens.indexOf(screen);
                        final isSelected = i == _index;

                        return InkWell(
                          onTap: () {
                            if (i != _index) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => screen.screen,
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            color: isSelected ? Colors.black54 : Colors.transparent,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/${isSelected ? screen.icon + '_on' : screen.icon + '_off'}.svg',
                                  width: 24,
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    screen.name,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.white70,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

                // Contenuto AddLesson
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: Measures.vMarginMed),
                            const BiColorText(
                              firstText: 'Aggiungi ',
                              secondText: 'lezione',
                              secondColor: [Colors.blue, Colors.lightBlueAccent],
                            ),
                            const SizedBox(height: Measures.vMarginBig),

                            InputField(
                              controller: _titleController,
                              label: 'Titolo',
                            ),
                            const SizedBox(height: Measures.vMarginMed),

                            InputField(
                              controller: _dateController,
                              label: 'Data',
                              inputType: TextInputType.datetime,
                            ),
                            const SizedBox(height: Measures.vMarginMed),

                            InputField(
                              controller: _timeController,
                              label: 'Orario',
                              inputType: TextInputType.datetime,
                            ),
                            const SizedBox(height: Measures.vMarginBig),

                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withAlpha(64),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/upload_on.svg',
                                    height: 40,
                                    width: 40,
                                    colorFilter: const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Carica il video qui',
                                    style: TextStyle(color: Colors.white70, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Measures.vMarginBig),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Annulla'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Azione futura
                                  },
                                  child: const Text('Salva lezione'),
                                ),
                              ],
                            ),
                            const SizedBox(height: Measures.vMarginBig),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
