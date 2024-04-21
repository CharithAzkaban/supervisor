import 'package:flutter/material.dart';
import 'package:performer/utils/consts.dart';
import 'package:text_scroll/text_scroll.dart';

class PrimaryText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool scroll;
  const PrimaryText(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.scroll = false,
  });

  @override
  Widget build(BuildContext context) {
    return scroll
        ? TextScroll(
            '$text     ',
            textAlign: textAlign,
            mode: TextScrollMode.endless,
            velocity: const Velocity(pixelsPerSecond: Offset(20, 0)),
            style: TextStyle(
              color: color ?? grey,
              fontSize: fontSize,
              fontWeight: fontWeight,
              overflow: overflow,
            ),
          )
        : Text(
            text ?? '',
            textAlign: textAlign,
            maxLines: maxLines,
            style: TextStyle(
              color: color ?? grey,
              fontSize: fontSize,
              fontWeight: fontWeight,
              overflow: overflow,
            ),
          );
  }
}
