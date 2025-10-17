import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final String apiUrl = "https://healing-nutrition-plan.com/";
  static const String loginUrl = 'api/login';
  static const String tokenKey = 'auth_token';
  final NavigationService _navigationService;
  
  AuthenticationService(this._navigationService);

  // Stockage du token avec SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  // Login avec gestion du token
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String motDePasse,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl + loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'mot_de_passe': motDePasse,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        
        // Sauvegarde du token
        await saveToken(token);

        return {
          'success': true,
          'message': 'Connexion réussie !',
          'data': responseData,
        };
      } else {
        return {
          'success': false,
          'message': 'Échec de la connexion : ${response.body}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur lors de la connexion : ${e.toString()}',
      };
    }
  }

  // Méthode pour envoyer le type de maladie chronique
  Future<Map<String, dynamic>> sendObesityChoice(String typeMaladieChronique) async {
    try {
      final token = await getToken();
      
      if (token == null) {
        return {
          'success': false,
          'message': 'Non authentifié'
        };
      }

      final response = await http.post(
        Uri.parse('${apiUrl}api/user_infos/maladie-chronique'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'type_maladie_chronique': typeMaladieChronique,
        }),
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Maladie chronique enregistrée avec succès',
          'data': jsonDecode(response.body),
        };
      } else if (response.statusCode == 401) {
        await handleTokenExpiration();
        return {
          'success': false,
          'message': 'Session expirée',
        };
      } else {
        return {
          'success': false,
          'message': 'Échec de l\'enregistrement : ${response.body}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur lors de l\'envoi : ${e.toString()}',
      };
    }
  }

  // Méthode générique pour les requêtes authentifiées
  Future<http.Response> authenticatedRequest(
    String endpoint,
    String method,
    {Map<String, dynamic>? body}
  ) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Non authentifié');
    }

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final uri = Uri.parse(apiUrl + endpoint);
    
    try {
      late http.Response response;
      
      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'POST':
          response = await http.post(
            uri,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        default:
          throw Exception('Méthode HTTP non supportée');
      }

      if (response.statusCode == 401) {
        await handleTokenExpiration();
      }

      return response;
    } catch (e) {
      throw Exception('Erreur de requête: ${e.toString()}');
    }
  }

  // Gestion de l'expiration du token
  Future<void> handleTokenExpiration() async {
    await removeToken();
    _navigationService.navigateToLogin();
  }

  // Déconnexion
  Future<void> logout() async {
    await removeToken();
    _navigationService.navigateToLogin();
  }
}

// Service de navigation
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateToLogin() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/login',
      (route) => false,
    );
  }
}