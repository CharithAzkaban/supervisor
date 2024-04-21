import 'package:flutter/material.dart';
import 'package:performer/utils/actions.dart';
import 'package:performer/utils/consts.dart';

import 'primary_icon_button.dart';

class Back extends StatelessWidget {
  final dynamic result;
  final Color? iconColor;
  final Color? backgroundColor;
  const Back({
    super.key,
    this.result,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: PrimaryIconButton(
        onPressed: () {
          if (Navigator.canPop(context)) {
            pop(
              context,
              result: result,
            );
          }
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: white,
        ),
        fill: false,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
