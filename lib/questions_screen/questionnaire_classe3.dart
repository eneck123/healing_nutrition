import 'package:flutter/material.dart';
import '../questions_screen/questionnaire_classe4.dart';
import 'package:flutter_application_1/questions_screen/questionnaire_classe3_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuestionnaireClasse3(),
    );
  }
}


class QuestionnaireClasse3 extends StatefulWidget {
  const QuestionnaireClasse3({super.key});

  @override
  _QuestionnaireClasse3State createState() => _QuestionnaireClasse3State();
}

class _QuestionnaireClasse3State extends State<QuestionnaireClasse3> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _problemesSanteObesiteController = TextEditingController();
  final TextEditingController _operationsChirurgicalesController = TextEditingController();
  final TextEditingController _douleursArticulairesController = TextEditingController();
  final TextEditingController _variationsPoidsController = TextEditingController();
  final TextEditingController _sommeilController = TextEditingController();
   final TextEditingController _sommeilApneeController = TextEditingController();

  final TextEditingController _restrictionsAlimentairesController = TextEditingController();
  final TextEditingController _alimentsRichesCaloriesController = TextEditingController();
  final TextEditingController _planNutritionnelController = TextEditingController();
  final TextEditingController _boissonsSucreesController = TextEditingController();

  QuestionnaireClasse3Data get questionnaireData => QuestionnaireClasse3Data(
    problemesSanteObesite: _problemesSanteObesiteController.text,
    operationsChirurgicales: _operationsChirurgicalesController.text,
    douleursArticulaires: _douleursArticulairesController.text,
    variationsPoids: _variationsPoidsController.text,
    sommeil: _sommeilController.text,
    sommeilApnee: _sommeilApneeController.text,
    restrictionsAlimentaires: _restrictionsAlimentairesController.text,
    alimentsRichesCalories: _alimentsRichesCaloriesController.text,
    planNutritionnel: _planNutritionnelController.text,
    boissonsSucrees: _boissonsSucreesController.text,
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
        title: const Text('Questionnaire pour obésité sévère'),
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
                      'Antécédents médicaux et comorbidités ',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),

                    const Text(
                      'Avez-vous été diagnostiqué avec des problèmes de santé liés à l\'obésité, comme le diabète de type 2, l\'hypertension ou l\'hypercholestérolémie ? Si oui, lesquels ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _problemesSanteObesiteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse (oui/non) ',
                        prefixIcon: Icon(Icons.local_hospital),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous subi des opérations chirurgicales liées à votre poids comme une chirurgie bariatrique ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _operationsChirurgicalesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse (oui/non)',
                       //prefixIcon: Icon(Icons.surgical),
                      ),
                    ),
                    const SizedBox(height: 27.0),


                    const Text(
                      'Habitudes alimentaires',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),

                    const Text(
                      'Avez-vous des restrictions alimentaires ? Si oui, choisissez le(s) option(s) qui s\'appliquent : allergies, intolérances, préférences culturelles ou religieuses ' ,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _restrictionsAlimentairesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse(oui/non)',
                        prefixIcon: Icon(Icons.no_food),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Consommez-vous régulièrement des aliments riches en calories vides, comme les boissons sucrées, les fast-foods, ou les desserts ? ',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _alimentsRichesCaloriesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse',
                        prefixIcon: Icon(Icons.fastfood),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Suivez-vous déjà un plan nutritionnel ou avez-vous consulté un diététicien auparavant ? si oui, parlez-nous de ça brièvement en quelques lignes ' ,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _planNutritionnelController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse',
                        prefixIcon: Icon(Icons.menu_book),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Buvez-vous régulièrement des boissons sucrées ou alcoolisées ? Si oui, quand ? Quelle quantité ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _boissonsSucreesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse(oui/non)',
                        prefixIcon: Icon(Icons.local_bar),
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
                        labelText: 'votre réponse ',
                        prefixIcon: Icon(Icons.bedtime),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous des douleurs articulaires ou des limitations de mobilité ? Si oui, A quelle fréquence ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _douleursArticulairesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse (oui/non)',
                        prefixIcon: Icon(Icons.accessibility),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous récemment fait un régime de perte de poids ? Si oui, combien de poids avez-vous perdu ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _variationsPoidsController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse',
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
                    if (_problemesSanteObesiteController.text.isEmpty ||
                        _sommeilController.text.isEmpty ||
                        _sommeilApneeController.text.isEmpty ||
                        _operationsChirurgicalesController.text.isEmpty ||
                        _restrictionsAlimentairesController.text.isEmpty ||
                        _alimentsRichesCaloriesController.text.isEmpty ||
                        _planNutritionnelController.text.isEmpty ||
                        _douleursArticulairesController.text.isEmpty ||
                        _variationsPoidsController.text.isEmpty ||
                        _boissonsSucreesController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: const Text(
                                'Veuillez vérifier que vous avez répondu à toutes les questions !',
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
                          builder: (context) => QuestionnaireClasse4(
                            questionnaireData3: questionnaireData,
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
