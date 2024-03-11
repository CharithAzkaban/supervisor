import 'package:flutter/material.dart';

class PrimaryIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final bool fill;
  final int? badgeCount;
  final Color? backgroundColor;
  const PrimaryIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.fill = false,
    this.badgeCount,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Badge.count(
      count: badgeCount ?? 0,
      isLabelVisible: badgeCount != null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
          splashRadius: 20.0,
        ),
      ),
    );
  }
}