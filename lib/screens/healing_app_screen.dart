import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'dart:async';

class HealingAppScreen extends StatefulWidget {
  const HealingAppScreen({super.key});

  @override
  _HealingAppScreenState createState() => _HealingAppScreenState();
}

class _HealingAppScreenState extends State<HealingAppScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  Timer? _timer;
  bool _showIntroText = true;
  bool _isTextVisible = true;
  int _blinkCount = 0;

  final List<String> _imagePaths = [
    'assets/images/kitchen.jpg',
    'assets/images/sport.jpg',
  ];

  final List<String> _captions = [
    'Une alimentation saine pour votre nutrition',
    'Des exercices pour un mode de vie sain',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startBlinkAndCarouselCycle();
    });
  }

  void _startBlinkAndCarouselCycle() {
    setState(() {
      _showIntroText = true;
      _blinkCount = 0;
      _isTextVisible = true;
    });

    _startTextBlinking();
  }

  void _startTextBlinking() {
    _timer?.cancel(); // Annuler tout timer existant
    _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        _isTextVisible = !_isTextVisible;
        _blinkCount++;
      });

      if (_blinkCount >= 160) { // Clignotement pendant 80 secondes (160 cycles de 500 ms)
        _timer?.cancel();
        setState(() {
          _showIntroText = false;
          _startImageCarousel();
        });
      }
    });
  }

  void _startImageCarousel() {
    _timer?.cancel(); // Annuler tout timer existant
    _timer = Timer.periodic(const Duration(seconds: 30), (Timer timer) {
      setState(() {
        if (_currentPageIndex < _imagePaths.length - 1) {
          _currentPageIndex++;
        } else {
          _currentPageIndex = 0;
        }

        // Vérifier que le PageController a des clients avant d'animer
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPageIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });

      // Réinitialiser le cycle de clignotement après le carousel
      if (_currentPageIndex == _imagePaths.length - 1) {
        Future.delayed(const Duration(seconds: 30), () {
          _blinkCount = 0;
          _startBlinkAndCarouselCycle();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50), // Réduction de l'espace ici
          const Column(
            children: [
              Text(
                'Bienvenue sur',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              Text(
                'healingnutrition',
                style: TextStyle(
                  fontFamily: 'Daughter of Fortune',
                  fontSize: 50, // Taille de la police augmentée
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Animation du texte d'introduction avec clignotement pendant 80 secondes
          if (_showIntroText)
             const Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(seconds: 35),
                    child: Text(
                      "Avec Healing Nutrition, c'est votre plan nutritionnel et surtout !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            // Afficher les images avec leurs légendes simultanément
            SizedBox(
              height: 320, // Diminution de la hauteur de la première image
              child: PageView.builder(
                controller: _pageController,
                itemCount: _imagePaths.length,
                itemBuilder: (context, index) {
                  return AnimatedOpacity(
                    opacity: _currentPageIndex == index ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20), // Ajout de l'espace sur les côtés
                          child: Image.asset(
                            _imagePaths[index],
                            height: 280, // Ajustement de la hauteur de l'image
                          ),
                        ),
                        const SizedBox(height: 10), // Réduction de l'espace entre l'image et sa légende
                        Text(
                          _captions[index],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          const Spacer(),
          // Boutons "S'inscrire" et "Se connecter" en bas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Se connecter",
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
