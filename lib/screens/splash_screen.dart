import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0; // Initial opacity is set to 0 (image is invisible)

  @override
  void initState() {
    super.initState();

    // Delay before starting the fade-in effect for the image
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _opacity = 1.0; // Start the fade-in effect by setting opacity to 1 (fully visible)
      });
    });

    // Navigate to the home screen after the image has fully faded in
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2), // Duration of the fade-in effect
          child: Image.asset('assets/images/retro.png'),
        ),
      ),
    );
  }
}
