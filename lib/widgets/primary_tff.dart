import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'primary_icon_button.dart';

class PrimaryTFF extends StatefulWidget {
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool autofocus;
  final bool readOnly;
  final String obscuringCharacter;
  final bool obscureText;
  final bool showEye;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool rounded;
  const PrimaryTFF({
    super.key,
    this.width,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.autofocus = false,
    this.readOnly = false,
    this.obscuringCharacter = '*',
    this.obscureText = false,
    this.showEye = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
    this.inputFormatters,
    this.enabled,
    this.hintText,
    this.labelText,
    this.prefixText,
    this.suffixText,
    this.prefixIcon,
    this.suffixIcon,
    this.rounded = false,
  });

  @override
  State<PrimaryTFF> createState() => _PrimaryTFFState();
}

class _PrimaryTFFState extends State<PrimaryTFF> {
  final _eyeListener = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: ValueListenableBuilder(
          valueListenable: _eyeListener,
          builder: (context, show, _) {
            return TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              keyboardType: widget.keyboardType,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              autofocus: widget.autofocus,
              readOnly: widget.readOnly,
              maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              cursorOpacityAnimates: true,
              onFieldSubmitted: widget.onFieldSubmitted,
              validator: widget.validator,
              inputFormatters: widget.inputFormatters,
              enabled: widget.enabled,
              obscureText: widget.obscureText && !show,
              obscuringCharacter: widget.obscuringCharacter,
              decoration: InputDecoration(
                hintText: widget.hintText,
                labelText: widget.labelText,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.obscureText && widget.showEye
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: PrimaryIconButton(
                          onPressed: () => _eyeListener.value = !show,
                          icon: Icon(
                            show
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                        ),
                      )
                    : widget.suffixIcon,
                prefixText: widget.prefixText,
                suffixText: widget.suffixText,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.rounded ? 50.0 : 10.0),
                ),
              ),
            );
          }),
    );
  }
}
