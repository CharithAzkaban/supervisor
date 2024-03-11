import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supervisor/utils/consts.dart';

import 'loader.dart';
import 'primary_text.dart';

class PopupAction extends StatefulWidget {
  final FutureOr Function() onPressed;
  final String label;
  final String? waitingLabel;
  final Color? color;
  const PopupAction({
    super.key,
    required this.onPressed,
    required this.label,
    this.waitingLabel,
    this.color,
  });

  @override
  State<PopupAction> createState() => _PopupActionState();
}

class _PopupActionState extends State<PopupAction> {
  final _waitingListener = ValueNotifier<String?>(null);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _waitingListener,
      builder: (context, waitingLabel, _) => TextButton.icon(
        icon: waitingLabel != null ? const Loader(radius: 5.0) : dummy,
        onPressed: waitingLabel != null
            ? null
            : () async {
                if (widget.onPressed is Future Function()) {
                  _waitingListener.value = widget.waitingLabel ?? 'Waiting...';
                  await widget.onPressed();
                  _waitingListener.value = null;
                  return;
                }
                widget.onPressed();
              },
        label: PrimaryText(
          waitingLabel ?? widget.label,
          color: waitingLabel != null ? grey : widget.color,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}