import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supervisor/utils/actions.dart';

class ExitScope extends StatelessWidget {
  final Widget child;
  const ExitScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => confirm(
        context,
        confirmMessage: 'Would you like to exit from the app right now?',
        confirmLabel: 'EXIT',
        outTapDismissible: false,
        onConfirm: () => SystemNavigator.pop(),
      ),
      child: child,
    );
  }
}
