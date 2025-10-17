import 'package:http/http.dart' as http;
import 'dart:convert';


class QuestionnaireData1 {
  final String antecedents;
  final String medicaments;
  final String sommeil;
  final String sommeilApnee;
  final String poidsRecent;
  final String repasTypique;
  final String portionsFruitsLegumes;
  final String grignotage;
  final String frequenceBoissons;
  // Données de la classe 2
  final String activitePhysique;
  final String tempsAssis;
  final String activitesAppreciees;
  final String frequenceCardiaque;
  final String comportAlimentaire;
  final String finAssiette;
  final String regimeSuivi;
  final String objectifSante;
  final String poidsPerdu;
  final String motivation;

  QuestionnaireData1({
    required this.antecedents,
    required this.medicaments,
    required this.sommeil,
    required this.sommeilApnee,
    required this.poidsRecent,
    required this.repasTypique,
    required this.portionsFruitsLegumes,
    required this.grignotage,
    required this.frequenceBoissons,
    required this.activitePhysique,
    required this.tempsAssis,
    required this.activitesAppreciees,
    required this.frequenceCardiaque,
    required this.comportAlimentaire,
    required this.finAssiette,
    required this.regimeSuivi,
    required this.objectifSante,
    required this.poidsPerdu,
    required this.motivation,
  });

  Map<String, dynamic> toJson() {
    return {
      'antecedents': antecedents,
      'medicaments': medicaments,
      'sommeil': sommeil,
      'sommeilApnee' : sommeilApnee,
      'poidsRecent': poidsRecent,
      'repasTypique': repasTypique,
      'portionsFruitsLegumes': portionsFruitsLegumes,
      'grignotage': grignotage,
      'frequenceBoissons': frequenceBoissons,
      'activitePhysique': activitePhysique,
      'tempsAssis': tempsAssis,
      'activitesAppreciees': activitesAppreciees,
      'frequenceCardiaque': frequenceCardiaque,
      'comportAlimentaire': comportAlimentaire,
      'finAssiette': finAssiette,
      'regimeSuivi': regimeSuivi,
      'objectifSante': objectifSante,
      'poidsPerdu': poidsPerdu,
      'motivation': motivation,
    };
  }

  Future<void> envoyerDonnees() async {
    try {
      final response = await http.post(
        Uri.parse('https://nutrition.pixeluxt.com/api/'),
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