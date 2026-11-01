import 'package:flutter/material.dart';
import 'package:practica_final_2/screens/home_screen.dart';
import 'package:practica_final_2/screens/personal_screen.dart';
import '../routes/app_routes.dart';
import '../models/persona.dart';
import 'screens/personal_screen.dart';
import 'screens/widget_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DevProfile App",
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home:(context) => const HomePage(),
        AppRoutes.personal:(context) => const PersonalScreen(),
        AppRoutes.widgetShowcase:(context) => const WidgetScreen(),
      },
    );
  }
}