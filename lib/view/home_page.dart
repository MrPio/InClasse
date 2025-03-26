import 'dart:math';
import 'package:flutter/material.dart';
import 'package:in_classe/view/partial/bottom_bar_icon.dart';
import 'package:in_classe/view/screen/home/home_screen.dart';
import '../constant/measures.dart';
import '../widget/background.dart';

class _Screen {
  final Widget screen;
  final String name, icon;

  const _Screen(this.screen, {required this.name, required this.icon});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _index = 0;
  final List<_Screen> _screens = [
    // _Screen(TODO),
  ];
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
    return Scaffold(
      body: Stack(
        children: [
          Background(),

          // Body -> current screen
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
              child: PageView(
                controller: _pageController,
                children: _screens.map((e) => e.screen).toList(),
              ),
            ),
          ),

          // Bottom bar
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Measures.hPadding, vertical: Measures.vMarginThin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _screens.map((screen) {
                    final i = _screens.indexOf(screen);
                    return BottomBarIcon(
                        title: screen.name,
                        iconPathOn: '${screen.icon}_on',
                        iconPathOff: '${screen.icon}_off',
                        active: _index == i,
                        onTap: () => _pageController.animateToPage(i,
                            duration: Durations.medium3 * pow((_index - i).abs(), 0.7),
                            curve: Curves.easeOutCubic));
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
