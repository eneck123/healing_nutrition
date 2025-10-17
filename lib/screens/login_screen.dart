import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin_screen/admin_users_screen.dart';

import 'package:flutter_application_1/screens/password_modify.dart';
import '../models/user_login_service.dart';
import '/accueil/accueil_mobile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  final UserLoginService _userLoginService = UserLoginService();

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _login() async {
  if (_formKey.currentState!.validate()) {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    try {
      // Vérification spécifique pour l'admin
      if (email == 'adminnutrition@gmail.com' && password == 'AdminNutrition123@') {
        // Appel au service de connexion pour l'admin
        var response = await _userLoginService.login(
          email: email,
          motDePasse: password,
        );

        if (response['success']) {
          final role = response['role'];
          print('👑 Rôle reçu après connexion: $role');
         // String? token = response['token'];
          
          // Message de succès pour l'admin
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Connexion administrateur réussie'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );

          // Redirection vers l'interface admin
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AdminUsersScreen()),
              (Route<dynamic> route) => false,
            );
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erreur d\'authentification administrateur'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Pour les utilisateurs normaux
        var response = await _userLoginService.login(
          email: email,
          motDePasse: password,
        );

        if (response['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['message']),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AccueilMobile()),
              (Route<dynamic> route) => false,
            );
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['message']),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
     


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Se connecter'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 16.0),
              const Text(
                'Veuillez entrer votre adresse e-mail',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Adresse e-mail',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre adresse e-mail';
                  } else if (value != 'adminnutrition@gmail' && !value.endsWith('@gmail.com')) {
                    return 'L\'adresse e-mail doit se terminer par @gmail.com';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Veuillez entrer votre mot de passe',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Mot de passe',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  } else if (value.length < 10) {
                    return 'Le mot de passe doit comporter au moins 10 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              const Text(
                '10 caractères minimum',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Se connecter'),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PasswordModify()),
                  );
                },
                child: const Text(
                  'Mot de passe oublié ?',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
