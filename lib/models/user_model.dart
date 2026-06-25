import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String _nom = '';
  String _prenom = '';
  int _age = 0;

  // On stocke désormais H ou F
  String _sexe = '';

  int _poids = 0;
  int _taille = 0;
  double _tourDeTaille = 0.0;
  double _tourDeHanche = 0.0;
  double _tourDuCou = 0.0;
  String _niveauActivite = '';
  String _email = '';
  String _motDePasse = '';

  // Getters
  String get nom => _nom;
  String get prenom => _prenom;
  int get age => _age;

  // Retourne H ou F
  String get sexe => _sexe;

  int get poids => _poids;
  int get taille => _taille;
  double get tourDeTaille => _tourDeTaille;
  double get tourDeHanche => _tourDeHanche;
  double get tourDuCou => _tourDuCou;
  String get niveauActivite => _niveauActivite;
  String get email => _email;
  String get motDePasse => _motDePasse;

  /// Permet de recevoir "Homme" ou "Femme" et de stocker "H" ou "F"
  void setSexe(String sexe) {
    if (sexe == 'Homme') {
      _sexe = 'H';
    } else if (sexe == 'Femme') {
      _sexe = 'F';
    }
    notifyListeners();
  }

  void setActivityLevel(String level) {
    _niveauActivite = level;
    notifyListeners();
  }

  void updateUserInfo({
    String? nom,
    String? prenom,
    int? age,
    String? sexe, // peut être "Homme" ou "Femme"
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

    if (sexe != null) {
      setSexe(sexe); // conversion ici
    }

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

  bool validateData() {
    if (_nom.isEmpty) return false;
    if (_prenom.isEmpty) return false;
    if (_age < 16) return false;

    // validation adaptée
    if (_sexe != 'H' && _sexe != 'F') return false;

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
}
