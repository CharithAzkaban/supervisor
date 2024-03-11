import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supervisor/utils/consts.dart';

import 'primary_text.dart';

class PrimaryButton extends StatefulWidget {
  final FutureOr Function()? onPressed;
  final String label;
  final String? waitingLabel;
  final Color? backgroundColor;
  final double? width;
  final bool mini;
  final bool outlined;
  final bool rounded;
  final Widget? icon;
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.waitingLabel,
    this.backgroundColor,
    this.width,
    this.mini = false,
    this.outlined = false,
    this.rounded = false,
    this.icon,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  final _waitListener = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _waitListener,
      builder: (context, isWaiting, _) => SizedBox(
        width: widget.width,
        height: 50.0,
        child: widget.outlined
            ? widget.icon != null
                ? OutlinedButton.icon(
                    onPressed: isWaiting
                        ? null
                        : widget.onPressed is Future Function()
                            ? () async {
                                _waitListener.value = true;
                                await widget.onPressed!();
                                _waitListener.value = false;
                              }
                            : widget.onPressed,
                    style: OutlinedButton.styleFrom(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(widget.rounded
                            ? 100.0
                            : widget.mini
                                ? 5.0
                                : 8.0),
                      ),
                      side:
                          BorderSide(color: widget.backgroundColor ?? primary),
                    ),
                    icon: widget.icon!,
                    label: PrimaryText(
                      isWaiting
                          ? widget.waitingLabel ?? 'Wait...'
                          : widget.label,
                      color: widget.backgroundColor ?? primary,
                      fontSize: widget.mini ? 12.0 : null,
                    ),
                  )
                : OutlinedButton(
                    onPressed: isWaiting
                        ? null
                        : widget.onPressed is Future Function()
                            ? () async {
                                _waitListener.value = true;
                                await widget.onPressed!();
                                _waitListener.value = false;
                              }
                            : widget.onPressed,
                    style: OutlinedButton.styleFrom(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(widget.rounded
                            ? 100.0
                            : widget.mini
                                ? 5.0
                                : 8.0),
                      ),
                      side:
                          BorderSide(color: widget.backgroundColor ?? primary),
                    ),
                    child: PrimaryText(
                      isWaiting
                          ? widget.waitingLabel ?? 'Wait...'
                          : widget.label,
                      color: widget.backgroundColor ?? primary,
                      fontSize: widget.mini ? 12.0 : null,
                    ),
                  )
            : widget.icon != null
                ? ElevatedButton.icon(
                    onPressed: isWaiting
                        ? null
                        : widget.onPressed is Future Function()
                            ? () async {
                                _waitListener.value = true;
                                await widget.onPressed!();
                                _waitListener.value = false;
                              }
                            : widget.onPressed,
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: widget.backgroundColor ?? primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(widget.rounded
                            ? 100.0
                            : widget.mini
                                ? 5.0
                                : 8.0),
                      ),
                    ),
                    icon: widget.icon!,
                    label: PrimaryText(
                      isWaiting
                          ? widget.waitingLabel ?? 'Wait...'
                          : widget.label,
                      color: white,
                      fontSize: widget.mini ? 12.0 : null,
                    ),
                  )
                : ElevatedButton(
                    onPressed: isWaiting
                        ? null
                        : widget.onPressed is Future Function()
                            ? () async {
                                _waitListener.value = true;
                                await widget.onPressed!();
                                _waitListener.value = false;
                              }
                            : widget.onPressed,
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: widget.backgroundColor ?? primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(widget.rounded
                            ? 100.0
                            : widget.mini
                                ? 5.0
                                : 8.0),
                      ),
                    ),
                    child: PrimaryText(
                      isWaiting
                          ? widget.waitingLabel ?? 'Wait...'
                          : widget.label,
                      color: white,
                      fontSize: widget.mini ? 12.0 : null,
                    ),
                  ),
      ),
    );
  }
}
