// ignore_for_file: file_names

import 'dart:convert';

import 'package:biblio/models/lecteurModel.dart';
import 'package:http/http.dart' as http;

_setHeaders() =>
    {'Content-type': 'application/json', 'Accept': 'application/json'};

Future<List<LecteurModel>> getLecteurs({String? query}) async {
  String url = "http://localhost:8000/api/lecteurs";
  List<LecteurModel> resultat = [];

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    resultat = List.generate(result['hydra:member'].length, (i) {
      return LecteurModel.fromJson(result['hydra:member'][i]);
    });

    if (query != null) {
      resultat = resultat
          .where((element) => (element.nomLecteur + element.prenomLecteur)
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    return resultat;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Lecteurs');
  }
}

Future<LecteurModel?> postLecteurs(String nom, String prenom) async {
  String url = "http://localhost:8000/api/lecteurs";
  var data = {"nomLecteur": nom, "prenomLecteur": prenom};
  var response = await http.post(Uri.parse(url),
      body: jsonEncode(data), headers: _setHeaders());
  if (response.statusCode == 201) {
    String responseString = response.body;
    lecteursFromJson(responseString);
  } else {
    return null;
  }
}

Future<LecteurModel?> editLecteurs(int id, String nom, String prenom) async {
  String url = "http://localhost:8000/api/lecteurs/" + id.toString();
  var data = {"nomLecteur": nom, "prenomLecteur": prenom};
  var response = await http.put(Uri.parse(url),
      body: jsonEncode(data), headers: _setHeaders());

  if (response.statusCode == 200) {
    String responseString = response.body;
    lecteursFromJson(responseString);
  } else {
    return null;
  }
}

Future<LecteurModel?> deleteLecteurs(int id) async {
  String url = "http://localhost:8000/api/lecteurs/" + id.toString();
  final response = await http.delete(Uri.parse(url));
}
