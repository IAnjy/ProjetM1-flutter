import 'dart:convert';

import 'package:biblio/models/PretModel.dart';

import 'package:http/http.dart' as http;

_setHeaders() =>
    {'Content-type': 'application/json', 'Accept': 'application/json'};

Future<List<PretModel>> getPrets({String? query}) async {
  String url = "http://localhost:8000/api/prets";
  List<PretModel> resultat = [];

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      // print(result);
      resultat = List.generate(result['hydra:member'].length, (i) {
        return PretModel.fromJson(result['hydra:member'][i]);
      });

      if (query != null) {
        switch (query) {
          case "rendu":
            String condition = "oui";
            resultat = resultat
                .where((element) => (element.rendu)
                    .toLowerCase()
                    .contains(condition.toLowerCase()))
                .toList();
            break;
          case "non-rendu":
            String condition = "non";
            resultat = resultat
                .where((element) => (element.rendu)
                    .toLowerCase()
                    .contains(condition.toLowerCase()))
                .toList();
            break;
          default:
            resultat = resultat
                .where((element) => (element.numPret.toString() +
                        element.lecteur +
                        element.livre)
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                .toList();
        }
      }
    } else {
      throw Exception('Failed to load Livres');
    }
  } catch (e) {
    throw "impossible de contacter le server ! Vérifier la connexion!";
  }
  return resultat;
}

Future<void> deletePret(int id) async {
  String url = "http://localhost:8000/api/prets/" + id.toString();
  try {
    await http.delete(Uri.parse(url));
  } catch (e) {
    throw "impossible de contacter le server ! Vérifier la connexion!";
  }
}

Future<void> putRenduPret(int id) async {
  String url = "http://localhost:8000/api/prets/" + id.toString();
  var data = {"rendu": "OUI"};
  try {
    var response = await http.put(Uri.parse(url),
        body: jsonEncode(data), headers: _setHeaders());
    if (response.statusCode == 200) {
      String responseString = response.body;
      pretsFromJson(responseString);
    } else {
      return;
    }
  } catch (e) {
    throw "impossible de contacter le server ! Vérifier la connexion!";
  }
}

Future<void> postPrets(dynamic lecteurValue, dynamic livreValue) async {
  String url = "http://localhost:8000/api/prets";
  var data = {
    "lecteur": "/api/lecteurs/" + lecteurValue.toString(),
    "livre": "/api/livres/" + livreValue.toString()
  };

  try {
    var response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: _setHeaders());
    if (response.statusCode == 201) {
      String responseString = response.body;
      pretsFromJson(responseString);
    } else {
      return;
    }
  } catch (e) {
    throw "impossible de contacter le server ! Vérifier la connexion!";
  }
}
