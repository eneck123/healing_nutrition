import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRegistrationService {
  final String apiUrl = "https://healing-nutrition-plan.com/";
  static const String registerUrl = 'api/register';

  Future<Map<String, dynamic>> registerUser({
    required String nom,
    required String prenom,
    required int age,
    required String sexe,
    required int poids,
    required int taille,
    required double tourDeTaille,
    required double tourDeHanche,
    required double tourDuCou,
    required String niveauActivite,
    required String email,
    required String motDePasse,
  }) async {
    print("Init request");
    final Uri uri = Uri.parse(apiUrl + registerUrl);
    print("URL complète : $uri"); // Déboguer l'URL

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json', // Ajout de l'en-tête Accept
        },
        body: jsonEncode(<String, dynamic>{
          'nom': nom,
          'prenom': prenom,
          'age': age,
          'sexe': sexe,
          'poids': poids,
          'taille': taille,
          'tour_de_taille': tourDeTaille,
          'tour_de_hanche': tourDeHanche,
          'tour_du_cou': tourDuCou,
          'niveau_d_activite_physique': niveauActivite,
          'email': email,
          'mot_de_passe': motDePasse,
        }),
      );

      // Afficher les détails de la réponse pour le débogage
      print('Status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      // Vérifier d'abord si le corps de la réponse est du JSON valide
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        var decodedBody = jsonDecode(response.body);
        
        if (response.statusCode == 201 || response.statusCode == 200) {
          return {
            'success': true,
            'message': 'Inscription réussie !',
            'data': decodedBody,
          };
        } else {
          return {
            'success': false,
            'message': decodedBody['message'] ?? 'Échec de l\'inscription',
            'data': decodedBody,
          };
        }
      } else {
        // Si la réponse n'est pas du JSON
        return {
          'success': false,
          'message': 'Réponse invalide du serveur',
          'data': {'error': 'Le serveur n\'a pas renvoyé du JSON valide'}
        };
      }
    } catch (e) {
      print('Exception détaillée: $e');
      return {
        'success': false,
        'message': 'Erreur lors de l\'inscription : ${e.toString()}',
      };
    }
  }
}