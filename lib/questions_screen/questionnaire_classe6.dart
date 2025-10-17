import 'package:flutter/material.dart';
import '../questions_screen/questionnaire_classe5_data.dart';
import 'questionnaire_data5.dart';

class QuestionnaireClasse6 extends StatefulWidget {
  const QuestionnaireClasse6({super.key, required this.questionnaireData5,});

  final QuestionnaireClasse5Data questionnaireData5;

  @override
  _QuestionnaireClasse6State createState() => _QuestionnaireClasse6State();
}

class _QuestionnaireClasse6State extends State<QuestionnaireClasse6> {
  final _formKey = GlobalKey<FormState>();

   QuestionnaireClasse5Data get donneesClasse5 => widget.questionnaireData5;

  final TextEditingController _activitePhysiqueController = TextEditingController();
  final TextEditingController _mobiliteController = TextEditingController();
  final TextEditingController _equipementSpecialiseController = TextEditingController();
  final TextEditingController _frequenceCardiaqueController = TextEditingController();
  final TextEditingController _gestionCritiquesController = TextEditingController();
  final TextEditingController _objectifsSanteController = TextEditingController();
  final TextEditingController _motivationChangementController = TextEditingController();
  final TextEditingController _participationController = TextEditingController();
  final TextEditingController _suiviController = TextEditingController();
  final TextEditingController _chirugieBariatriqueController = TextEditingController();

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
                                  // Nouvelles questions sur l'activité physique et la mobilité
                    const Text(
                      'Activité physique et mobilité :',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),

                    const Text(
                      'Votre poids vous empêche-t-il de pratiquer certaines activités physiques ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _activitePhysiqueController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Quelle est votre capacité à vous déplacer de manière autonome (marche, escaliers, etc.) ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _mobiliteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous besoin d\'un équipement spécialisé pour vous aider à bouger ou à vous asseoir confortablement ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _equipementSpecialiseController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous des problèmes de rythme cardiaque pendant l\'effort physique ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _frequenceCardiaqueController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                      ),
                    ),
                    const SizedBox(height: 27.0),

              const Text(
                'Support psychologique et comportemental :',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24.0),

              const Text(
                'Comment gérez-vous les critiques ou le stigma lié à votre poids ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _gestionCritiquesController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Votre réponse',
                ),
              ),
              const SizedBox(height: 24.0),

              const Text(
                '•	Avez-vous un suivi psychologique ou psychiatrique en lien avec votre poids ou votre alimentation ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _suiviController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Votre réponse',
                ),
              ),
              const SizedBox(height: 24.0),

               const Text(
                'Avez-vous déjà participé à des groupes de soutien pour la perte de poids ou \'obésité ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _participationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Votre réponse',
                ),
              ),
              const SizedBox(height: 24.0),

              const Text(
                'Options de traitement et objectifs :',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24.0),

              const Text(
                'Avez-vous envisagé une chirurgie bariatrique ou d\'autres interventions médicales pour gérer votre poids ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _chirugieBariatriqueController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Votre réponse',
                ),
              ),
              const SizedBox(height: 24.0),

              const Text(
                'Quels sont vos objectifs de santé immédiats et à long terme ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _objectifsSanteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Votre réponse',
                ),
              ),
              const SizedBox(height: 24.0),

              const Text(
                'Quels aspects de votre vie vous motivent le plus pour changer vos habitudes alimentaires et physiques ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _motivationChangementController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Votre réponse',
                ),
              ),
              const SizedBox(height: 24.0),
              Center( 
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 18.0),
                    textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        final donnees = QuestionnaireData5(
                          // Utilisation du getter pour accéder aux données de la première classe
                          maladiesChroniques: donneesClasse5.maladiesChroniques,
                          apneeSommeil: donneesClasse5.apneeSommeil,
                          utiliseCPAP: donneesClasse5.utiliseCPAP,
                          difficultesActivitesQuotidiennes: donneesClasse5.difficultesActivitesQuotidiennes,
                          changementPoids: donneesClasse5.changementPoids,
                          compulsionsAlimentaires: donneesClasse5.compulsionsAlimentaires,
                          regimeRestrictif: donneesClasse5.regimeRestrictif,
                          difficulteControlePortions: donneesClasse5.difficulteControlePortions,
                          consommationBoissons: donneesClasse5.consommationBoissons,
                          
                          // Données de la deuxième classe
                          mobilite: _mobiliteController.text,
                          activitePhysique: _activitePhysiqueController.text,
                          equipementSpecialise: _equipementSpecialiseController.text,
                          frequenceCardiaque: _frequenceCardiaqueController.text,
                          gestionCritiques: _gestionCritiquesController.text,
                          objectifsSante: _objectifsSanteController.text,
                          motivationChangement: _motivationChangementController.text,
                          participation : _participationController.text,
                          suivi: _suiviController.text,
                          chirugieBariatrique :_chirugieBariatriqueController.text,
                        );

                        await donnees.envoyerDonnees();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Questionnaire terminé. Merci pour vos réponses!')),
                        );

                        Future.delayed(const Duration(seconds: 5), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ScreenAfterQuestionnaire()),
                          );
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erreur lors de l\'envoi des données: $e')),
                        );
                      }
                    } else {
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
                    }
                  },
                  child: const Text('questionnaire terminé'),
                ),
              ),  
            ],
          ),
        ),
      ),
    );
  }
}

// Nouvel écran après la redirection
class ScreenAfterQuestionnaire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Écran après le questionnaire'),
      ),
      body: const Center(
        child: Text(
          'Merci d’avoir complété le questionnaire!',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}