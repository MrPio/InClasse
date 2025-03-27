import 'package:flutter/material.dart';
import 'package:in_classe/constant/measures.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/extension_function/string_extensions.dart';
import 'package:in_classe/manager/account_manager.dart';
import 'package:in_classe/manager/io_manager.dart';
import 'package:in_classe/mixin/loadable.dart';
import 'package:in_classe/view/partial/bi_color_text.dart';
import 'package:in_classe/view/partial/big_button.dart';
import 'package:in_classe/view/partial/input_field.dart';
import 'package:in_classe/view/partial/line.dart';

import '../constant/palette.dart';
import '../manager/data_manager.dart';
import '../widget/background.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with Loadable {
  late final TextEditingController _emailController, _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController(text: 'valeriomorelli50@gmail.com'); // TODO here
    _passwordController = TextEditingController(text: 'aaaaaa');
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  firstText: 'Accedi al tuo\n',
                  secondText: 'account',
                  firstColor: Palette.onBackground,
                  secondColor: Palette.textGradient,
                ),
                SizedBox(height: Measures.vMarginBig),

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

                // Continua
                BigButton(
                  'Accedi',
                  backgroundColor: Palette.onBackground,
                  textColor: Palette.buttonGradient,
                  isEnabled: true,
                  onPressed: () {
                    signIn();
                  },
                ),
                SizedBox(height: Measures.vMarginMed),
                Line(),

                // Accedi con Google
                SizedBox(height: Measures.vMarginSmall),
                BigButton(
                  'Accedi con Google',
                  backgroundColor: Palette.onBackground,
                  textColor: Palette.background,
                  icon: Image.asset('assets/images/google.png', width: 30, height: 30),
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
                  icon: Image.asset('assets/images/apple.png', width: 26, height: 26),
                  onPressed: () {
                    print('premuto');
                  },
                ),

                SizedBox(height: Measures.vMarginSmall),
                BigButton(
                  'Non hai ancora un account?',
                  onPressed: () {
                    context.goto('/signup', pop: true);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  signIn() => withLoading(() async {
        if (!await IOManager().hasInternetConnection(context)) {
          return;
        }
        if (!_emailController.text.isEmail) {
          context.snackbar('Per favore inserisci una email valida', backgroundColor: Palette.background);
        } else {
          SignInStatus status =
              await AccountManager().signIn(_emailController.text, _passwordController.text);
          if (status == SignInStatus.wrongCredentials) {
            context.snackbar('Le credenziali sono errate!', backgroundColor: Palette.error);
          } else if (status == SignInStatus.userNotInDatabase) {
            context.snackbar('L\'account non è più esistente!', backgroundColor: Palette.error);
          } else if (status == SignInStatus.success) {
            context.snackbar('Bentornato ${AccountManager().user.username}!',
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
          await gotoHome();
        }
      });

  forgotPassword() async {
    final emailController = TextEditingController();
    context.popup(
      'Reset della password',
      message: 'Inserisci l\'email dell\'account del quale vuoi reimpostare la password:',
      backgroundColor: Palette.popup,
      positiveText: 'Invia email',
      positiveCallback: () async {
        if (emailController.text.isEmail) {
          ResetPasswordStatus status = await AccountManager().resetPassword(emailController.text);
          if (status == ResetPasswordStatus.success) {
            context.snackbar('Controlla il tuo indirizzo per reimpostare la password',
                backgroundColor: Palette.background);
          } else {
            context.snackbar('Errore generico!', backgroundColor: Palette.error);
          }
        } else {
          context.snackbar('L\'email inserita non è valida', backgroundColor: Palette.error);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: Measures.vMarginMed),
        child: Placeholder(),
      ),
    );
  }

  gotoHome() async {
    await DataManager().fetchData();
    context.goto('/home', pop: true);
  }
}
