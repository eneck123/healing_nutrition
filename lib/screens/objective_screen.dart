import 'package:flutter/material.dart';
import 'personal_info1_screen.dart';

class ObjectiveScreen extends StatelessWidget {
  const ObjectiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Couleur verte pour l'app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Retour à l'écran précédent
          },
        ),
        elevation: 0, // Suppression de l'ombre sous la barre d'application
      ),
      body: Container(
        color: Colors.green, // Fond d'écran en vert
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40), // Espace ajouté après la barre d'application
            // Texte principal centré
            const Text(
              'Super ! Vous venez de franchir une étape importante de votre parcours.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Alignement du texte au centre
            ),
            const SizedBox(height: 20),
            // Texte secondaire
            const Text(
              'Saviez-vous l\'importance de la connaissance des informations personnelles ?\n'
              'En connaissant vos données personnelles, nous pouvons vous fournir des recommandations plus adaptées à vos besoins spécifiques.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            // Troisième texte
            const Text(
              'Nous avons besoin de recueillir vos informations personnelles afin de vous accompagner dans la personnalisation de votre plan nutritionnel. Cela nous permettra de mieux comprendre votre situation et de vous proposer des conseils nutritionnels pertinents et spécifiques à vos objectifs.\n',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10), // Espace entre les deux parties du texte
            // Texte centré
            const Center(
              child: Text(
                'Sans plus tarder, commençons !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(),
            // Bouton "Suivant"
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalInfo1Screen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Fond blanc pour le bouton
                  minimumSize: const Size(double.infinity, 50), // Taille large du bouton
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Suivant',
                  style: TextStyle(color: Colors.green, fontSize: 18), // Texte en vert
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
