import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:in_classe/constant/fonts.dart';
import 'package:in_classe/constant/measures.dart';
import 'package:in_classe/constant/palette.dart';

class BottomSheetItem {
  final String iconPath, text;
  final Function() onTap;

  BottomSheetItem(this.iconPath, this.text, this.onTap);
}

extension ContextExtensions on BuildContext {
  // FIXME: convert to CupertinoAlertDialog
  Future<void> popup(String title,
      {String? message,
      Widget? child,
      Color backgroundColor = Palette.primary,
      String? positiveText,
      Function()? positiveCallback,
      bool Function()? canPopPositiveCallback,
      String? negativeText,
      Function()? negativeCallback,
      bool noContentHPadding = false,
      dismissible = true}) async {
    await showDialog(
      barrierDismissible: dismissible,
      context: this,
      builder: (_) {
        return PopScope(
          canPop: dismissible,
          child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(
                horizontal: Measures.hPadding + Measures.hMarginSmall, vertical: Measures.vMarginThin),
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: EdgeInsets.zero,
            content: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Measures.hPadding, horizontal: noContentHPadding ? 0 : Measures.hPadding),
                  color: backgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: noContentHPadding ? Measures.hPadding : 0),
                        child: Text(title, style: Fonts.bold()),
                      ),
                      const SizedBox(height: Measures.vMarginSmall),
                      if (message != null)
                        Flexible(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                      horizontal: noContentHPadding ? Measures.hPadding : 0)
                                  .copyWith(bottom: Measures.vMarginSmall),
                              child: MarkdownBody(
                                  data: message,
                                  shrinkWrap: true,
                                  styleSheet: MarkdownStyleSheet(
                                      // TODO in mago c'è un pezzo nero
                                      p: Fonts.light(size: 15),
                                      tableBody: Fonts.light(size: 12),
                                      listBullet: Fonts.light(size: 15),
                                      tableCellsPadding: const EdgeInsets.all(4))),
                            ),
                          ),
                        ),
                      if (child != null) Flexible(child: SingleChildScrollView(child: child)),
                      const SizedBox(height: Measures.vMarginThin),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: noContentHPadding ? Measures.hPadding : 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (positiveText != null)
                              TextButton(
                                onPressed: () {
                                  positiveCallback?.call();
                                  if (canPopPositiveCallback?.call() ?? true) {
                                    Navigator.pop(this);
                                  }
                                },
                                child: Text(positiveText.toUpperCase(), style: Fonts.bold(size: 15)),
                              ),
                            if (negativeText != null)
                              TextButton(
                                onPressed: () {
                                  negativeCallback?.call();
                                  Navigator.pop(this);
                                },
                                child: Text(negativeText.toUpperCase(), style: Fonts.bold(size: 15)),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // FIXME: use CupertinoDatePicker
  Future<DateTime?> askDate(BuildContext context, {DateTime? init}) async {
    return await showDatePicker(
      context: context,
      initialDate: init ?? DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
  }

  // TODO: convert to a more iOS style snackbar, maybe like this https://github.com/zaniluca/SwiftUISnackbar
  snackbar(
    String message, {
    Color backgroundColor = Palette.primary,
    double bottomMargin = Measures.vMarginMed,
    Function()? undoCallback,
  }) async =>
      await ScaffoldMessenger.of(this)
          .showSnackBar(
            SnackBar(
              duration: undoCallback == null ? const Duration(seconds: 3) : const Duration(seconds: 5),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              margin: EdgeInsets.only(
                  left: Measures.hPadding, right: Measures.hPadding, bottom: bottomMargin),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              behavior: SnackBarBehavior.floating,
              backgroundColor: backgroundColor,
              elevation: 0,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(message, style: Fonts.regular())),
                  if (undoCallback != null)
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(this).clearSnackBars();
                        undoCallback();
                      },
                      child: Text('ANNULLA', style: Fonts.bold(size: 15)),
                    )
                ],
              ),
            ),
          )
          .closed;

  /// Shortcut for pushing a new screen with [args].
  ///
  /// If [pop], the current screen will be discarded from the Navigation stack, so that any pop actions won't be able to restore the screen.
  Future<Object?> goto(String routeName, {bool pop = false, Object? args}) async => await (pop
      ? Navigator.of(this).popAndPushNamed
      : Navigator.of(this).pushNamed)(routeName, arguments: args);

  /// Shortcut for popping a screen
  pop([Object? arguments]) => Navigator.of(this).pop(arguments);
}
