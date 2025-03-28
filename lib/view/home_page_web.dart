import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_classe/view/screen/home/account_screen.dart';
import 'package:in_classe/view/screen/home/home_screen_web.dart';
import 'package:in_classe/view/screen/home/settings_screen.dart';
import '../constant/measures.dart';
import '../widget/background.dart';
import 'add_lesson.dart';

class _Screen {
  final Widget screen;
  final String name, icon;

  const _Screen(this.screen, {required this.name, required this.icon});
}

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({super.key});

  @override
  State<HomePageWeb> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageWeb> with TickerProviderStateMixin {
  int _index = 0;
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {
          _index = _pageController.page?.toInt() ?? 0;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screens = [
      _Screen(HomeScreenWeb(), name: 'Lezioni', icon: 'news'),
      _Screen(SettingsScreen(), name: 'Registra', icon: 'speech_to_text'),
      _Screen(AddLesson(), name: 'Aggiungi file', icon: 'add'),
      _Screen(SettingsScreen(), name: 'Statistiche', icon: 'stats'),
      _Screen(AccountScreen(), name: 'Account', icon: 'account'),
      _Screen(SettingsScreen(), name: 'Impostazioni', icon: 'cog'),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background (nero o custom)
          Container(color: Colors.black87),

          // Layout principale con sidebar e contenuto
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
                          onTap: () => _pageController.animateToPage(
                            i,
                            duration: Durations.medium3 * pow((_index - i).abs(), 0.7).toInt(),
                            curve: Curves.easeOutCubic,
                          ),
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

                // Contenuto principale
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
                    child: PageView(
                      controller: _pageController,
                      children: _screens.map((e) => e.screen).toList(),
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
