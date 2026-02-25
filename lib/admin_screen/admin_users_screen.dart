import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_login_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class User {
  final int id;
  final String role;
  final String nom;
  final String prenom;
  final int? age;
  final String? sexe;
  final int? poids;
  final int? taille;
  final String email;
  final double? tourDeTaille;
  final double? tourDeHanche;
  final double? tourDuCou;
  final String? niveauDActivitePhysique;
  final int? maladiechroniqueId;
  final DateTime? lastLoginDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.role,
    required this.nom,
    required this.prenom,
    this.age,
    this.sexe,
    this.poids,
    this.taille,
    required this.email,
    this.tourDeTaille,
    this.tourDeHanche,
    this.tourDuCou,
    this.niveauDActivitePhysique,
    this.maladiechroniqueId,
    this.lastLoginDate,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName => '$prenom $nom';

  factory User.fromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'],
    role: json['role'] ?? 'Non défini',
    nom: json['nom'] ?? 'Sans nom',
    prenom: json['prenom'] ?? 'Sans prénom',
    age: json['age'],
    sexe: json['sexe'],
    poids: json['poids'],
    taille: json['taille'],
    email: json['email'] ?? 'Email non défini',
    tourDeTaille: json['tour_de_taille']?.toDouble(),
    tourDeHanche: json['tour_de_hanche']?.toDouble(),
    tourDuCou: json['tour_du_cou']?.toDouble(),
    //tourDeTaille: json['tour_de_taille'] != null ? json['tour_de_taille'].toDouble() : null,
    //tourDeHanche: json['tour_de_hanche'] != null ? json['tour_de_hanche'].toDouble() : null,
    //tourDuCou: json['tour_du_cou'] != null ? json['tour_du_cou'].toDouble() : null,
    niveauDActivitePhysique: json['niveau_d_activite_physique'],
    maladiechroniqueId: json['maladie_chronique_id'],
    lastLoginDate: json['last_login_date'] != null && json['last_login_date'].toString().isNotEmpty 
        ? DateTime.parse(json['last_login_date']) 
        : null,
    createdAt: json['created_at'] != null && json['created_at'].toString().isNotEmpty 
        ? DateTime.parse(json['created_at']) 
        : null,
    updatedAt: json['updated_at'] != null && json['updated_at'].toString().isNotEmpty 
        ? DateTime.parse(json['updated_at']) 
        : null,
  );
}
}

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  _AdminUsersScreenState createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final UserLoginService _loginService = UserLoginService();
  List<User> _users = [];
  bool _isLoading = true;
  String? _error;
  final Map<int, bool> _isUserExpanded = {}; // Ajouter un map pour gérer l'état des utilisateurs

  @override
  void initState() {
    super.initState();
    _checkAdminAndFetchUsers();
  }

  Future<String?> getAuthToken() async {
    final loginService = UserLoginService();
    return await loginService.getToken();
  }

  Future<void> _checkAdminAndFetchUsers() async {
    final token = await _loginService.getToken();
    final role = await _loginService.getRole();
  
    if (token == null || token.isEmpty) {
      setState(() {
        _error = 'Non autorisé : Token manquant';
        _isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed('/login');
      return;
    }

    if (role != 'admin') {
      setState(() {
        _error = 'Accès refusé : Droits administrateur requis';
        _isLoading = false;
      });
      await _loginService.logout();
      Navigator.of(context).pushReplacementNamed('/login');
      return;
    }

    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final token = await getAuthToken();

      if (token == null || token.isEmpty) {
        setState(() {
          _error = 'Non autorisé : Token manquant';
          _isLoading = false;
        });
        return;
      }

      final url = Uri.parse('https://healing-nutrition-plan.pixeluxt.com/api/admin/users/get-list');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
      
        if (responseData.containsKey('data') && responseData['data'] != null) {
          setState(() {
            _users = (responseData['data'] as List<dynamic>)
                .map((json) => User.fromJson(json))
                .toList();
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _error = 'Erreur ${response.statusCode} : Veuillez réessayer';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Erreur de connexion: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteUser(User user) async {
    try {
      final token = await getAuthToken();

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Non autorisé : Token manquant'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final url = Uri.parse('https://healing-nutrition-plan.pixeluxt.com/api/admin/users/delete/${user.id}');

      // Utilisation de POST pour la suppression
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'user_id': user.id, // Envoi de l'ID de l'utilisateur pour suppression
        }),
      );

       if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        _users.removeWhere((u) => u.id == user.id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('L\'utilisateur ${user.prenom} ${user.nom} a été supprimé avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Impossible de supprimer l\'utilisateur: code d\'erreur ${response.statusCode}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Échec de la suppression: une erreur est survenue. Détails: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Utilisateurs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchUsers,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

Widget _buildBody() {
  return Column(
    children: [
      Expanded(
        child: _buildContent(),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('Retour', style: TextStyle(fontSize: 20)),
        ),
      ),
    ],
  );
}

Widget _buildContent() {
  if (_isLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (_error != null) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _error!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _fetchUsers,
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  if (_users.isEmpty) {
    return const Center(
      child: Text('Aucun utilisateur trouvé'),
    );
  }

  return ListView.builder(
    itemCount: _users.length,
    itemBuilder: (context, index) {
      final user = _users[index];
      return Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                title: Text('${user.nom} ${user.prenom}'),
                subtitle: Text('Email: ${user.email}'),
                trailing: ElevatedButton.icon(
                  icon: const Icon(Icons.delete, color: Colors.green),
                  label: const Text('Supprimer'),
                  onPressed: () => _showDeleteConfirmation(user),
                ),
                onTap: () {
                  setState(() {
                    _isUserExpanded[user.id] = !(_isUserExpanded[user.id] ?? false);
                  });
                },
              ),
              if (_isUserExpanded[user.id] ?? false) 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _buildUserDetails(user),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

  Widget _buildUserDetails(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rôle: ${user.role}'),
        Text('Email: ${user.email}'),
        if (user.age != null) Text('Âge: ${user.age}'),
        if (user.sexe != null) Text('Sexe: ${user.sexe}'),
        if (user.poids != null) Text('Poids: ${user.poids} kg'),
        if (user.taille != null) Text('Taille: ${user.taille} cm'),
        if (user.tourDeTaille != null) Text('Tour de taille: ${user.tourDeTaille} cm'),
        if (user.tourDeHanche != null) Text('Tour de hanche: ${user.tourDeHanche} cm'),
        if (user.tourDuCou != null) Text('Tour du cou: ${user.tourDuCou} cm'),
        if (user.niveauDActivitePhysique != null)
          Text('Niveau d\'activité physique: ${user.niveauDActivitePhysique}'),
        if (user.maladiechroniqueId != null) Text('Maladie chronique: ${user.maladiechroniqueId}'),
        if (user.createdAt != null)
          Text('Créé le: ${DateFormat('dd/MM/yyyy').format(user.createdAt!)}'),
        if (user.updatedAt != null)
          Text('Mis à jour le: ${DateFormat('dd/MM/yyyy').format(user.updatedAt!)}'),
      ],
    );
  }

  void _showDeleteConfirmation(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: const Text('Êtes-vous sûr de vouloir supprimer cet utilisateur ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteUser(user);
              },
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }
}
