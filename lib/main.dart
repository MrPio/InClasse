import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_classe/view/first_page.dart';
import 'package:in_classe/view/home_page.dart';
import 'package:in_classe/view/signin_page.dart';
import 'package:in_classe/view/signup_page.dart';
import 'package:tuple/tuple.dart';

import 'firebase_options.dart';
import 'lezione_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Assicurati che il binding sia inizializzato
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inizializza Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: Colors.transparent, statusBarColor: Colors.transparent));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Tra Le Righe',
      onGenerateRoute: (settings) {
        final Map<String, Tuple2<Offset, Widget>> transitions = {
          '/signup': const Tuple2(Offset(1.0, 0.0), SignUpPage()),
          '/login': const Tuple2(Offset(-1.0, 0.0), SignInPage()),
        };
        if (transitions.containsKey(settings.name)) {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => transitions[settings.name]!.item2,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var tween = Tween(begin: transitions[settings.name]!.item1, end: Offset.zero)
                  .chain(CurveTween(curve: Curves.ease));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        }
        return null;
      },
      routes: <String, WidgetBuilder>{
        '/': (context) => const FirstPage(),
        '/home': (context) => const HomePage(),
        '/lezione': (context) => const LezionePage(),
        '/login': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}
