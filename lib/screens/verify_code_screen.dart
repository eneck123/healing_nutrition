import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/reset_password_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyCodeScreen extends StatefulWidget {
  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String? _errorMessage;

  Future<void> _verifyCode() async {
    print("Init request");
    final email = _emailController.text.trim();
    final code = _codeController.text.trim();

    // Vérifier si les champs sont vides
    if (email.isEmpty) {
      _showErrorDialog('Erreur ! Veuillez entrer votre adresse email');
      return;
    }
    if (code.isEmpty) {
      _showErrorDialog('Erreur ! Veuillez entrer votre code');
      return;
    }

    final Uri uri = Uri.parse('https://healing-nutrition-plan.com/api/auth/forgot-password/verify');
    print("URL complète : $uri"); // Debug URL

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'code': code}),
      );

      // Afficher les détails de la réponse pour le débogage
      print('Status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      // Vérifier si la réponse est JSON valide
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        final decodedBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          // Redirection en cas de succès
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
          );
        } else {
          _showErrorDialog(decodedBody['message'] ?? 'Erreur ! Code incorrect ou problème de vérification');
        }
      } else {
        _showErrorDialog('Réponse invalide du serveur');
      }
    } catch (e) {
      print('Exception détaillée: $e');
      _showErrorDialog('Erreur réseau. Vérifiez votre connexion et réessayez');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Erreur',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vérification du code'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Saisir l\'email et le code reçu par email',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Adresse email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Code de vérification',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _verifyCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Vérifier'),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.redAccent,
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.white),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
