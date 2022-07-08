// ignore_for_file: prefer_const_constructors

import 'package:biblio/http-services/livre_api.dart';
import 'package:biblio/models/livreModel.dart';
import 'package:flutter/material.dart';

import 'livre_card.dart';

class LivreSearch extends SearchDelegate {
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
    Future<List<LivreModel>> _future = getLivres(query: query);

    return FutureBuilder(
      future: _future,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var livres = snapshot.data;
          return livres.length == 0
              ? Center(child: Text("Aucune Résultat :( "))
              : ListView.builder(
                  itemCount: livres.length,
                  itemBuilder: (context, index) {
                    // print(lecteurs);
                    return LivreCard(listLivre: livres, index: index);
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
      child: Text("Rechercher Livre..."),
    );
  }
}
