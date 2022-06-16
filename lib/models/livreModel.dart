// ignore_for_file: file_names
import 'dart:convert';

import 'package:intl/intl.dart';

LivreModel livresFromJson(String str) => LivreModel.fromJson(json.decode(str));

String livresToJson(LivreModel data) => json.encode(data.toJson());

class LivreModel {
  int numLivre;
  String design;
  String auteur;
  // String dateEdition;
  DateTime dateEdition;
  String disponible;

  LivreModel(
      {required this.numLivre,
      required this.design,
      required this.auteur,
      required this.dateEdition,
      required this.disponible});

  factory LivreModel.fromJson(Map<String, dynamic> json) => LivreModel(
        numLivre: json["id"],
        design: json["design"],
        auteur: json["auteur"],
        dateEdition: dateParser(json["dateEdition"]),
        // dateEdition: json["dateEdition"],
        disponible: json["disponible"],
      );

  static dateParser(String dateString) {
    var date = DateTime.parse(dateString);
    return date;
  }

  Map<String, dynamic> toJson() => {
        "id": numLivre,
        "design": design,
        "auteur": auteur,
        "dateEdition": dateEdition,
        "disponible": disponible,
      };
}
