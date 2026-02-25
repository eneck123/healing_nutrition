import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/healing_app_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ─────────────────────────────────────────────
// Page d'accueil – Sélection du type d'obésité
// ─────────────────────────────────────────────

class AccueilMobile extends StatefulWidget {
  const AccueilMobile({super.key});

  @override
  _AccueilMobileState createState() => _AccueilMobileState();
}

class _AccueilMobileState extends State<AccueilMobile> {
  String? _selectedObesityType;
  String? _token;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  // ── Récupération du token stocké localement ──
  Future<void> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('auth_token');
    if (storedToken != null) {
      setState(() => _token = storedToken);
    } else {
      debugPrint('Aucun token trouvé');
    }
  }

  // ── Affichage d'un SnackBar coloré ──
  void _showSnackBar(String message, {required Color color}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // ÉTAPE 1 : POST – Associer le type d'obésité à l'utilisateur
  // ────────────────────────────────────────────────────────────
  Future<void> _handleObesityChoice() async {
    if (_selectedObesityType == null) return;

    setState(() => _isLoading = true);

    final authService = AuthenticationService();

    // ── POST : envoi du type d'obésité ──
    final obesityResult = await authService.sendObesityChoice(
      _selectedObesityType!,
      token: _token,
    );

    if (obesityResult['success'] != true) {
      _showSnackBar(
        obesityResult['message'] ?? 'Erreur lors de l\'envoi du type d\'obésité.',
        color: Colors.red,
      );
      setState(() => _isLoading = false);
      return;
    }

    _showSnackBar(
      obesityResult['message'] ?? 'Type d\'obésité enregistré avec succès !',
      color: Colors.green,
    );

    // ────────────────────────────────────────────────────────────
    // ÉTAPE 2 : GET – Récupérer les questions liées au type choisi
    // ────────────────────────────────────────────────────────────
    final questionsResult = await authService.fetchQuestions(
      _selectedObesityType!,
      token: _token,
    );

    setState(() => _isLoading = false);

    if (questionsResult['success'] != true ||
        questionsResult['questions'] == null) {
      _showSnackBar(
        questionsResult['message'] ?? 'Impossible de charger les questions.',
        color: Colors.red,
      );
      return;
    }

    _showSnackBar(
      questionsResult['message'] ?? 'Questions chargées avec succès !',
      color: Colors.green,
    );

    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => QuestionnaireDynamiquePage(
          obesityType: _selectedObesityType!,
          questions: List<Map<String, dynamic>>.from(
              questionsResult['questions']),
          token: _token,
        ),
      ),
    );
  }

  // ── UI : option de sélection d'un type d'obésité ──
  Widget _buildObesityTypeOption(String type, String explanation) {
    final bool isSelected = _selectedObesityType == type;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() {
              _selectedObesityType = isSelected ? null : type;
            }),
            child: Row(
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
                  child: Text(
                    type,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 4),
            child: Text(
              explanation,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
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
          'Connue grâce à un Indice de Masse Corporelle (IMC) entre 30 et 34,9 kg/m².',
        ),
        const SizedBox(height: 30),
        _buildObesityTypeOption(
          'obésité sévère',
          'Connue grâce à un Indice de Masse Corporelle (IMC) entre 35 et 39,9 kg/m².',
        ),
        const SizedBox(height: 30),
        _buildObesityTypeOption(
          'obésité morbide',
          'Connue grâce à un Indice de Masse Corporelle (IMC) de 40 kg/m² ou plus.',
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: (_selectedObesityType != null && !_isLoading)
              ? _handleObesityChoice
              : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: (_selectedObesityType != null && !_isLoading)
                ? Colors.green
                : Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                )
              : const Text('Continuer', style: TextStyle(fontSize: 16)),
        ),
      ],
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
                  MaterialPageRoute(
                      builder: (_) => const HealingAppScreen()),
                );
              }
            },
            itemBuilder: (_) => [
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
          padding: const EdgeInsets.all(16),
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
    );
  }
}

// ─────────────────────────────────────────────
// Page dynamique – Questionnaire
// ─────────────────────────────────────────────

class QuestionnaireDynamiquePage extends StatefulWidget {
  final String obesityType;
  final List<Map<String, dynamic>> questions;
  final String? token;

  const QuestionnaireDynamiquePage({
    super.key,
    required this.obesityType,
    required this.questions,
    this.token,
  });

