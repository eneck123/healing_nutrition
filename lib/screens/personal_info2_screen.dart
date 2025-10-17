import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'personal_info3_screen.dart';
import '../models/user_model.dart';



class PersonalInfo2Screen extends StatefulWidget {
  const PersonalInfo2Screen({super.key});

  @override
  _PersonalInfo2ScreenState createState() => _PersonalInfo2ScreenState();
}

class _PersonalInfo2ScreenState extends State<PersonalInfo2Screen> {
  final TextEditingController _tourDeTailleController = TextEditingController();
  final TextEditingController _tourDeHancheController = TextEditingController();
  final TextEditingController _tourDuCouController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur !'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _validateFields() {
    List<String> missingFields = [];

    if (_tourDeTailleController.text.isEmpty) {
      missingFields.add('tour de taille');
    }
    if (_tourDeHancheController.text.isEmpty) {
      missingFields.add('tour de hanche');
    }
    if (_tourDuCouController.text.isEmpty) {
      missingFields.add('tour du cou');
    }

    if (missingFields.isEmpty) {
      // Si tous les champs sont remplis, retourner vrai
      return true;
    } else {
      // Si des champs sont manquants, afficher un message d'erreur
      String errorMessage;
      if (missingFields.length == 1) {
        errorMessage = 'Veuillez entrer votre ${missingFields[0]}.';
      } else {
        errorMessage = 'Veuillez entrer votre ${missingFields.sublist(0, missingFields.length - 1).join(', ')} et ${missingFields.last}.';
      }
      _showErrorDialog(errorMessage);
      // Retourner faux si des champs sont manquants
      return false;
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
            Navigator.pop(context); // Retour à l'écran précédent
          },
        ),
        title: const Text('Vous'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'Complétez vos informations',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24.0),

            // Question pour Tour de Taille
            const Text(
              'Quel est votre tour de taille ?',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _tourDeTailleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tour de Taille (en cm entier ou décimal: 12.09 )',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Le tour de taille est la mesure autour de l’abdomen à l’endroit le plus étroit, souvent juste au-dessus du nombril. Utilisez un ruban à mesurer souple pour cette mesure.',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            const SizedBox(height: 27.0),

            // Question pour Tour de Hanche
            const Text(
              'Quel est votre tour de hanche ?',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _tourDeHancheController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tour de Hanche (en cm entier ou décimal: 12.09)',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Le tour de hanche est la circonférence mesurée autour des hanches à leur point le plus large. Utilisez un ruban à mesurer souple pour cette mesure.',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            const SizedBox(height: 27.0),

            // Question pour Tour du Cou
            const Text(
              'Quel est votre tour du cou ?',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _tourDuCouController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tour du Cou (en cm entier ou décimal: 12.09)',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Le tour du cou est la circonférence mesurée juste au-dessus de la pomme d’Adam. Utilisez un ruban à mesurer souple pour cette mesure.',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            const SizedBox(height: 100.0),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_validateFields()) {
              // Mise à jour des informations de l'utilisateur
              userModel.updateUserInfo(
                tourDeTaille: double.tryParse(_tourDeTailleController.text),
                tourDeHanche: double.tryParse(_tourDeHancheController.text),
                tourDuCou: double.tryParse(_tourDuCouController.text),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PersonalInfo3Screen()),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(double.infinity, 50),
            textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          child: const Text(
            'Suivant',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
