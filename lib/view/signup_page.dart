import 'package:flutter/material.dart';
import 'package:in_classe/constant/measures.dart';
import 'package:in_classe/constant/palette.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/extension_function/string_extensions.dart';
import 'package:in_classe/manager/account_manager.dart';
import 'package:in_classe/manager/io_manager.dart';
import 'package:in_classe/mixin/loadable.dart';
import 'package:in_classe/model/user.dart';
import 'package:in_classe/view/partial/bi_color_text.dart';
import 'package:in_classe/view/partial/big_button.dart';
import 'package:in_classe/view/partial/input_field.dart';
import 'package:in_classe/view/partial/line.dart';

import '../manager/data_manager.dart';
import '../model/team.dart';
import '../widget/background.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with Loadable {
  late final TextEditingController _usernameController, _emailController, _passwordController;
  bool showTeams = false;
  Team? selectedTeam;

  List<Team> get _teams => DataManager().cachedTeams;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController(text: 'valeriomorelli50@gmail.com')
      ..addListener(() {
        setState(() {});
      });
    _passwordController = TextEditingController(text: 'aaaaaa');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Stack(
        children: [
          const Background(),
          //showTeams ? _buildTeamSelection(context) : _buildSignUp(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Measures.hPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BiColorText(
                  firstText: 'Crea il tuo\n',
                  secondText: 'account',
                  firstColor: Palette.onBackground,
                  secondColor: Palette.textGradient,
                ),
                SizedBox(height: Measures.hMarginMed),

                // E-mail
                InputField(
                  controller: _emailController,
                  label: 'Inserisci la tua e-mail',
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: Measures.hMarginMed),

                // Password
                InputField(
                  controller: _passwordController,
                  label: 'Scegli la password',
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                SizedBox(height: Measures.hMarginMed),

                // Conferma Password
                InputField(
                  controller: _passwordController,
                  label: 'Conferma la password',
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                SizedBox(height: Measures.hMarginMed),

                // Continua
                BigButton(
                  'Continua',
                  backgroundColor: Palette.onBackground,
                  textColor: Palette.buttonGradient,
                  isEnabled: true,
                  onPressed: () {
                    setState(() {
                      showTeams = true;
                    });
                  },
                ),
                SizedBox(height: Measures.hMarginMed),
                Line(),

                // Accedi con Google
                SizedBox(height: Measures.hMarginMed),
                BigButton(
                  'Accedi con Google',
                  backgroundColor: Palette.onBackground,
                  textColor: Palette.background,
                  icon: Image.asset('assets/images/logos/google.png', width: 30, height: 30),
                  onPressed: () {
                    print('premuto');
                  },
                ),

                // Accedi con Apple
                SizedBox(height: Measures.hMarginMed),
                BigButton(
                  'Accedi con Apple',
                  backgroundColor: Palette.background,
                  textColor: Palette.onBackground,
                  //TODO l'immagine va presa quando ci si iscrive all'Apple Developer
                  icon: Image.asset('assets/images/logos/apple.png', width: 30, height: 30),
                  onPressed: () {
                    print('premuto');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  signUp() => withLoading(() async {
        if (!await IOManager().hasInternetConnection(context)) {
          return;
        }
        if (!_usernameController.text.isUsername) {
          context.snackbar('Per favore inserisci un nome utente valido',
              backgroundColor: Palette.background);
        } else if (!_emailController.text.isEmail) {
          context.snackbar('Per favore inserisci una email valida', backgroundColor: Palette.background);
        } else {
          SignUpStatus status = await AccountManager().signUp(
              _emailController.text,
              _passwordController.text,
              User(username: _usernameController.text, email: _emailController.text));
          if (status == SignUpStatus.weakPassword) {
            context.snackbar('La password è troppo corta!', backgroundColor: Palette.error);
          } else if (status == SignUpStatus.emailInUse) {
            context.snackbar('L\'email è già in uso!', backgroundColor: Palette.error);
          } else if (status == SignUpStatus.genericError) {
            context.snackbar('Errore generico!', backgroundColor: Palette.error);
          } else if (status == SignUpStatus.success) {
            context.snackbar('Benvenuto ${AccountManager().user.username}!',
                backgroundColor: Palette.background);
            await gotoHome();
          }
        }
      });

  signInWithGoogle() => withLoading(() async {
        if (!await IOManager().hasInternetConnection(context)) {
          return;
        }
        SignInStatus status = await AccountManager().signInWithGoogle();
        if (status == SignInStatus.googleProviderError) {
          context.snackbar('Errore nell\'accesso a Google', backgroundColor: Palette.error);
        } else if (status == SignInStatus.userNotInDatabase) {
          context.snackbar('L\'account non è più esistente!', backgroundColor: Palette.error);
        } else if (status == SignInStatus.success) {
          context.snackbar('Bentornato ${AccountManager().user.username}!',
              backgroundColor: Palette.background);
          await gotoHome();
        } else if (status == SignInStatus.successNewAccount) {
          context.snackbar('Benvenuto ${AccountManager().user.username}!',
              backgroundColor: Palette.background);
          Navigator.of(context).popAndPushNamed('/home');
        }
      });

  gotoHome() async {
    await DataManager().fetchData();
    context.goto('/home', pop: true);
  }
}
