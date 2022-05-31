// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, deprecated_member_use

import 'dart:convert';

// import 'package:biblio/api/my_api.dart';
import 'package:biblio/http-services/lecteur-api.dart';
import 'package:biblio/models/lecteurModel.dart';
import 'package:biblio/ui/lecteur/components/lecteur_card.dart';
import 'package:biblio/ui/lecteur/components/lecteur_search.dart';
import 'package:biblio/ui/shared/widgetsReutilisable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lecteur extends StatefulWidget {
  const Lecteur({Key? key}) : super(key: key);

  @override
  State<Lecteur> createState() => _LecteurState();
}

class _LecteurState extends State<Lecteur> {
  LecteurModel? _lecteur;
  late TextEditingController nomInputController;
  late TextEditingController prenomInputController;

  Future<List<LecteurModel>>? _future;

  @override
  void initState() {
    super.initState();
    _future = getLecteurs();
    nomInputController = TextEditingController();
    prenomInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar("LECTEUR", context),
      //-------------------- AJOUT LECTEUR
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFAE8559),
        onPressed: () {
          _showDialogAjoutLecteur(context);
        },
        child: const Icon(Icons.add),
      ),
      //-------------------- FIN AJOUT LECTEUR
      body: Column(
        children: [
          //----------------------------Recherche
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                print("Search tapped");
                showSearch(context: context, delegate: LecteurSearch());
              },
              child: TextField(
                enabled: false,
                decoration: ReusableWidgets.getSearchTextFieldDecoration(),
              ),
            ),
          ),
          //-------------------------Fin Recherche

          //-----------------------Liste Lecteur
          Expanded(
            child: FutureBuilder(
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
            ),
          )
          //----------------------- FinListe Lecteur
        ],
      ),
    );
  }

  _showDialogAjoutLecteur(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.all(20),
              content: Column(
                children: [
                  Text("AJOUTER UN LECTEUR",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 6,
                  ),
                  Text("Remplissez le formulaire"),
                  Expanded(
                      child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(labelText: "Nom*"),
                    controller: nomInputController,
                  )),
                  Expanded(
                      child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(labelText: "Prénom(s)*"),
                    controller: prenomInputController,
                  )),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      nomInputController.clear();
                      prenomInputController.clear();

                      Navigator.pop(context);
                    },
                    child: Text("ANNULER")),
                TextButton(
                    onPressed: () async {
                      String nom = nomInputController.text;
                      String prenom = prenomInputController.text;
                      if (nom.isNotEmpty && prenom.isNotEmpty) {
                        //--ajout...
                        print("ajout...");
                        LecteurModel? data = await postLecteurs(nom, prenom)
                            .then((value) => Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                  return Lecteur();
                                })));

                        // setState(() {
                        //   _lecteur = data;
                        // });

                        // Navigator.pop(context);

                      }
                    },
                    child: Text("AJOUTER"))
              ],
            ));
  }
}
