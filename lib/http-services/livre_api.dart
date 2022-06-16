import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:biblio/models/livreModel.dart';

_setHeaders() =>
    {'Content-type': 'application/json', 'Accept': 'application/json'};

Future<List<LivreModel>> getLivres({String? query}) async {
  String url = "http://localhost:8000/api/livres";
  List<LivreModel> resultat = [];

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    resultat = List.generate(result['hydra:member'].length, (i) {
      return LivreModel.fromJson(result['hydra:member'][i]);
    });

    if (query != null) {
      switch (query) {
        case "disponible":
          String condition = "oui";
          resultat = resultat
              .where((element) => (element.disponible)
                  .toLowerCase()
                  .contains(condition.toLowerCase()))
              .toList();
          break;
        case "non-disponible":
          String condition = "non";
          resultat = resultat
              .where((element) => (element.disponible)
                  .toLowerCase()
                  .contains(condition.toLowerCase()))
              .toList();
          break;
        default:
          resultat = resultat
              .where((element) => (element.design + element.auteur)
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
      }
    }

    return resultat;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Livres');
  }
}

Future<void> postLivres(
    String titre, String auteur, DateTime dateEdition) async {
  String url = "http://localhost:8000/api/livres";
  var data = {
    "design": titre,
    "auteur": auteur,
    "dateEdition": dateEdition.toString(),
    "disponible": "OUI"
  };
  var response = await http.post(Uri.parse(url),
      body: jsonEncode(data), headers: _setHeaders());
  if (response.statusCode == 201) {
    String responseString = response.body;
    livresFromJson(responseString);
  } else {
    return;
  }
}

Future<void> modifLivres(
    int id, String titre, String auteur, DateTime dateEdition) async {
  String url = "http://localhost:8000/api/livres/" + id.toString();
  var data = {
    "design": titre,
    "auteur": auteur,
    "dateEdition": dateEdition.toString()
  };

  var response = await http.put(Uri.parse(url),
      body: jsonEncode(data), headers: _setHeaders());
  if (response.statusCode == 200) {
    String responseString = response.body;
    livresFromJson(responseString);
  } else {
    return;
  }
}

Future<void> deleteLivre(int id) async {
  String url = "http://localhost:8000/api/livres/" + id.toString();
  await http.delete(Uri.parse(url));
}
