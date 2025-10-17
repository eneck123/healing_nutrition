import 'package:flutter/material.dart';
import 'package:flutter_application_1/questions_screen/questionnaire_classe5_data.dart';
import 'package:flutter_application_1/questions_screen/questionnaire_classe6.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuestionnaireClasse5(),
    );
  }
}

class QuestionnaireClasse5 extends StatefulWidget {
  const QuestionnaireClasse5({super.key});

  @override
  _QuestionnaireClasse5State createState() => _QuestionnaireClasse5State();
}

class _QuestionnaireClasse5State extends State<QuestionnaireClasse5> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _maladiesChroniquesController = TextEditingController();
  final TextEditingController _apneeSommeilController = TextEditingController();
  final TextEditingController _utiliseCPAPController = TextEditingController();
  final TextEditingController _difficultesActivitesQuotidiennesController = TextEditingController();
  final TextEditingController _changementPoidsController = TextEditingController();
  final TextEditingController _compulsionsAlimentairesController = TextEditingController();
  final TextEditingController _regimeRestrictifController = TextEditingController();
  final TextEditingController _difficulteControlePortionsController = TextEditingController();
  final TextEditingController _consommationBoissonsController = TextEditingController();

  QuestionnaireClasse5Data get questionnaireData => QuestionnaireClasse5Data(
    maladiesChroniques: _maladiesChroniquesController.text,
    apneeSommeil: _apneeSommeilController.text,
    utiliseCPAP: _utiliseCPAPController.text,
    difficultesActivitesQuotidiennes: _difficultesActivitesQuotidiennesController.text,
    changementPoids: _changementPoidsController.text,
    compulsionsAlimentaires: _compulsionsAlimentairesController.text,
    regimeRestrictif: _regimeRestrictifController.text,
    difficulteControlePortions: _difficulteControlePortionsController.text,
    consommationBoissons: _consommationBoissonsController.text,
);

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Questionnaire pour obésité morbide'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Veuillez répondre aux questions suivantes : ',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),
                    const SizedBox(height: 16.0),
                    const Text(
                      'État de santé général :',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),

                    const Text(
                      'Avez-vous été diagnostiqué avec des maladies chroniques graves liées à votre poids, comme l\'insuffisance cardiaque, les maladies rénales, ou des troubles respiratoires graves ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _maladiesChroniquesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous l’apnée du sommeil ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _apneeSommeilController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Utilisez-vous un appareil CPAP (Continuous Positive Airway Pressure) pour l\'apnée du sommeil ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _utiliseCPAPController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous des difficultés à effectuer des activités quotidiennes de base en raison de votre poids ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _difficultesActivitesQuotidiennesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous récemment perdu ou pris du poids ? Si oui, combien et en combien de temps ? Pourquoi ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _changementPoidsController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Changement de poids',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Habitudes alimentaires et troubles alimentaires :',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),

                    const Text(
                      'Avez-vous des épisodes de compulsions alimentaires ou de boulimie ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _compulsionsAlimentairesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Suivez-vous un régime alimentaire extrêmement restrictif ou avez-vous suivi des régimes yo-yo dans le passé ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _regimeRestrictifController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous des difficultés à contrôler les portions ou à manger de manière équilibrée ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _difficulteControlePortionsController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Buvez-vous régulièrement des boissons sucrées ou alcoolisées ? Quand ? Quelle quantité ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _consommationBoissonsController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_maladiesChroniquesController.text.isEmpty ||
                        _apneeSommeilController.text.isEmpty ||
                        _utiliseCPAPController.text.isEmpty ||
                        _difficultesActivitesQuotidiennesController.text.isEmpty ||
                        _changementPoidsController.text.isEmpty ||
                        _compulsionsAlimentairesController.text.isEmpty ||
                        _regimeRestrictifController.text.isEmpty ||
                        _difficulteControlePortionsController.text.isEmpty ||
                        _consommationBoissonsController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: const Text(
                                'Veuillez vérifier que vous avez répondu à toutes vos questions !',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionnaireClasse6(
                            questionnaireData5: questionnaireData,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 18.0),
                    textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Continuer'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
