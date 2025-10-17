import 'package:flutter/material.dart';
import '../questions_screen/questionnaire_classe3_data.dart';
import 'questionnaire_data3.dart';



class QuestionnaireClasse4 extends StatefulWidget {
 const QuestionnaireClasse4({
    Key? key,
    required this.questionnaireData3,
  }) : super(key: key);
  

  final QuestionnaireClasse3Data questionnaireData3;

  @override
  _QuestionnaireClasse4State createState() => _QuestionnaireClasse4State();
}

class _QuestionnaireClasse4State extends State<QuestionnaireClasse4> {
  final _formKey = GlobalKey<FormState>();

    QuestionnaireClasse3Data get donneesClasse3 => widget.questionnaireData3;

  final TextEditingController _capaciteExerciceController = TextEditingController();
  final TextEditingController _activitesApprecieesController = TextEditingController();
  final TextEditingController _programExerciceController = TextEditingController();
  final TextEditingController _frequenceCardiaqueController = TextEditingController();
  final TextEditingController _sentimentsEmotionnelsController = TextEditingController();
  final TextEditingController _habitudesAlimentairesController = TextEditingController();
  final TextEditingController _essaisPertePoidsController = TextEditingController();
  final TextEditingController _objectifsSanteController = TextEditingController();
  final TextEditingController _reseauSoutienController = TextEditingController();
  final TextEditingController _motivationPertePoidsController = TextEditingController();

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              const Text(
                'Activité physique et mobilité :',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24.0),
              
              const Text(
                'Combien de jours par semaine pratiquez-vous une activité physique d’au moins 30 minutes ? Choisissez entre : aucun, 1j-3j, 4j-6j ou 7j',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _capaciteExerciceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'votre réponse',
                  prefixIcon: Icon(Icons.fitness_center),
                ),
              ),
              const SizedBox(height: 27.0),
              
              const Text(
                'Pratiquez-vous des activités de loisirs qui incluent de l\'activité physique, comme la marche, la natation ou le jardinage ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _activitesApprecieesController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'votre réponse',
                ),
              ),
              const SizedBox(height: 27.0),
              
              const Text(
                'Avez-vous envisagé de commencer un programme d\'exercices encadré par un professionnel ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _programExerciceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'votre réponse',
                ),
              ),
              const SizedBox(height: 27.0),
              
              const Text(
                'Quelle est votre fréquence cardiaque au repos (si vous la connaissez) ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _frequenceCardiaqueController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'votre réponse',
                ),
              ),
              const SizedBox(height: 27.0),

              const Text(
                'Comportements alimentaires et émotions :',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24.0),

              const Text(
                'Comment vous sentez-vous émotionnellement en ce qui concerne votre poids ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _sentimentsEmotionnelsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'votre réponse',
                ),
              ),
              const SizedBox(height: 27.0),

              const Text(
                'Avez-vous des habitudes alimentaires liées à des émotions, comme le stress ou la dépression ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _habitudesAlimentairesController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'votre réponse',
                ),
              ),
              const SizedBox(height: 27.0),

              const Text(
                'Avez-vous essayé de perdre du poids dans le passé ? Si oui, qu\'est-ce qui a fonctionné ou n\'a pas fonctionné pour vous ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _essaisPertePoidsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'votre réponse',
                ),
              ),
              const SizedBox(height: 27.0),

              const Text(
                'Objectifs de santé et attentes :',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24.0),

              const Text(
                'Quels sont vos objectifs à court et à long terme pour votre poids et votre santé ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _objectifsSanteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'votre réponse',
                ),
              ),
              const SizedBox(height: 27.0),

              const Text(
                'Avez-vous un réseau de soutien (famille, amis) pour vous aider dans votre parcours de perte de poids ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _reseauSoutienController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'votre réponse',
                ),
              ),
              const SizedBox(height: 27.0),

              const Text(
                'Quelle est votre motivation principale pour perdre du poids ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _motivationPertePoidsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'votre réponse',
                ),
              ),
              const SizedBox(height: 100.0),
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
                        final donnees = QuestionnaireData3(
                          // Utilisation du getter pour accéder aux données de la première classe
                          problemesSanteObesite: donneesClasse3.problemesSanteObesite,
                          operationsChirurgicales: donneesClasse3.operationsChirurgicales,
                          douleursArticulaires: donneesClasse3.douleursArticulaires,
                          variationsPoids: donneesClasse3.variationsPoids,
                          sommeil: donneesClasse3.sommeil,
                          sommeilApnee: donneesClasse3.sommeilApnee,
                          restrictionsAlimentaires: donneesClasse3.restrictionsAlimentaires,
                          alimentsRichesCalories: donneesClasse3.alimentsRichesCalories,
                          planNutritionnel: donneesClasse3.planNutritionnel,
                          boissonsSucrees: donneesClasse3.boissonsSucrees,
                          
                          // Données de la deuxième classe
                          activitePhysique: _capaciteExerciceController.text,
                          activitesAppreciees: _activitesApprecieesController.text,
                          programExercice: _programExerciceController.text,
                          comportAlimentaire: _habitudesAlimentairesController.text,
                          sentimentsEmotionnels: _sentimentsEmotionnelsController.text,
                          essaisPertePoids: _essaisPertePoidsController.text,
                          objectifSante: _objectifsSanteController.text,
                          poidsPerdu: _reseauSoutienController.text,
                          motivation: _motivationPertePoidsController.text,
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
              const SizedBox(height: 80.0),
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
