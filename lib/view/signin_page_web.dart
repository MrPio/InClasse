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

class SignInPageWeb extends StatefulWidget {
  const SignInPageWeb({super.key});

  @override
  State<SignInPageWeb> createState() => _SignInPageWebState();
}

class _SignInPageWebState extends State<SignInPageWeb> with Loadable {
  late final TextEditingController _emailController, _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController(text: 'domeniceUrsino@gmail.com'); // TODO here
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
      body: Row(
        children: [
          // Colonna sinistra (logo + colore)
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background2.png'),
                  fit: BoxFit.cover, // Copre tutta la colonna
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                  ],
                ),
              ),
            ),
          ),

          // Colonna destra (form)
          Expanded(
            flex: 1,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Accedi al tuo\naccount',
                        textAlign: TextAlign.center,
                        // TODO change font
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: [
                                Palette.firstTitle,
                                Palette.secondTitle,
                              ],
                            ).createShader(const Rect.fromLTWH(0, 0, 400, 70)),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Email
                      InputField(
                        controller: _emailController,
                        label: 'Inserisci la tua e-mail',
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // Password
                      InputField(
                        controller: _passwordController,
                        label: 'Scegli la password',
                        inputType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),

                      // Accedi
                      BigButton(
                        'Accedi',
                        backgroundColor: Palette.background,
                        textColor: Palette.onBackground,
                        onPressed: () => context.goto('/home'),
                      ),

                      const SizedBox(height: 24),
                      const Line(),
                      const SizedBox(height: 24),

                      BigButton(
                        'Accedi con Google',
                        backgroundColor: Palette.background,
                        textColor: Palette.onBackground,
                        icon: Image.asset('assets/images/google.png', width: 30, height: 30),
                        onPressed: () => print('premuto'),
                      ),
                      const SizedBox(height: 16),
                      BigButton(
                        'Accedi con Apple',
                        backgroundColor: Palette.background,
                        textColor: Palette.onBackground,
                        icon: Image.asset('assets/images/apple.png', width: 26, height: 26),
                        onPressed: () => print('premuto'),
                      ),
                      const SizedBox(height: 24),
                      BigButton(
                        'Non hai ancora un account?',
                        onPressed: () {
                          context.goto('/signup', pop: true);
                        },
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

  signIn() => withLoading(() async {
    if (!await IOManager().hasInternetConnection(context)) return;
    if (!_emailController.text.isEmail) {
      context.snackbar('Per favore inserisci una email valida', backgroundColor: Palette.background);
      return;
    }
    final status = await AccountManager().signIn(
      _emailController.text,
      _passwordController.text,
    );
    switch (status) {
      case SignInStatus.wrongCredentials:
        context.snackbar('Le credenziali sono errate!', backgroundColor: Palette.error);
        break;
      case SignInStatus.userNotInDatabase:
        context.snackbar('L\'account non è più esistente!', backgroundColor: Palette.error);
        break;
      case SignInStatus.success:
        await gotoHome();
        break;
      default:
        break;
    }
  });

  gotoHome() async {
    await DataManager().fetchData();
    context.goto('/home', pop: true);
  }
}
