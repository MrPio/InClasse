import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:in_classe/constant/measures.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/extension_function/string_extensions.dart';
import 'package:in_classe/firebase_options.dart';
import 'package:in_classe/manager/account_manager.dart';
import 'package:in_classe/manager/io_manager.dart';
import 'package:in_classe/mixin/loadable.dart';

import '../constant/palette.dart';
import '../manager/data_manager.dart';

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
      backgroundColor: Colors.transparent,
      body: Placeholder(),
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

  gotoHome() async{
    await DataManager().fetchData();
    context.goto('/home', pop: true);
  }
}