  @override
  State<QuestionnaireDynamiquePage> createState() =>
      _QuestionnaireDynamiquePageState();
}

class _QuestionnaireDynamiquePageState
    extends State<QuestionnaireDynamiquePage> {
  final Map<int, String> _answers = {};
  bool _isSubmitting = false;
  bool _isFetchingAnswers = false;

  // ── Affichage d'un SnackBar coloré ──
  void _showSnackBar(String message,
      {required Color color,
      Duration duration = const Duration(seconds: 3)}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: duration,
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // ÉTAPE 3 : POST – Enregistrer UNE réponse individuelle
  // ────────────────────────────────────────────────────────────
  Future<void> _postSingleAnswer(int index, String answer) async {
    final authService = AuthenticationService();
    final question = widget.questions[index];

    final result = await authService.postAnswer(
      questionId: question['id'],
      answer: answer,
      token: widget.token,
    );

    if (result['success'] == true) {
      debugPrint('Réponse Q${index + 1} enregistrée : ${result['message']}');
    } else {
      _showSnackBar(
        result['message'] ?? 'Réponse ${index + 1} non sauvegardée.',
        color: Colors.orange,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // ────────────────────────────────────────────────────────────
  // ÉTAPE 4 : GET – Récupérer toutes les réponses enregistrées
  // ────────────────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>?> _fetchAllAnswers() async {
    setState(() => _isFetchingAnswers = true);

    final authService = AuthenticationService();
    final result = await authService.fetchAnswers(token: widget.token);

    setState(() => _isFetchingAnswers = false);

    if (result['success'] == true) {
      final answers =
          List<Map<String, dynamic>>.from(result['answers'] ?? []);
      debugPrint(
          '${answers.length} réponse(s) récupérée(s) : ${result['message']}');
      return answers;
    } else {
      _showSnackBar(
        result['message'] ?? 'Impossible de récupérer les réponses.',
        color: Colors.red,
      );
      return null;
    }
  }

  // ────────────────────────────────────────────────────────────
  // Soumission finale : GET les réponses puis POST au backend
  // ────────────────────────────────────────────────────────────
  Future<void> _submitAnswers() async {
    if (_answers.length < widget.questions.length) {
      _showSnackBar(
        'Veuillez répondre à toutes les questions avant de soumettre.',
        color: Colors.orange,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // GET : récupération des réponses sauvegardées
      final fetchedAnswers = await _fetchAllAnswers();

      if (fetchedAnswers == null) {
        setState(() => _isSubmitting = false);
        return;
      }

      _showSnackBar(
        '${fetchedAnswers.length} réponse(s) récupérée(s), envoi en cours…',
        color: Colors.blue,
        duration: const Duration(seconds: 2),
      );

      // POST final : soumission au backend
      final authService = AuthenticationService();
      final result = await authService.submitAnswers(
        answers: fetchedAnswers,
        token: widget.token,
      );

      setState(() => _isSubmitting = false);

      if (result['success'] == true) {
        _showSnackBar(
          result['message'] ?? 'Réponses envoyées avec succès !',
          color: Colors.green,
        );
        // TODO : naviguer vers la prochaine étape
      } else {
        _showSnackBar(
          result['message'] ?? 'Erreur lors de l\'envoi des réponses.',
          color: Colors.red,
        );
      }
    } catch (e) {
      setState(() => _isSubmitting = false);
      debugPrint('Exception _submitAnswers: $e');
      _showSnackBar(
        'Erreur réseau. Vérifiez votre connexion et réessayez.',
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'healingnutrition',
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'Daughter of Fortune',
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Questionnaire – ${widget.obesityType}',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // ── Liste des questions ──
              ...widget.questions.asMap().entries.map((entry) {
                final index = entry.key;
                final question = entry.value;
                final questionText =
                    question['question'] as String? ?? 'Question ${index + 1}';
                final options =
                    List<String>.from(question['options'] ?? []);

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. $questionText',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),

                        // Choix multiples
                        if (options.isNotEmpty)
                          ...options.map((option) => RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: _answers[index],
                                activeColor: Colors.green,
                                onChanged: (value) {
                                  setState(() => _answers[index] = value!);
                                  _postSingleAnswer(index, value!);
                                },
                              ))
                        // Réponse libre
                        else
                          TextField(
                            decoration: const InputDecoration(
                              hintText: 'Votre réponse…',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                            onChanged: (value) =>
                                setState(() => _answers[index] = value),
                            onEditingComplete: () {
                              final ans = _answers[index];
                              if (ans != null && ans.isNotEmpty) {
                                _postSingleAnswer(index, ans);
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 12),

              // Indicateur de récupération
              if (_isFetchingAnswers)
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.blue),
                      ),
                      SizedBox(width: 8),
                      Text('Récupération des réponses…',
                          style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),

              ElevatedButton(
                onPressed: (_isSubmitting || _isFetchingAnswers)
                    ? null
                    : _submitAnswers,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: (_isSubmitting || _isFetchingAnswers)
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Soumettre mes réponses',
                        style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Service d'authentification & API
// ─────────────────────────────────────────────

class AuthenticationService {

  // ── Headers communs avec token Bearer ──
  Map<String, String> _headers(String? token) => {
        'Authorization': 'Bearer ${token ?? ''}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };

  // ════════════════════════════════════════════════════════════════════════
  // MÉTHODE 1 – POST
  // Associer le type d'obésité sélectionné à l'utilisateur connecté
  //
  // URL : https://healing-nutrition-plan.pixeluxt.com/api/obesity/assign-type
  //
  // Body envoyé :
  //   {
  //     "type_maladie_chronique": "obésité modérée" | "obésité sévère" | "obésité morbide"
  //   }
  // ════════════════════════════════════════════════════════════════════════
  Future<Map<String, dynamic>> sendObesityChoice(
    String obesityType, {
    String? token,
  }) async {
    // ✦ URL de l'endpoint
    const String url =
        'https://healing-nutrition-plan.pixeluxt.com/api/user-infos/maladie-chronique';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _headers(token),
        body: jsonEncode({'type_maladie_chronique': obesityType}),
      );

      debugPrint('[POST sendObesityChoice] $url');
      debugPrint('Status : ${response.statusCode} | Body : ${response.body}');

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // ✅ Succès
        return {
          'success': true,
          'message': decoded['message'] ??
              'Type d\'obésité enregistré avec succès !',
          'data': decoded['data'],
        };
      } else {
        // ❌ Erreur serveur
        return {
          'success': false,
          'message': decoded['message'] ??
              'Erreur ${response.statusCode} : impossible d\'enregistrer le type d\'obésité.',
        };
      }
    } catch (e) {
      debugPrint('[POST sendObesityChoice] Exception : $e');
      return {
        'success': false,
        'message': 'Erreur réseau. Veuillez vérifier votre connexion.',
      };
    }
  }

  // ════════════════════════════════════════════════════════════════════════
  // MÉTHODE 2 – GET
  // Récupérer la liste des questions liées au type d'obésité de l'utilisateur
  //
  // URL : https://healing-nutrition-plan.pixeluxt.com/api/questions/by-type?type=<obesityType>
  //
  // Paramètre query :
  //   type = "obésité modérée" | "obésité sévère" | "obésité morbide" (encodé URI)
  // ════════════════════════════════════════════════════════════════════════
  Future<Map<String, dynamic>> fetchQuestions(
    String obesityType, {
    String? token,
  }) async {
    // ✦ URL de l'endpoint (paramètre type encodé dynamiquement)
    final String url =
        'https://healing-nutrition-plan.pixeluxt.com/api/user-infos/get-user-questions?type=${Uri.encodeComponent(obesityType)}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _headers(token),
      );

      debugPrint('[GET fetchQuestions] $url');
      debugPrint('Status : ${response.statusCode} | Body : ${response.body}');

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // ✅ Succès
        return {
          'success': true,
          'message': decoded['message'] ?? 'Questions chargées avec succès !',
          'questions': decoded['data'] ?? decoded['questions'] ?? [],
        };
      } else {
        // ❌ Erreur serveur
        return {
          'success': false,
          'message': decoded['message'] ??
              'Erreur ${response.statusCode} : impossible de récupérer les questions.',
        };
      }
    } catch (e) {
      debugPrint('[GET fetchQuestions] Exception : $e');
      return {
        'success': false,
        'message': 'Erreur réseau. Veuillez vérifier votre connexion.',
      };
    }
  }

  // ════════════════════════════════════════════════════════════════════════
  // MÉTHODE 3 – POST
  // Enregistrer la réponse de l'utilisateur à une question
  // (fonctionne pour les questions à choix multiples ET les questions ouvertes)
  //
  // URL : https://healing-nutrition-plan.pixeluxt.com/api/answers/store
  //
  // Body envoyé :
  //   {
  //     "question_id": 1,
  //     "answer": "Réponse choisie ou saisie"
  //   }
  // ════════════════════════════════════════════════════════════════════════
  Future<Map<String, dynamic>> postAnswer({
    required dynamic questionId,
    required String answer,
    String? token,
  }) async {
    // ✦ URL de l'endpoint
    const String url =
        'https://healing-nutrition-plan.pixeluxt.com/api/user-infos/set-user-answer';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _headers(token),
        body: jsonEncode({
          'question_id': questionId,
          'answer': answer,
        }),
      );

      debugPrint('[POST postAnswer] $url');
      debugPrint('Status : ${response.statusCode} | Body : ${response.body}');

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // ✅ Succès
        return {
          'success': true,
          'message': decoded['message'] ?? 'Réponse enregistrée avec succès !',
          'data': decoded['data'],
        };
      } else {
        // ❌ Erreur serveur
        return {
          'success': false,
          'message': decoded['message'] ??
              'Erreur ${response.statusCode} : impossible d\'enregistrer la réponse.',
        };
      }
    } catch (e) {
      debugPrint('[POST postAnswer] Exception : $e');
      return {
        'success': false,
        'message': 'Erreur réseau. Veuillez vérifier votre connexion.',
      };
    }
  }

  // ════════════════════════════════════════════════════════════════════════
  // MÉTHODE 4 – GET
  // Récupérer la liste complète des réponses enregistrées par l'utilisateur
  // Ces réponses sont ensuite transmises à submitAnswers pour soumission finale
  //
  // URL : https://healing-nutrition-plan.pixeluxt.com/api/answers/user-list
  // ════════════════════════════════════════════════════════════════════════
  Future<Map<String, dynamic>> fetchAnswers({String? token}) async {
    // ✦ URL de l'endpoint
    const String url =
        'https://healing-nutrition-plan.pixeluxt.com/api/user-infos/get-user-answers';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _headers(token),
      );

      debugPrint('[GET fetchAnswers] $url');
      debugPrint('Status : ${response.statusCode} | Body : ${response.body}');

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // ✅ Succès
        return {
          'success': true,
          'message': decoded['message'] ?? 'Réponses récupérées avec succès !',
          'answers': decoded['data'] ?? decoded['answers'] ?? [],
        };
      } else {
        // ❌ Erreur serveur
        return {
          'success': false,
          'message': decoded['message'] ??
              'Erreur ${response.statusCode} : impossible de récupérer les réponses.',
        };
      }
    } catch (e) {
      debugPrint('[GET fetchAnswers] Exception : $e');
      return {
        'success': false,
        'message': 'Erreur réseau. Veuillez vérifier votre connexion.',
      };
    }
  }

  // ════════════════════════════════════════════════════════════════════════
  // MÉTHODE 5 – POST (soumission finale)
  // Envoyer la liste complète des réponses récupérées au backend
  //
  // URL : https://healing-nutrition-plan.pixeluxt.com/api/answers/submit
  //
  // Body envoyé :
  //   {
  //     "answers": [ { "question_id": 1, "answer": "..." }, ... ]
  //   }
  // ════════════════════════════════════════════════════════════════════════
  Future<Map<String, dynamic>> submitAnswers({
    required List<Map<String, dynamic>> answers,
    String? token,
  }) async {
    // ✦ URL de l'endpoint
    const String url =
        'https://healing-nutrition-plan.pixeluxt.com/api/answers/submit';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _headers(token),
        body: jsonEncode({'answers': answers}),
      );

      debugPrint('[POST submitAnswers] $url');
      debugPrint('Status : ${response.statusCode} | Body : ${response.body}');

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // ✅ Succès
        return {
          'success': true,
          'message': decoded['message'] ?? 'Réponses envoyées avec succès !',
          'data': decoded['data'],
        };
      } else {
        // ❌ Erreur serveur
        return {
          'success': false,
          'message': decoded['message'] ??
              'Erreur ${response.statusCode} : impossible d\'envoyer les réponses.',
        };
      }
    } catch (e) {
      debugPrint('[POST submitAnswers] Exception : $e');
      return {
        'success': false,
        'message': 'Erreur réseau. Veuillez vérifier votre connexion.',
      };
    }
  }
}