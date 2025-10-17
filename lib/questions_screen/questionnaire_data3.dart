import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionnaireData3 {
  final String problemesSanteObesite;
  final String operationsChirurgicales;
  final String douleursArticulaires;
  final String variationsPoids;
  final String sommeil;
  final String sommeilApnee;
  final String restrictionsAlimentaires;
  final String alimentsRichesCalories;
  final String planNutritionnel;
  final String boissonsSucrees;

  // Données de la classe 2
  final String activitePhysique;
  final String activitesAppreciees;
  final String programExercice;
  final String comportAlimentaire;
  final String sentimentsEmotionnels;
  final String essaisPertePoids;
  final String objectifSante;
  final String poidsPerdu;
  final String motivation;

  QuestionnaireData3({
    required this.problemesSanteObesite,
    required this.operationsChirurgicales,
    required this.douleursArticulaires,
    required this.variationsPoids,
    required this.sommeil,
    required this.sommeilApnee,
    required this.restrictionsAlimentaires,
    required this.alimentsRichesCalories,
    required this.planNutritionnel,
    required this.boissonsSucrees,
    required this.activitePhysique,
    required this.activitesAppreciees,
    required this.programExercice,
    required this.comportAlimentaire,
    required this.sentimentsEmotionnels,
    required this.essaisPertePoids,
    required this.objectifSante,
    required this.poidsPerdu,
    required this.motivation,
  });

  Map<String, dynamic> toJson() {
    return {
      'problemesSanteObesite': problemesSanteObesite,
      'operationsChirurgicales': operationsChirurgicales,
      'douleursArticulaires': douleursArticulaires,
      'variationsPoids': variationsPoids,
      'sommeil': sommeil,
      'sommeilApnee': sommeilApnee,
      'restrictionsAlimentaires': restrictionsAlimentaires,
      'alimentsRichesCalories': alimentsRichesCalories,
      'planNutritionnel': planNutritionnel,
      'boissonsSucrees': boissonsSucrees,
      'activitePhysique': activitePhysique,
      'activitesAppreciees': activitesAppreciees,
      'programExercie' : programExercice,
      'comportAlimentaire': comportAlimentaire,
      'sentimentsEmotionnels': sentimentsEmotionnels,
      'regimeSuivi': essaisPertePoids,
      'objectifSante': objectifSante,
      'poidsPerdu': poidsPerdu,
      'motivation': motivation,
    };
  }

  Future<void> envoyerDonnees() async {
    try {
      final response = await http.post(
        Uri.parse('VOTRE_URL_API'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(toJson()),
      );

      if (response.statusCode == 200) {
        print('Données envoyées avec succès');
      } else {
        throw Exception('Échec de l\'envoi des données');
      }
    } catch (e) {
      throw Exception('Erreur lors de l\'envoi des données: $e');
    }
  }
}
