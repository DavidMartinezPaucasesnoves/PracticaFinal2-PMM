import 'package:flutter/material.dart';
import 'package:practica_final_2/screens/home_screen.dart';
import '../routes/app_routes.dart';
import '../models/persona.dart';

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
      },
    );
  }
}