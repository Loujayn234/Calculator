import 'package:calc/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Track theme mode (dark or light)
  bool isDarkMode = true;

  // Define light and dark themes
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: const Color.fromARGB(255, 1, 11, 33),
  );

  // Method to toggle between themes
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: lightTheme, // Light theme
      darkTheme: darkTheme, // Dark theme
      themeMode: isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Apply theme based on mode
      home: SplashScreen(toggleTheme: toggleTheme),
    );
  }
}
