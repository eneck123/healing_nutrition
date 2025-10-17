import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String _nom = '';
  String _prenom = '';
  int _age = 0;
  String _sexe = '';
  int _poids = 0;
  int _taille = 0;
  double _tourDeTaille = 0.0 ;
  double _tourDeHanche = 0.0;
  double _tourDuCou = 0.0;
  String _niveauActivite = '';
  String _email = '';
  String _motDePasse = '';

  // Getters (inchangés)
  String get nom => _nom;
  String get prenom => _prenom;
  int get age => _age;
  String get sexe => _sexe;
  int get poids => _poids;
  int get taille => _taille;
  double get tourDeTaille => _tourDeTaille;
  double get tourDeHanche => _tourDeHanche;
  double get tourDuCou => _tourDuCou;
  String get niveauActivite => _niveauActivite;
  String get email => _email;
  String get motDePasse => _motDePasse;

  // Nouvelle méthode pour mettre à jour spécifiquement le niveau d'activité
  void setActivityLevel(String level) {
    _niveauActivite = level;
    notifyListeners();
  }

  // Méthode existante pour mettre à jour les informations de l'utilisateur (inchangée)
  void updateUserInfo({
    String? nom,
    String? prenom,
    int? age,
    String? sexe,
    int? poids,
    int? taille,
    double? tourDeTaille,
    double? tourDeHanche,
    double? tourDuCou,
    String? niveauActivite,
    String? email,
    String? motDePasse,
  }) {
    _nom = nom ?? _nom;
    _prenom = prenom ?? _prenom;
    _age = age ?? _age;
    _sexe = sexe ?? _sexe;
    _poids = poids ?? _poids;
    _taille = taille ?? _taille;
    _tourDeTaille = tourDeTaille ?? _tourDeTaille;
    _tourDeHanche = tourDeHanche ?? _tourDeHanche;
    _tourDuCou = tourDuCou ?? _tourDuCou;
    _niveauActivite = niveauActivite ?? _niveauActivite;
    _email = email ?? _email;
    _motDePasse = motDePasse ?? _motDePasse;

    notifyListeners();
  }

  // Méthode pour valider les données (inchangée)
  bool validateData() {
    if (_nom.isEmpty) return false;
    if (_prenom.isEmpty) return false;
    if (_age < 16) return false;
    if (_sexe != 'Homme' && _sexe != 'Femme') return false;
    if (_poids <= 0) return false;
    if (_taille <= 0) return false;
    if (_tourDeTaille <= 0) return false;
    if (_tourDeHanche <= 0) return false;
    if (_tourDuCou <= 0) return false;
    if (_niveauActivite.isEmpty) return false;
    if (!_email.endsWith('@gmail.com')) return false;
    if (_motDePasse.length < 10) return false;

    return true;
  }

  /*String? validateData() {
  if (_nom.isEmpty) {
    return 'Le nom ne peut pas être vide.';
  }
  if (_prenom.isEmpty) {
    return 'Le prénom ne peut pas être vide.';
  }
  if (!_isValidDateFormat(_dateDeNaissance)) {
    return 'La date de naissance n\'est pas au bon format (JJ/MM/AAAA).';
  }
  if (_age < 16) {
    return 'Vous devez avoir au moins 16 ans pour vous inscrire.';
  }
  if (_sexe != 'Homme' && _sexe != 'Femme') {
    return 'Le sexe doit être "Homme" ou "Femme".';
  }
  if (_poids <= 0) {
    return 'Le poids doit être supérieur à 0.';
  }
  if (_taille <= 0) {
    return 'La taille doit être supérieure à 0.';
  }
  if (_tourDeTaille <= 0) {
    return 'Le tour de taille doit être supérieur à 0.';
  }
  if (_tourDeHanche <= 0) {
    return 'Le tour de hanche doit être supérieur à 0.';
  }
  if (_tourDuCou <= 0) {
    return 'Le tour de cou doit être supérieur à 0.';
  }
  if (_niveauActivite.isEmpty) {
    return 'Le niveau d\'activité ne peut pas être vide.';
  }
  if (!_email.endsWith('@gmail.com')) {
    return 'L\'adresse e-mail doit se terminer par "@gmail.com".';
  }
  if (_motDePasse.length < 10) {
    return 'Le mot de passe doit comporter au moins 10 caractères.';
  }

  // Si toutes les validations passent, retourne null (aucune erreur)
  return null;
}*/


 
}

