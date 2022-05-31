// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:biblio/models/livreModel.dart';
import 'package:biblio/ui/shared/widgetsReutilisable.dart';
import 'package:flutter/material.dart';

import 'components/livre_card.dart';

class Livre extends StatefulWidget {
  const Livre({Key? key}) : super(key: key);

  @override
  State<Livre> createState() => _LivreState();
}

class _LivreState extends State<Livre> {
  static List<LivreModel> listLivre = [
    LivreModel(1, "Lala sy Noro", "Agrad & Skaiz", DateTime.now(), "OUI"),
    LivreModel(2, "Méthode Bocher", "J.J. Rabearivelo", DateTime.now(), "NON"),
    LivreModel(3, "Vakivakim-piainana", "Iharilanto Andriamangatiana",
        DateTime.now(), "OUI"),
    LivreModel(4, "Mitaraina ny Tany", "Gérard Moreno", DateTime.now(), "OUI"),
    LivreModel(5, "Harry Potera", "Potera Kely", DateTime.now(), "OUI"),
  ];

  List<LivreModel> displayList = List.from(listLivre);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar("LIVRE", context),
      //-------------------- AJOUT LIVRE
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFAE8559),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      //-------------------- FIN AJOUT LIVRE
      body: Column(
        children: [
          //----------------------------Recherche
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: ReusableWidgets.getSearchTextFieldDecoration(),
              onChanged: (value) {
                print(value);
              },
            ),
          ),
          //-------------------------Fin Recherche
          Expanded(
              child: //Center(child: CircularProgressIndicator())
                  ListView.builder(
                      itemCount: displayList.length,
                      itemBuilder: (context, index) {
                        return LivreCard(listLivre: displayList, index: index);
                      }))
        ],
      ),
    );
  }
}
