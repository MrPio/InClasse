import 'dart:ui';

import 'package:flutter/cupertino.dart';
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
  Future<void> snackbar(
      String message, {
        Color backgroundColor = CupertinoColors.transparent,
        double bottomMargin = 130.0,
        VoidCallback? undoCallback,
      }) async {
    final overlay = Overlay.of(this);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: 20,
        right: 20,
        bottom: bottomMargin,
        child: CupertinoPopupSurface(
          isSurfacePainted: false,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: Fonts.regular(size: 16),
                  ),
                ),
                if (undoCallback != null)
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      'ANNULLA',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .actionTextStyle
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    onPressed: () {
                      overlayEntry.remove();
                      undoCallback();
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    await Future.delayed(Duration(seconds: undoCallback == null ? 3 : 5));
    overlayEntry.remove();
  }


  /// Shortcut for pushing a new screen with [args].
  ///
  /// If [pop], the current screen will be discarded from the Navigation stack, so that any pop actions won't be able to restore the screen.
  Future<Object?> goto(String routeName, {bool pop = false, Object? args}) async => await (pop
      ? Navigator.of(this).popAndPushNamed
      : Navigator.of(this).pushNamed)(routeName, arguments: args);

  /// Shortcut for popping a screen
  pop([Object? arguments]) => Navigator.of(this).pop(arguments);
}
