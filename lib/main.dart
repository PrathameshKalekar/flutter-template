import 'dart:developer';

import 'package:flutter/material.dart';

import 'core/services/intializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initializer().init();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({super.key});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log('Current state = $state');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(),
    );
  }
}
