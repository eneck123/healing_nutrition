import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../models/user_registration_service.dart';



class PersonalInfo4Screen extends StatefulWidget {
  const PersonalInfo4Screen({super.key});

  @override
  _PersonalInfo4ScreenState createState() => _PersonalInfo4ScreenState();
}

class _PersonalInfo4ScreenState extends State<PersonalInfo4Screen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController motDePasseController = TextEditingController();
  bool obscureText = true;

  void _handleRegistration() async {
    if (formKey.currentState!.validate()) {
      final userModel = Provider.of<UserModel>(context, listen: false);
      userModel.updateUserInfo(
        email: emailController.text,
        motDePasse: motDePasseController.text,
      );

      if (userModel.validateData()) {
        final userRegistrationService = UserRegistrationService();
        final result = await userRegistrationService.registerUser(
          nom: userModel.nom,
          prenom: userModel.prenom,
          age: userModel.age,
          sexe: userModel.sexe,
          poids: userModel.poids,
          taille: userModel.taille,
          tourDeTaille: userModel.tourDeTaille,
          tourDeHanche: userModel.tourDeHanche,
          tourDuCou: userModel.tourDuCou,
          niveauActivite: userModel.niveauActivite,
          email: userModel.email,
          motDePasse: userModel.motDePasse,
        );

        if (result['success']) {
          // Afficher le message de succès
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message']),
              duration: const Duration(seconds: 2),
            ),
          );

          // Attendre que le SnackBar soit affiché avant de naviguer
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => true,
            );
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Certaines informations sont invalides. Veuillez vérifier tous les champs.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Création de compte"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "C'est presque fini ! Créez votre propre compte.",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24.0),

              const Text(
                'Quelle est votre adresse e-mail ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Adresse e-mail',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre adresse e-mail';
                  } else if (!value.endsWith('@gmail.com')) {
                    return 'L\'adresse e-mail doit se terminer par @gmail.com';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 27.0),

              const Text(
                'Quel est votre mot de passe ?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: motDePasseController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: motDePasseController.text.length < 10
                          ? Colors.red // Changer la couleur de la bordure ici
                          : Colors.grey,
                    ),
                  ),
                  labelText: 'Mot de Passe',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                ),
                obscureText: obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  } else if (value.length < 10) {
                    return 'Le mot de passe doit comporter 10 caractères au minimum';
                  }
                  return null;
                },
                // Écoutez les modifications du champ de mot de passe
                onChanged: (value) {
                  setState(() {}); // Mettre à jour l'état pour redessiner le widget
                },
              ),
              const SizedBox(height: 8.0),
              const Text(
                '10 caractères minimum',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _handleRegistration,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 18.0),
                      textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('S\' Inscrire'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
