import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double? radius;
  const Loader({
    super.key,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(50.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}