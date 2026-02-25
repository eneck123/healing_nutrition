import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserLoginService {
  final String apiUrl = "https://healing-nutrition-plan.pixeluxt.com/";
  static const String loginUrl = 'api/login';
  static const String tokenKey = 'auth_token';
  static const String roleKey = 'user_role';

  Future<Map<String, dynamic>> login({
    required String email,
    required String motDePasse,
  }) async {
    print('init request');
    try {
      // Vérifier si un jeton existe déjà
      final token = await getToken();
      final role = await getRole();

      if (token != null && token.isNotEmpty) {
        return {
          'success': true,
          'message': 'Utilisateur déjà connecté !',
          'token': token,
          'role': role,
        };
      }

      // Procéder à la connexion
      final response = await http.post(
        Uri.parse(apiUrl + loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'mot_de_passe': motDePasse,
        }),
      );

print(response);
print('Status code: ${response.statusCode}');
print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'] ?? '';
        final role = responseData['data']['role'] == 'Administrateur' ? 'admin' : 'user';

            print('🎫 Token reçu: ${token.substring(0, 20)}...');
            print('👑 Rôle détecté: $role');
        if (token == null) {
            return {
              'success': false,
              'message': 'Token manquant dans la réponse',
            };
          }


        // Stocker le jeton et le rôle
        await _storeToken(token);
        await storeRole(role);

        // Vérifiez que le token a bien été stocké
      final storedToken = await getToken();
      if (storedToken == null || storedToken.isEmpty) {
        return {
          'success': false,
          'message': 'Échec du stockage du token',
        };
      }

        return {
          'success': true,
          'message': 'Connexion réussie !',
          'token': token,
          'role': role,
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

  // Méthodes pour stocker et récupérer le jeton
  /*Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }*/

  Future<void> _storeToken(String token) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
    print('Token stocké avec succès: $token');
     print('Token admin stocké avec succès: $token'); 
  } catch (e) {
    print('Erreur lors du stockage du token: $e');
  }
}

 /* Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }*/

  Future<String?> getToken() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(tokenKey);
    print('Token récupéré: $token');
    return token;
  } catch (e) {
    print('Erreur lors de la récupération du token: $e');
    return null;
  }
 }

  // Méthodes pour stocker et récupérer le rôle
  Future<void> storeRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(roleKey, role);
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(roleKey);
  }

  // Méthode de déconnexion
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(roleKey);
  }

  Future<bool> isAuthenticated() async {
  final token = await getToken();
  return token != null && token.isNotEmpty;
}

  storeToken(String adminToken) {}
}