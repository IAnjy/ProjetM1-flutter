// ignore_for_file: prefer_const_constructors

import 'package:biblio/http-services/lecteur-api.dart';
import 'package:biblio/models/lecteurModel.dart';
import 'package:flutter/material.dart';

import 'lecteur_card.dart';

class LecteurSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
          print('Search close');
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  // ignore: prefer_final_fields

  @override
  Widget buildResults(BuildContext context) {
    Future<List<LecteurModel>> _future = getLecteurs();

    return FutureBuilder(
      future: _future,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var lecteurs = snapshot.data;
          return ListView.builder(
              itemCount: lecteurs.length,
              itemBuilder: (context, index) {
                // print(lecteurs);
                return LecteurCard(listLecteur: lecteurs, index: index);
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Rechercher Lecteur..."),
    );
  }
}
