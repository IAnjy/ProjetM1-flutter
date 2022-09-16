// ignore_for_file: file_names

import 'dart:convert';

import 'package:biblio/models/lecteurModel.dart';
import 'package:biblio/utils/global_variable.dart';
import 'package:http/http.dart' as http;

_setHeaders() =>
    {'Content-type': 'application/json', 'Accept': 'application/json'};

Future<List<LecteurModel>> getLecteurs({String? query}) async {
  String url = urlConnection + "lecteurs";
  List<LecteurModel> resultat = [];

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      resultat = List.generate(result['hydra:member'].length, (i) {
        return LecteurModel.fromJson(result['hydra:member'][i]);
      });

      if (query != null) {
        resultat = resultat
            .where((element) => (element.numLecteur.toString() +
                    element.nomLecteur +
                    element.prenomLecteur)
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Lecteurs');
    }
  } catch (e) {
    throw "impossible de contacter le server ! Vérifier la connexion!";
  }
  return resultat;
}

Future<void> postLecteurs(String nom, String prenom) async {
  String url = urlConnection + "lecteurs";
  var data = {"nomLecteur": nom, "prenomLecteur": prenom};
  try {
    var response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: _setHeaders());
    if (response.statusCode == 201) {
      String responseString = response.body;
      lecteursFromJson(responseString);
    } else {
      return;
    }
  } catch (e) {
    throw "impossible de contacter le server ! Vérifier la connexion!";
  }
}

Future<void> editLecteurs(int id, String nom, String prenom) async {
  String url = urlConnection + "lecteurs/" + id.toString();
  var data = {"nomLecteur": nom, "prenomLecteur": prenom};

  try {
    var response = await http.put(Uri.parse(url),
        body: jsonEncode(data), headers: _setHeaders());

    if (response.statusCode == 200) {
      String responseString = response.body;
      lecteursFromJson(responseString);
    } else {
      return;
    }
  } catch (e) {
    throw "impossible de contacter le server ! Vérifier la connexion!";
  }
}

Future<void> deleteLecteurs(int id) async {
  String url = urlConnection+"lecteurs/" + id.toString();
  try {
    await http.delete(Uri.parse(url));
  } catch (e) {
    throw "impossible de contacter le server ! Vérifier la connexion!";
  }
}
