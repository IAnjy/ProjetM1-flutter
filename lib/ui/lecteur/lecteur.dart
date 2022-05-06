// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, deprecated_member_use

import 'package:biblio/models/lecteurModel.dart';
import 'package:biblio/ui/home.dart';
import 'package:biblio/ui/livre/livre.dart';
import 'package:biblio/ui/pret/pret.dart';
import 'package:biblio/ui/shared/appBarWidget.dart';
import 'package:biblio/ui/shared/search.dart';
import 'package:flutter/material.dart';

class Lecteur extends StatefulWidget {
  const Lecteur({Key? key}) : super(key: key);

  @override
  State<Lecteur> createState() => _LecteurState();
}

class _LecteurState extends State<Lecteur> {
  @override
  Widget build(BuildContext context) {
    var listLecteur = <LecteurModel>[
      LecteurModel(1, "ANDRIAHERTSE", "Ianjy Martial"),
      LecteurModel(2, "RAKOTOARISOA", "Elisabeth Angeline"),
      LecteurModel(3, "RANDRIAHERTSE", "Martial"),
      LecteurModel(4, "ANDRIHERTSE", "Ilazasoa Martial"),
      LecteurModel(5, "ANDIAHERTSE", "Fiderana Martial"),
      LecteurModel(6, "Ousmane", "Dembele"),
      LecteurModel(1, "ANDRIAHERTSE", "Ianjy Martial"),
      LecteurModel(2, "RAKOTOARISOA", "Elisabeth Angeline"),
      LecteurModel(3, "RANDRIAHERTSE", "Martial"),
      LecteurModel(4, "ANDRIHERTSE", "Ilazasoa Martial"),
      LecteurModel(5, "ANDIAHERTSE", "Fiderana Martial"),
      LecteurModel(6, "Ousmane", "Dembele"),
    ];

    return Scaffold(
      appBar: ReusableWidgets.getAppBar("LECTEUR", context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFAE8559),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchTextField(),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: listLecteur.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.brown[100],
                        radius: 23,
                        child: Text("${listLecteur[index].numLecteur}"),
                      ),
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(listLecteur[index]
                                    .nomLecteur
                                    .toUpperCase()),
                                Text(listLecteur[index].prenomLecteur),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      size: 20,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete,
                                      size: 20,
                                    )),
                              ],
                            )
                          ]),
                    ),
                  );
                }),
          ),
        ],
      ),
    );

    // return Column(
    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(12.0),
    //       child: SearchTextField(),
    //     ),
    //     Center(
    //       child: Text("lecteur(s) :"),
    //     ),
    //     SingleChildScrollView(
    //         child: ListView.builder(
    //             itemCount: 2,
    //             itemBuilder: (context, index) {
    //               return ListTile(
    //                 title: Text("Element numéro $index"),
    //               );
    //             }))
    //   ],
    // );
  }

  // Widget searchTextFieldView() {
  //   return Container(
  //       child: TextField(
  //     decoration: InputDecoration(
  //         hintText: "Rechercher...",
  //         prefixIcon: Icon(Icons.search),
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  //         contentPadding: EdgeInsets.all(8)),
  //     onChanged: (value) {},
  //   ));
  // }
}
