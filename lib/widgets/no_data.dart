import 'package:flutter/material.dart';
import 'package:performer/widgets/primary_text.dart';

class NoData extends StatelessWidget {
  final String label;
  const NoData(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PrimaryText(label),
    );
  }
}
