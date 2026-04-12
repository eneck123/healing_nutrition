import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/healing_app_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AccueilMobile(),
    );
  }
}

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
  // POST – Associer le type d'obésité à l'utilisateur
  // puis naviguer vers la page d'information e-mail
  // ────────────────────────────────────────────────────────────
  Future<void> _handleObesityChoice() async {
    if (_selectedObesityType == null) return;

    setState(() => _isLoading = true);

    final authService = AuthenticationService();

    final obesityResult = await authService.sendObesityChoice(
      _selectedObesityType!,
      token: _token,
    );

    setState(() => _isLoading = false);

    if (obesityResult['success'] != true) {
      _showSnackBar(
        obesityResult['message'] ?? 'Erreur lors de l\'envoi du type d\'obésité.',
        color: Colors.red,
      );
      return;
    }

    _showSnackBar(
      obesityResult['message'] ?? 'Type d\'obésité enregistré avec succès !',
      color: Colors.green,
    );

    if (!mounted) return;

    // ── Navigation vers la page d'information e-mail ──
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EmailInfoPage(
          obesityType: _selectedObesityType!,
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
// Page d'information – Consulter son e-mail
// ─────────────────────────────────────────────

class EmailInfoPage extends StatefulWidget {
  final String obesityType;
  final String? token;

  const EmailInfoPage({
    super.key,
    required this.obesityType,
    this.token,
  });

  @override
  State<EmailInfoPage> createState() => _EmailInfoPageState();
}

class _EmailInfoPageState extends State<EmailInfoPage> {
  bool _isLoading = false;

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
  // GET – Récupérer les questions puis naviguer vers le questionnaire
  // ────────────────────────────────────────────────────────────
  Future<void> _handleContinue() async {
    setState(() => _isLoading = true);

    final authService = AuthenticationService();

    final questionsResult = await authService.fetchQuestions(
      widget.obesityType,
      token: widget.token,
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
          obesityType: widget.obesityType,
          questions: List<Map<String, dynamic>>.from(
              questionsResult['questions']),
          token: widget.token,
        ),
      ),
    );
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
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Icône e-mail ──
              const Icon(
                Icons.mark_email_unread_outlined,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 32),

              // ── Titre ──
              const Text(
                'Consultez votre boîte e-mail',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // ── Texte informatif ──
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: const Text(
                  'Un e-mail vous a été envoyé avec des informations importantes concernant votre suivi nutritionnel personnalisé.\n\n'
                  'Veuillez consulter votre boîte de réception (et vos spams si nécessaire) avant de continuer.\n\n'
                  'Lorsque vous êtes prêt(e), cliquez sur "Continuer" pour passer au questionnaire.',
                  style: TextStyle(fontSize: 15, height: 1.6),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),

              // ── Bouton Continuer ──
              ElevatedButton(
                onPressed: _isLoading ? null : _handleContinue,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
                    : const Text(
                        'Continuer',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
              const SizedBox(height: 16),

              // ── Bouton retour vers l'inscription ──
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (_) => const HealingAppScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.arrow_back, color: Colors.green),
                label: const Text(
                  'Retour à la page d\'inscription',
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
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
  // Stocke toutes les réponses en mémoire avant soumission
  final Map<int, String> _answers = {};
  // Contrôleurs pour les champs de texte libre
  final Map<int, TextEditingController> _textControllers = {};
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Initialiser un contrôleur pour chaque question ouverte
    for (int i = 0; i < widget.questions.length; i++) {
      final options =
          List<String>.from(widget.questions[i]['options'] ?? []);
      if (options.isEmpty) {
        _textControllers[i] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

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
  // Soumission finale : POST chaque réponse au backend
  // ────────────────────────────────────────────────────────────
  Future<void> _submitAnswers() async {
    // Synchroniser les réponses libres depuis les contrôleurs
    for (final entry in _textControllers.entries) {
      final text = entry.value.text.trim();
      if (text.isNotEmpty) {
        _answers[entry.key] = text;
      }
    }

    // Vérifier que toutes les questions ont une réponse
    if (_answers.length < widget.questions.length) {
      _showSnackBar(
        'Veuillez répondre à toutes les questions avant de soumettre.',
        color: Colors.orange,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final authService = AuthenticationService();
    int successCount = 0;
    bool hasError = false;

    // POST chaque réponse individuellement
    for (int i = 0; i < widget.questions.length; i++) {
      final question = widget.questions[i];
      final answer = _answers[i] ?? '';

      final result = await authService.postAnswer(
        questionId: question['id'],
        answer: answer,
        token: widget.token,
      );

      if (result['success'] == true) {
        successCount++;
      } else {
        hasError = true;
        debugPrint('Erreur réponse Q${i + 1} : ${result['message']}');
      }
    }

    setState(() => _isSubmitting = false);

    if (!hasError) {
      _showSnackBar(
        '$successCount réponse(s) envoyée(s) avec succès !',
        color: Colors.green,
      );
      // TODO : naviguer vers la prochaine étape
    } else {
      _showSnackBar(
        'Certaines réponses n\'ont pas pu être envoyées. Veuillez réessayer.',
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
              const SizedBox(height: 8),
              Text(
                'Répondez à toutes les questions puis cliquez sur "Soumettre".',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Indicateur de complétion de la question
                            Container(
                              margin: const EdgeInsets.only(top: 2, right: 8),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _answers.containsKey(index)
                                    ? Colors.green
                                    : Colors.grey[300],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${index + 1}. $questionText',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Choix multiples
                        if (options.isNotEmpty)
                          ...options.map((option) => RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: _answers[index],
                                activeColor: Colors.green,
                                onChanged: _isSubmitting
                                    ? null
                                    : (value) {
                                        setState(
                                            () => _answers[index] = value!);
                                      },
                              ))
                        // Réponse libre
                        else
                          TextField(
                            controller: _textControllers[index],
                            enabled: !_isSubmitting,
                            decoration: const InputDecoration(
                              hintText: 'Votre réponse…',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green),
                              ),
                            ),
                            onChanged: (value) {
                              // Mise à jour en mémoire uniquement, pas d'envoi réseau
                              setState(() {
                                if (value.trim().isNotEmpty) {
                                  _answers[index] = value.trim();
                                } else {
                                  _answers.remove(index);
                                }
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 8),

              // ── Compteur de progression ──
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  '${_answers.length} / ${widget.questions.length} question(s) répondue(s)',
                  style: TextStyle(
                    fontSize: 14,
                    color: _answers.length == widget.questions.length
                        ? Colors.green
                        : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // ── Bouton Soumettre ──
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitAnswers,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: _isSubmitting
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
  // ════════════════════════════════════════════════════════════════════════
  Future<Map<String, dynamic>> sendObesityChoice(
    String obesityType, {
    String? token,
  }) async {
    const String url =
        'https://healing-nutrition-plan.pixeluxt.com/api/user-infos/maladie-chronique';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _headers(token),
        body: jsonEncode({'type_maladie_chronique': obesityType}),
      );

      debugPrint('[POST sendObesityChoice] Status : ${response.statusCode}');
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'message': decoded['message'] ??
              'Type d\'obésité enregistré avec succès !',
          'data': decoded['data'],
        };
      } else {
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
  // Récupérer la liste des questions liées au type d'obésité
  // ════════════════════════════════════════════════════════════════════════
  Future<Map<String, dynamic>> fetchQuestions(
    String obesityType, {
    String? token,
  }) async {
    final String url =
        'https://healing-nutrition-plan.pixeluxt.com/api/user-infos/get-user-questions?type=${Uri.encodeComponent(obesityType)}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _headers(token),
      );

      debugPrint('[GET fetchQuestions] Status : ${response.statusCode}');
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'message': decoded['message'] ?? 'Questions chargées avec succès !',
          'questions': decoded['data'] ?? decoded['questions'] ?? [],
        };
      } else {
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
  // ════════════════════════════════════════════════════════════════════════
  Future<Map<String, dynamic>> postAnswer({
    required dynamic questionId,
    required String answer,
    String? token,
  }) async {
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

      debugPrint('[POST postAnswer] Status : ${response.statusCode}');
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'message': decoded['message'] ?? 'Réponse enregistrée avec succès !',
          'data': decoded['data'],
        };
      } else {
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
}