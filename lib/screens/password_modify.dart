import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/verify_code_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PasswordModify(),
    );
  }
}

class PasswordModify extends StatefulWidget {
  const PasswordModify({super.key});

  @override
  _PasswordModifyState createState() => _PasswordModifyState();
}

class _PasswordModifyState extends State<PasswordModify> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _submitEmail() async {
    print("Init request");
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showErrorDialog('Erreur ! Veuillez entrer votre email');
      return;
    }

    if (!email.endsWith('@gmail.com')) {
      _showErrorDialog('Erreur ! Veuillez entrer une adresse Gmail valide');
      return;
    }

    final Uri uri = Uri.parse('https://healing-nutrition-plan.pixeluxt.com/api/auth/forgot-password');
    print("URL complète : $uri");

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      print('Status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.headers['content-type']?.contains('application/json') ?? false) {
        var decodedBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerifyCodeScreen()),
          );
        } else {
          _showErrorDialog(decodedBody['message'] ?? 'Erreur lors de l\'envoi. Veuillez réessayer');
        }
      } else {
        _showErrorDialog('Réponse invalide du serveur');
      }
    } catch (error) {
      print('Exception détaillée: $error');
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
        title: const Text('Mot de passe oublié'),
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
              'Saisir votre e-mail',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Votre e-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Soumettre'),
            ),
          ],
        ),
      ),
    );
  }
}
