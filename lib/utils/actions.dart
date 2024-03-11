import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supervisor/providers/popup_provider.dart';
import 'package:supervisor/utils/methods.dart';
import 'package:supervisor/widgets/loader.dart';
import 'package:supervisor/widgets/popup_action.dart';
import 'package:supervisor/widgets/primary_text.dart';

import 'consts.dart';

void confirm(
  BuildContext context, {
  required FutureOr Function() onConfirm,
  required String confirmMessage,
  String confirmLabel = 'OK',
  bool outTapDismissible = true,
}) =>
    popup(
      context,
      outTapDismissible: outTapDismissible,
      title: const PrimaryText(
        'Confirmation',
        color: black,
      ),
      content: PrimaryText(
        confirmMessage,
        color: black,
      ),
      actions: [
        PopupAction(
          onPressed: () => pop(context),
          label: 'CANCEL',
          color: error,
        ),
        PopupAction(
          onPressed: () {
            pop(context);
            onConfirm();
          },
          label: confirmLabel,
          color: primary,
        ),
      ],
    );

void notify(
  BuildContext context, {
  required String message,
  Color? messageColor,
  String? actionLabel,
  void Function()? onPressed,
}) {
  final snackBar = SnackBar(
    content: PrimaryText(
      message,
      color: messageColor,
    ),
    action: notNull(onPressed)
        ? SnackBarAction(
            label: actionLabel ?? 'Ok',
            onPressed: onPressed!,
          )
        : null,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void pop(BuildContext context, {dynamic result}) => context.pop(result);

Future popup(
  BuildContext context, {
  Widget? title,
  Widget? content,
  bool outTapDismissible = true,
  List<PopupAction>? actions,
}) =>
    showDialog(
      context: context,
      barrierDismissible: outTapDismissible,
      builder: (context) => AlertDialog(
        title: title,
        content: Padding(
          padding: const EdgeInsets.all(15.0),
          child: content,
        ),
        contentPadding: const EdgeInsets.all(5.0),
        actions: actions,
      ),
    );

void waitAndDo(
  int milliseconds,
  FutureOr Function()? doThis,
) =>
    Future.delayed(
      Duration(milliseconds: milliseconds),
      doThis,
    );

void waiting(
  BuildContext context, {
  required Future Function() futureTask,
  required void Function(dynamic) afterTask,
  bool outTapDismissible = true,
}) {
  popup(
    context,
    outTapDismissible: outTapDismissible,
    title: const Loader(),
    content: Consumer<PopupProvider>(
      builder: (context, popupData, _) => PrimaryText(
        popupData.waitingMessage ?? 'Please wait...',
        textAlign: TextAlign.center,
      ),
    ),
  );
  futureTask().then((value) {
    pop(context);
    waitAndDo(
      500,
      () {
        provider<PopupProvider>(context).setWaitingMessage(null);
        afterTask(value);
      },
    );
  });
}

void unfocus() => FocusManager.instance.primaryFocus?.unfocus();
