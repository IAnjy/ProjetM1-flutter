// ignore_for_file: file_names

import 'dart:convert';

import 'package:biblio/models/lecteurModel.dart';
import 'package:http/http.dart' as http;

Future<List<LecteurModel>> getLecteurs() async {
  String url = "http://localhost:8000/api/lecteurs";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    return List.generate(result['hydra:member'].length, (i) {
      // print(LecteurModel.fromJson(result['hydra:member'][i]));
      var temp = LecteurModel.fromJson(result['hydra:member'][1]);
      // print(temp.nomLecteur);
      // print(temp.nomLecteur);
      return LecteurModel.fromJson(result['hydra:member'][i]);
    });
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Lecteurs');
  }
}
