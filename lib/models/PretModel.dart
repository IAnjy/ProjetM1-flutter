// ignore_for_file: file_names

import 'dart:convert';

PretModel pretsFromJson(String str) => PretModel.fromJson(json.decode(str));

String pretsToJson(PretModel data) => json.encode(data.toJson());

class PretModel {
  int numPret;
  String lecteur;
  String livre;
  DateTime datePret;
  String rendu;

  PretModel({
    required this.numPret,
    required this.lecteur,
    required this.livre,
    required this.datePret,
    required this.rendu,
  });

  factory PretModel.fromJson(Map<String, dynamic> json) => PretModel(
        numPret: json["id"],
        lecteur: json["lecteur"]["nomLecteur"] +
            " " +
            json["lecteur"]["prenomLecteur"],
        livre: json["livre"]["design"],
        datePret: dateParser(json["datePret"]),
        rendu: json["rendu"],
      );

  static dateParser(String dateString) {
    var date = DateTime.parse(dateString);
    return date;
  }

  Map<String, dynamic> toJson() => {
        "numPret": numPret,
        "lecteur": lecteur,
        "livre": livre,
        "datePret": datePret,
        "rendu": rendu,
      };
}
