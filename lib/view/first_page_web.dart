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

class FirstPageWeb extends StatefulWidget {
  const FirstPageWeb({super.key});

  @override
  State<FirstPageWeb> createState() => _FirstPageWebState();
}

class _FirstPageWebState extends State<FirstPageWeb> {
  static bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    if (!_isInitialized) {
      _isInitialized = true;
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      Future.microtask(() async {
        try {
          await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
          await IOManager().init();
          final connected = await IOManager().hasInternetConnection(context);

          if (!connected) {
            debugPrint('⚠️ Nessuna connessione Internet');
          } else {
            await AccountManager().signIn('valeriomorelli50@gmail.com', 'aaaaaa');
          }
        } catch (e) {
          debugPrint('Errore in initState: $e');
        } finally {
          FlutterNativeSplash.remove();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo_full.png', width: 320),
                      const SizedBox(height: 40),
                      const BiColorText(
                        firstText: 'Una ',
                        secondText: 'lezione',
                        secondColor: Palette.firstTitle,
                      ),
                      const BiColorText(
                        firstText: 'una ',
                        secondText: 'domanda',
                        secondColor: Palette.secondTitle,
                      ),
                      const BiColorText(
                        firstText: 'una ',
                        secondText: 'risposta',
                        secondColor: Palette.thirdTitle,
                      ),
                      const SizedBox(height: 60),
                      BigButton(
                        'Login',
                        textColor: Palette.buttonGradient,
                        backgroundColor: Palette.onBackground,
                        onPressed: () {
                          context.goto('/login', pop: true);
                        },
                      ),
                      const SizedBox(height: 20),
                      BigButton(
                        'Crea un nuovo account',
                        backgroundColor: Colors.transparent,
                        hasBorder: true,
                        onPressed: () {
                          context.goto('/signup', pop: true);
                        },
                      ),
                      const SizedBox(height: 20),
                      BigButton(
                        'Continua come ospite',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
