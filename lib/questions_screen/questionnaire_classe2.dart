import 'package:flutter/material.dart';
import '../questions_screen/questionnaire_classe1_data.dart';
import 'questionnaire_data1.dart';




class QuestionnaireClasse2 extends StatefulWidget {
  const QuestionnaireClasse2({
    super.key,
    required this.questionnaireData1,
  });
  
  final QuestionnaireClasse1Data questionnaireData1;


  @override
  _QuestionnaireClasse2State createState() => _QuestionnaireClasse2State();
}

class _QuestionnaireClasse2State extends State<QuestionnaireClasse2> {
  final _formKey = GlobalKey<FormState>();

  QuestionnaireClasse1Data get donneesClasse1 => widget.questionnaireData1;

  final TextEditingController _activitePhysiqueController = TextEditingController();
  final TextEditingController _tempsAssisController = TextEditingController();
  final TextEditingController _activitesApprecieesController = TextEditingController();
  final TextEditingController _frequenceCardiaqueController = TextEditingController();

  final TextEditingController _comportAlimentaireController = TextEditingController();
  final TextEditingController _finAssietteController = TextEditingController();
  final TextEditingController _regimeSuiviController = TextEditingController();

  final TextEditingController _objectifSanteController = TextEditingController();
  final TextEditingController _poidsPerdreController = TextEditingController();
  final TextEditingController _motivationController = TextEditingController();

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
                      'Activité physique',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),

                    const Text(
                      'Combien de jours par semaine pratiquez-vous une activité physique ? Choisissez entre : aucun, 1j-3j, 4j-6j ou 7j',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _activitePhysiqueController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                        prefixIcon: Icon(Icons.fitness_center),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Combien de temps passez-vous en position assise chaque jour ? Choisissez entre : moins de 4h, 4h-6h, 6h-8h, plus de 8h' ,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _tempsAssisController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse',
                        prefixIcon: Icon(Icons.access_time),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Quelles activités physiques appréciez-vous ? (marche, yoga ou autre)',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _activitesApprecieesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse',
                        prefixIcon: Icon(Icons.directions_walk),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Connaissez-vous votre fréquence cardiaque au repos ? Si oui, veuillez- nous la donner ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _frequenceCardiaqueController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Votre réponse (oui/non)',
                        prefixIcon: Icon(Icons.favorite),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Comportements alimentaires',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),

                    const Text(
                      'Mangez-vous souvent par stress ou par ennui ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _comportAlimentaireController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse ',
                        prefixIcon: Icon(Icons.mood_bad),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous tendance à finir votre assiette même si vous n’avez plus faim ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _finAssietteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse (oui/non)',
                        prefixIcon: Icon(Icons.restaurant),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Avez-vous déjà suivi un régime alimentaire particulier ? Si oui, lequel et a-t-il été efficace pour vous ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _regimeSuiviController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse (oui/non)',
                        prefixIcon: Icon(Icons.dining),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Objectifs de santé',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),

                    const Text(
                      'Quel est votre objectif principal en matière de santé ? Choisissez entre : Perdre du poids, améliorer votre forme physique ou autre ',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _objectifSanteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse',
                        prefixIcon: Icon(Icons.health_and_safety),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Combien de kg souhaitez-vous perdre ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _poidsPerdreController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse en kg',
                        prefixIcon: Icon(Icons.monitor_weight),
                      ),
                    ),
                    const SizedBox(height: 27.0),

                    const Text(
                      'Y a-t-il des événements récents ou à venir qui vous motivent à améliorer votre santé ?',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _motivationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'votre réponse ',
                        prefixIcon: Icon(Icons.event),
                      ),
                    ),
                    const SizedBox(height: 27.0),
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
                              final donnees = QuestionnaireData1(
                                // Utilisation du getter pour accéder aux données de la première classe
                                antecedents: donneesClasse1.antecedents,
                                medicaments: donneesClasse1.medicaments,
                                repasTypique: donneesClasse1.repasTypique,
                                portionsFruitsLegumes: donneesClasse1.portionsFruitsLegumes,
                                grignotage: donneesClasse1.grignotage,
                                frequenceBoissons: donneesClasse1.frequenceBoissons,
                                sommeil: donneesClasse1.sommeil,
                                sommeilApnee: donneesClasse1.sommeilApnee,
                                poidsRecent: donneesClasse1.poidsRecent,
                                
                                // Données de la deuxième classe
                                activitePhysique: _activitePhysiqueController.text,
                                tempsAssis: _tempsAssisController.text,
                                activitesAppreciees: _activitesApprecieesController.text,
                                frequenceCardiaque: _frequenceCardiaqueController.text,
                                comportAlimentaire: _comportAlimentaireController.text,
                                finAssiette: _finAssietteController.text,
                                regimeSuivi: _regimeSuiviController.text,
                                objectifSante: _objectifSanteController.text,
                                poidsPerdu: _poidsPerdreController.text,
                                motivation: _motivationController.text,
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
          ],
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
