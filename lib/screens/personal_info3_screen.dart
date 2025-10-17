import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'personal_info4_screen.dart';
import '../models/user_model.dart';



class PersonalInfo3Screen extends StatefulWidget {
  const PersonalInfo3Screen({super.key});

  @override
  _PersonalInfo3ScreenState createState() => _PersonalInfo3ScreenState();
}

class _PersonalInfo3ScreenState extends State<PersonalInfo3Screen> {
  String? _selectedActivityLevel;

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vous'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quel est votre niveau d\'activité physique ?',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24.0),
            _buildActivityOption('Sédentaire', 
                'Ce niveau correspond à une personne qui fait très peu d\'exercice ou d\'activité physique en dehors de ses activités quotidiennes normales.'),
            const SizedBox(height: 12.0),
            _buildActivityOption('Légèrement Actif', 
                'Ce niveau inclut les activités physiques légères ou modérées pratiquées occasionnellement.'),
            const SizedBox(height: 12.0),
            _buildActivityOption('Modérément Actif', 
                'Ce niveau concerne les personnes qui pratiquent une activité physique modérée régulièrement.'),
            const SizedBox(height: 12.0),
            _buildActivityOption('Très Actif', 
                'Ce niveau inclut des personnes qui pratiquent régulièrement des activités physiques intenses.'),
            const SizedBox(height: 12.0),
            _buildActivityOption('Extrêmement Actif', 
                'Ce niveau correspond à des personnes qui s\'engagent dans une activité physique intense presque quotidiennement.'),
            const SizedBox(height: 100.0),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedActivityLevel != null ? () {
              // Mise à jour du modèle utilisateur avant de naviguer
              userModel.setActivityLevel(_selectedActivityLevel!);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PersonalInfo4Screen()),
              );
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              'Suivant',
              style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildActivityOption(String title, String description) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedActivityLevel = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedActivityLevel == title ? Colors.green : Colors.grey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: _selectedActivityLevel == title ? Colors.green : Colors.black,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              description,
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}