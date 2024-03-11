import 'package:flutter/material.dart';
import 'package:supervisor/providers/auth_provider.dart';
import 'package:supervisor/utils/actions.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    waitAndDo(
      2000,
      () => provider<AuthProvider>(context).refresh(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: assetImage(
            ImageEnum.logo,
          ),
        ),
      ),
    );
  }
}
