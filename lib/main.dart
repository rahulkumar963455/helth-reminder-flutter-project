import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:health_reminder/providers/input_data_provider.dart';
import 'package:health_reminder/providers/setting_provider.dart';
import 'package:health_reminder/providers/step_count_provider.dart';
import 'package:health_reminder/providers/water_provider.dart';
import 'package:health_reminder/screens/splash_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => StepCounterProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => WaterProvider()),
      ],
      child: const MyApp(),
    ),
  );
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}
