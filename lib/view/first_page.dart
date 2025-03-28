import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/view/partial/bi_color_text.dart';
import 'package:in_classe/view/partial/big_button.dart';
import 'package:in_classe/widget/background.dart';

import '../constant/measures.dart';
import '../constant/palette.dart';
import '../firebase_options.dart';
import '../manager/account_manager.dart';
import '../manager/io_manager.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  static bool _isInitialized = false;

  @override
  void initState() {
    if (!_isInitialized) {
      _isInitialized = true;
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      // Keep the splash screen while the app is loading
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      Future.delayed(Duration.zero, () async {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        await IOManager().init();
        if (!await IOManager().hasInternetConnection(context)) return;

        // ⚠️⚠️⚠️ DEBUG ZONE ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
        await AccountManager().signIn('valeriomorelli50@gmail.com', 'aaaaaa');
        // await seedDatabase(fresh: true);
        // await DataManager().invalidateCache<Player>();
        // ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️

        // Autologin
        // if (await AccountManager().cacheSignIn()) {
        //   await DataManager().fetchData();
        //   context.goto('/home', pop: true);
        // }
        FlutterNativeSplash.remove();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Logo full
              Image.asset('assets/logo_full.png', width: 210),

              // 3 BiColor Texts
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  BiColorText(
                    firstText: 'Una ',
                    secondText: 'lezione',
                    secondColor: Palette.firstTitle,
                  ),
                  BiColorText(
                    firstText: 'una ',
                    secondText: 'domanda',
                    secondColor: Palette.secondTitle,
                  ),
                  BiColorText(
                    firstText: 'una ',
                    secondText: 'risposta',
                    secondColor: Palette.thirdTitle,
                  ),
                ],
              ),

              // Login e CreaUnNuovoAccount buttons
              Column(
                children: [
                  BigButton(
                    'Login',
                    textColor: Palette.buttonGradient,
                    backgroundColor: Palette.onBackground,
                    onPressed: () {
                      context.goto('/login', pop: true);
                    },
                  ),
                  SizedBox(height: Measures.hMarginMed),
                  BigButton(
                    'Crea un nuovo account',
                    backgroundColor: Colors.transparent,
                    hasBorder: true,
                    onPressed: () {
                      context.goto('/signup', pop: true);
                    },
                  ),
                  const SizedBox(height: Measures.hMarginBig),
                  BigButton(
                    'Continua come ospite',
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}