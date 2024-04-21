import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:performer/providers/popup_provider.dart';
import 'package:performer/providers/task_provider.dart';
import 'package:performer/utils/consts.dart';
import 'package:performer/utils/methods.dart';

import 'providers/auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => PopupProvider()),
      ChangeNotifierProvider(create: (_) => TaskProvider()),
    ],
    child: const Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      theme: ThemeData(
        primarySwatch: getMaterialColor(primary),
      ),
    );
  }
}
