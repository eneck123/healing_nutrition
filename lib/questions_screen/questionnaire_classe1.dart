import 'package:flutter/material.dart';
import 'package:flutter_application_1/questions_screen/questionnaire_classe1_data.dart';
import 'package:flutter_application_1/questions_screen/questionnaire_classe2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuestionnaireClasse1(),
    );
  }
}

class QuestionnaireClasse1 extends StatefulWidget {
  const QuestionnaireClasse1({super.key});

  @override
  _QuestionnaireClasse1State createState() => _QuestionnaireClasse1State();
  
}

class _QuestionnaireClasse1State extends State<QuestionnaireClasse1> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _antecedentsController = TextEditingController();
  final TextEditingController _medicamentsController = TextEditingController();
  final TextEditingController _repasTypiqueController = TextEditingController();
  final TextEditingController _portionsFruitsLegumesController = TextEditingController();
  final TextEditingController _grignotageController = TextEditingController();
  final TextEditingController _frequenceBoissonsController = TextEditingController();
  final TextEditingController _sommeilController = TextEditingController();
  final TextEditingController _sommeilApneeController = TextEditingController();
  final TextEditingController _poidsRecentController = TextEditingController();

  QuestionnaireClasse1Data get questionnaireData => QuestionnaireClasse1Data(
    antecedents: _antecedentsController.text,
    medicaments: _medicamentsController.text,
    repasTypique: _repasTypiqueController.text,
    portionsFruitsLegumes: _portionsFruitsLegumesController.text,
    grignotage: _grignotageController.text,
    frequenceBoissons: _frequenceBoissonsController.text,
    sommeil: _sommeilController.text,
    sommeilApnee :  _sommeilApneeController.text,
    poidsRecent: _poidsRecentController.text,
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
        title: const Text('Questionnaire pour obésité modérée'),
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
                     const SizedBox(height: 16.0),
                    const Text(
                      'Veuillez répondre aux questions suivantes : ',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),

                    const SizedBox(height: 16.0),
                    const Text(
                      ' Antécédents médicaux',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),

                    const Text(
                      'Avez-vous des antécédents de diabète, d\'hypertension, de maladies cardiovasculaires et autres ? Si oui, lesquels ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _antecedentsController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse (oui/non)',
                        prefixIcon: Icon(Icons.medical_services),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Prenez-vous des médicaments actuellement qui sont liés à vos antécédents précédents ? Si oui, lesquels et Pourquoi ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _medicamentsController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse (oui/non)',
                        prefixIcon: Icon(Icons.medication),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Habitudes alimentaires',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),

                    const Text(
                      'Décrivez une journée typique de vos repas et collations.',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _repasTypiqueController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse',
                        prefixIcon: Icon(Icons.restaurant),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Combien de portions de fruits et légumes consommez-vous par jour ? Choisissez entre : 1-2, 3-4, 5 ou plus' ,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _portionsFruitsLegumesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse',
                        prefixIcon: Icon(Icons.eco),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Grignotez-vous entre les repas ? Si oui, quels types d\'aliments ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _grignotageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse (oui/non)',
                        prefixIcon: Icon(Icons.fastfood),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'A quelle fréquence consommez-vous des boissons sucrées ou alcoolisées ? Choisissez entre : tous les jours, une fois par semaine, occasionnellement ou jamais',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _frequenceBoissonsController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                        prefixIcon: Icon(Icons.local_drink),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Comportements et bien être',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),
                   

                    const Text(
                      'Combien d\'heures de sommeil avez-vous par nuit ? Choississez entre : moins de 6 h, 6h -7h, 8h -9h , plus de 9h',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _sommeilController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse ',
                        prefixIcon: Icon(Icons.bedtime),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous l\'apnée du sommeil ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _sommeilApneeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse (oui/non)',
                        prefixIcon: Icon(Icons.bedtime),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous récemment fait un régime de perte du poids ? Si oui, combien de poids avez-vous perdu ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _poidsRecentController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre répoonse (oui/non)',
                        prefixIcon: Icon(Icons.monitor_weight),
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
                    if (_antecedentsController.text.isEmpty ||
                        _medicamentsController.text.isEmpty ||
                        _repasTypiqueController.text.isEmpty ||
                        _portionsFruitsLegumesController.text.isEmpty ||
                        _grignotageController.text.isEmpty ||
                        _frequenceBoissonsController.text.isEmpty ||
                        _sommeilController.text.isEmpty ||
                        _sommeilApneeController.text.isEmpty ||
                        _poidsRecentController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              padding: const EdgeInsets.all(16.0),
                              constraints: const BoxConstraints(maxWidth: 250), 
                              child: const Text(
                                'Veuillez vérifier que vous avez répondu à toutes les questions !',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0),
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
                          builder: (context) => QuestionnaireClasse2(
                            questionnaireData1: questionnaireData,
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




