// ignore_for_file: file_names

import 'dart:convert';

LecteurModel lecteursFromJson(String str) =>
    LecteurModel.fromJson(json.decode(str));

String lecteursToJson(LecteurModel data) => json.encode(data.toJson());

class LecteurModel {
  LecteurModel({
    required this.numLecteur,
    required this.nomLecteur,
    required this.prenomLecteur,
  });

  int numLecteur;
  String nomLecteur;
  String prenomLecteur;

  factory LecteurModel.fromJson(Map<String, dynamic> json) => LecteurModel(
        numLecteur: json["id"],
        nomLecteur: json["nomLecteur"],
        prenomLecteur: json["prenomLecteur"],
      );

  Map<String, dynamic> toJson() => {
        "id": numLecteur,
        "nomLecteur": nomLecteur,
        "prenomLecteur": prenomLecteur,
      };
}
