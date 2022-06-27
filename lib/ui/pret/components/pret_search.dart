// ignore_for_file: prefer_const_constructors
import 'package:biblio/http-services/pret_api.dart';
import 'package:biblio/models/PretModel.dart';
import 'package:flutter/material.dart';

import 'pret_card.dart';

class PretSearch extends SearchDelegate {
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
    Future<List<PretModel>> _future = getPrets(query: query);

    return FutureBuilder(
      future: _future,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var prets = snapshot.data;
          return prets.length == 0
              ? Center(child: Text("Aucune Résultat :( "))
              : ListView.builder(
                  itemCount: prets.length,
                  itemBuilder: (context, index) {
                    // print(lecteurs);
                    return PretCard(listPret: prets, index: index);
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
      child: Text("Recherche de prêt..."),
    );
  }
}
