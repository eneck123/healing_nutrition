
//import 'package:flutter/foundation.dart';

/*class Config {
  static String get apiUrl {
    if (kReleaseMode) {
      // URL de production
      return 'https://flutter_application_1/api/ ';
    } else {
      // URL de développement
      // Remplacez XXX.XXX.X.XXX par l'adresse IP de votre machine
      return 'http://192.168.43.216:8000/';
    }
  }
}*/

class Config {
 //static const String baseUrl = 'http://localhost:8000'; // Remplacez par l'URL de votre backend
  //static const String baseUrl = 'https://Application_Flutter_1/api/';
  static const String baseUrl = 'http://192.168.43.216:8000/api'; 
   

  // Vous pouvez également ajouter d'autres configurations si nécessaire
  static const String anotherConfig = 'value';

}
