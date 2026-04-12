import 'package:flutter/material.dart';
import 'objective_screen.dart'; // Assurez-vous d'importer le fichier contenant ObjectiveScreen

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Retour à l'écran précédent
            },
          ),
          title: const Text('S\'inscrire'), 
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Bienvenue ! Personnalisons ensemble HealingNutrition afin de vous accompagner dans l\'obtention de votre plan nutritionnel.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ObjectiveScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Couleur du bouton
                  minimumSize: const Size(double.infinity, 50), // Bouton pleine largeur
                ),
                child: const Text(
                  'Continuer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              // Spacer(), // Espace pour pousser le texte en bas
              // Text(
              //   'Nous ne publierons jamais rien sans votre autorisation. Nous recueillerons des informations personnelles auprès de vous et à votre sujet, et nous les utiliserons à diverses fins, notamment afin de personnaliser votre expérience HealingNutrition.',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Color.fromARGB(255, 148, 139, 139),
              //     fontSize: 12,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
