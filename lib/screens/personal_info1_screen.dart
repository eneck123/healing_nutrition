import 'dart:async'; // Importer pour utiliser Timer
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:intl/intl.dart';
import 'personal_info2_screen.dart';
import '../models/user_model.dart';

class PersonalInfo1Screen extends StatefulWidget {
  const PersonalInfo1Screen({super.key});

  @override
  _PersonalInfo1ScreenState createState() => _PersonalInfo1ScreenState();
}

class _PersonalInfo1ScreenState extends State<PersonalInfo1Screen> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _poidsController = TextEditingController();
  final TextEditingController _tailleController = TextEditingController();

  String _selectedSex = 'Homme';
  final List<String> _missingFields = [];
  Timer? _ageTimer;
  Timer? _tailleTimer;

  @override
  void dispose() {
    // Annuler les timers lorsqu'ils ne sont plus nécessaires
    _ageTimer?.cancel();
    _tailleTimer?.cancel();
    super.dispose();
  }

  bool _validateFields() {
    _missingFields.clear();

    if (_nomController.text.isEmpty) {
      _missingFields.add('nom');
    }
    if (_prenomController.text.isEmpty) {
      _missingFields.add('prénom');
    }
    if (_ageController.text.isEmpty ||
        int.tryParse(_ageController.text) == null ||
        int.parse(_ageController.text) < 16) {
      _missingFields.add('âge (doit être au moins de 18 ans)');
    }
    if (_poidsController.text.isEmpty) {
      _missingFields.add('poids');
    }
    if (_tailleController.text.isEmpty || _tailleController.text.length != 3) {
      _missingFields.add('taille');
    }

    return _missingFields.isEmpty;
  }

  void _showErrorDialog() {
    String errorMessage;

    if (_missingFields.isNotEmpty) {
      if (_missingFields.length == 1) {
        errorMessage = 'Veuillez entrer votre ${_missingFields[0]}.';
      } else if (_missingFields.length == 2) {
        errorMessage =
            'Veuillez entrer votre ${_missingFields[0]} et ${_missingFields[1]}.';
      } else {
        errorMessage =
            'Veuillez entrer votre ${_missingFields.sublist(0, _missingFields.length - 1).join(', ')} et ${_missingFields.last}.';
      }
    } else {
      errorMessage = 'Veuillez entrer vos informations personnelles.';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erreur !'),
          content: Text(errorMessage),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showInfoBubble(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onAgeChanged(String value) {
    // Annuler le précédent timer s'il existe
    _ageTimer?.cancel();

    if (value.length >= 2) {
      // Démarrer un nouveau timer
      _ageTimer = Timer(const Duration(seconds: 5), () {
        if (int.tryParse(value) != null && int.parse(value) < 16) {
          _showInfoBubble('L\'âge doit être au moins de 16 ans');
        }
      });
    }
  }

  void _onTailleChanged(String value) {
    // Annuler le précédent timer s'il existe
    _tailleTimer?.cancel();

    if (value.length == 3) {
      // Démarrer un nouveau timer
      _tailleTimer = Timer(const Duration(seconds: 5), () {
        if (int.tryParse(value) == null) {
          _showInfoBubble(
              'Veuillez indiquer une valeur correcte pour la taille');
        }
      });
    } else if (value.length > 3) {
      _showInfoBubble('Veuillez entrer exactement 3 chiffres pour la taille');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Informations Personnelles'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  'Parlez-nous un peu de vous',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24.0),
                const Text(
                  'Quel est votre nom ?',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _nomController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nom en majuscule ',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 27.0),
                const Text(
                  'Quel est votre prénom ?',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _prenomController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prénom començant par une lettre majuscule',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 27.0),
                const Text(
                  'Quel est votre âge ?',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Âge',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: _onAgeChanged,
                ),
                const SizedBox(height: 27.0),
                const Text(
                  'Quel est votre sexe ?',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _selectedSex,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Sexe',
                    prefixIcon: Icon(Icons.wc),
                  ),
                  items: ['H', 'F'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSex = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 27.0),
                const Text(
                  'Combien pesez-vous ?',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _poidsController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Poids (en kg)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 27.0),
                const Text(
                  'Combien mesurez-vous ?',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _tailleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Taille (en cm comme exemple 193 cm)',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  buildCounter: (BuildContext context,
                      {int? currentLength, int? maxLength, bool? isFocused}) {
                    return null;
                  },
                  onChanged: _onTailleChanged,
                ),
                const SizedBox(height: 100.0),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_validateFields()) {
                    // Mise à jour des informations de l'utilisateur
                    userModel.updateUserInfo(
                      nom: _nomController.text,
                      prenom: _prenomController.text,
                      age: int.tryParse(_ageController.text),
                      sexe: _selectedSex,
                      poids: int.tryParse(_poidsController.text),
                      taille: int.tryParse(_tailleController.text),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonalInfo2Screen()),
                    );
                  } else {
                    _showErrorDialog();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 18.0),
                  textStyle: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                child: const Text('Suivant'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
