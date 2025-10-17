import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_application_1/models/user_login_service.dart';
import '../questions_screen/questionnaire_classe1.dart';
import '../questions_screen/questionnaire_classe3.dart';
import '../questions_screen/questionnaire_classe5.dart';
import 'package:flutter_application_1/screens/healing_app_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AccueilMobile extends StatefulWidget {
  const AccueilMobile({super.key});

  @override
  _AccueilMobileState createState() => _AccueilMobileState();
}

class _AccueilMobileState extends State<AccueilMobile> {
  String? _selectedObesityType;
  String? _token;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

   Future<void> _getToken() async {
    //final userLoginService = UserLoginService(); // Changement ici
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('auth_token');

    if (storedToken != null) {
      setState(() {
        _token = storedToken;
      });
    } else {
      // Si pas de token stocké, vous pouvez gérer ce cas 
      // (par exemple, rediriger vers l'écran de connexion)
      print('Aucun token trouvé');
    }
  }
 Future<void> _handleObesityChoice() async {
  if (_selectedObesityType == null) return;

  try {
    final authService = AuthenticationService();
    final response = await authService.sendObesityChoice(
      _selectedObesityType!,
      token: _token,
    );

    print('Response reçue: $response'); // Pour débogage

    // Vérifie si la réponse contient les données attendues
    if (response.containsKey('data') && response['data'] != null) {
      // La requête a réussi, affiche le message de succès
      String message = response['message'] ?? 'Opération réussie';
      print('true: $message');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );
      _navigateToQuestionnaire();
    } else {
      // La requête a échoué ou les données sont manquantes
      String errorMessage = response['message'] ?? 'Une erreur est survenue';
      print('false: $errorMessage');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    print('Exception détaillée: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Erreur réseau. Vérifiez votre connexion et réessayez.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

  void _navigateToQuestionnaire() {
    Widget nextScreen;
    switch (_selectedObesityType) {
      case 'obésité modérée':
        nextScreen = const QuestionnaireClasse1();
        break;
      case 'obésité sévère':
        nextScreen = const QuestionnaireClasse3();
        break;
      case 'obésité morbide':
        nextScreen = const QuestionnaireClasse5();
        break;
      default:
        return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  Widget _buildObesityTypeSelection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Commencez par nous donner votre type d\'obésité :',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 40),
        _buildObesityTypeOption(
          'obésité modérée',
          'Connu grace à un Indice de Masse Corporelle (IMC) entre 30 et 34,9 kg/m².',
        ),
        const SizedBox(height: 30),
        _buildObesityTypeOption(
          'obésité sévère',
          'Connu grace à un Indice de Masse Corporelle (IMC) entre 35 et 39,9 kg/m².',
        ),
        const SizedBox(height: 30),
        _buildObesityTypeOption(
          'obésité morbide',
          'Connu grace à un Indice de Masse Corporelle (IMC) de 40 kg/m² ou plus.',
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _selectedObesityType != null ? _handleObesityChoice : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: _selectedObesityType != null ? Colors.green : Colors.grey,
          ),
          child: const Text('Continuer'),
        ),
      ],
    );
  }

  Widget _buildObesityTypeOption(String type, String explanation) {
    bool isSelected = _selectedObesityType == type;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedObesityType = isSelected ? null : type;
                    });
                  },
                  child: Text(
                    type,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              explanation,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'healingnutrition',
            style: TextStyle(
              color: Colors.green,
              fontFamily: 'Daughter of Fortune',
              fontSize: 39,
            ),
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) {
              if (item == 0) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HealingAppScreen()),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Déconnexion'),
                  ],
                ),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    'Votre compagnon dans la gestion de l\'obésité. Nous vous offrons un suivi personnalisé et des conseils adaptés pour vous aider à atteindre un poids santé de manière équilibrée et durable.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                _buildObesityTypeSelection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthenticationService {
  final String apiUrl = "https://healing-nutrition-plan.com/";

  Future<Map<String, dynamic>> sendObesityChoice(
    String typeMaladieChronique, {
    String? token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}api/user_infos/maladie-chronique'),
        headers: {
          'Authorization': 'Bearer ${token ?? ''}',
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'type_maladie_chronique': typeMaladieChronique,
        }),
      );

      print('Status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decodedBody = jsonDecode(response.body);
        return {
          'success': true,
          'message': decodedBody['message'] ?? 'Opération réussie',
          'data': decodedBody['data'],
        };
      } else {
        final decodedBody = jsonDecode(response.body);
        return {
          'success': false,
          'message': decodedBody['message'] ?? 'Erreur lors de l\'envoi des données',
        };
      }
    } catch (e) {
      print('Exception détaillée: $e');
      return {
        'success': false,
        'message': 'Erreur réseau. Veuillez vérifier votre connexion.',
      };
    }
  }
}