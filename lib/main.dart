import 'package:flutter/material.dart';
import 'package:tashkeelremake/Mobile/Pages/intro.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tashkeel',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home:  SplashScreen(), // Set MainMenu as the home widget
    );
  }
}
