import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionnaireData5 {
  // Données de la première classe
  final String maladiesChroniques;
  final String apneeSommeil;
  final String utiliseCPAP;
  final String difficultesActivitesQuotidiennes;
  final String changementPoids;
  final String compulsionsAlimentaires;
  final String regimeRestrictif;
  final String difficulteControlePortions;
  final String consommationBoissons;

  // Données de la deuxième classe
  final String mobilite;
  final String activitePhysique;
  final String equipementSpecialise;
  final String frequenceCardiaque;
  final String gestionCritiques;
  final String objectifsSante;
  final String motivationChangement;
  final String participation;
  final String suivi;
  final String chirugieBariatrique;

  QuestionnaireData5({
    // Constructeur pour les données de la première classe
    required this.maladiesChroniques,
    required this.apneeSommeil,
    required this.utiliseCPAP,
    required this.difficultesActivitesQuotidiennes,
    required this.changementPoids,
    required this.compulsionsAlimentaires,
    required this.regimeRestrictif,
    required this.difficulteControlePortions,
    required this.consommationBoissons,
    
    // Constructeur pour les données de la deuxième classe
    required this.mobilite,
    required this.activitePhysique,
    required this.equipementSpecialise,
    required this.frequenceCardiaque,
    required this.gestionCritiques,
    required this.objectifsSante,
    required this.motivationChangement,
    required this.participation,
    required this.suivi,
    required this.chirugieBariatrique,
  });

  Map<String, dynamic> toJson() {
    return {
      'maladiesChroniques': maladiesChroniques,
      'apneeSommeil': apneeSommeil,
      'utiliseCPAP': utiliseCPAP,
      'difficultesActivitesQuotidiennes': difficultesActivitesQuotidiennes,
      'changementPoids': changementPoids,
      'compulsionsAlimentaires': compulsionsAlimentaires,
      'regimeRestrictif': regimeRestrictif,
      'difficulteControlePortions': difficulteControlePortions,
      'consommationBoissons': consommationBoissons,
      'mobilite': mobilite,
      'activitePhysique': activitePhysique,
      'equipementSpecialise': equipementSpecialise,
      'frequenceCardiaque': frequenceCardiaque,
      'gestionCritiques': gestionCritiques,
      'objectifsSante': objectifsSante,
      'motivationChangement': motivationChangement,
      'participation': participation,
      'suivi': suivi,
      'chirugieBariatrique': chirugieBariatrique,
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
