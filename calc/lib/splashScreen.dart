import 'package:flutter/material.dart';
import 'calculator_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback toggleTheme; // Declare the toggleTheme function

  const SplashScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the calculator screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CalculatorScreen(
            toggleTheme:
                widget.toggleTheme, // Pass the toggleTheme from the widget
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 99, 162, 249),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(20), // Adjust the radius as needed
              child: Image.asset(
                'lib/assets/calc.webp',
                height: 150,
                fit: BoxFit
                    .cover, // Adjusts the image to cover the area while maintaining aspect ratio
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Loading indicator
            const SizedBox(height: 20),
            const Text(
              'Calculator',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
