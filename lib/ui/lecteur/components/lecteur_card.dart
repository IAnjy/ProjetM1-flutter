// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:biblio/http-services/lecteur-api.dart';
import 'package:biblio/models/lecteurModel.dart';
import 'package:biblio/ui/shared/widgetsReutilisable.dart';
import 'package:flutter/material.dart';

import '../lecteur.dart';

class LecteurCard extends StatelessWidget {
  final int index;
  final List<LecteurModel> listLecteur;

  LecteurCard({Key? key, required this.index, required this.listLecteur})
      : super(key: key);

  late TextEditingController nomInputController =
      TextEditingController(text: listLecteur[index].nomLecteur);
  late TextEditingController prenomInputController =
      TextEditingController(text: listLecteur[index].prenomLecteur);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.brown[100],
          radius: 23,
          child: Text("${listLecteur[index].numLecteur}"),
        ),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(listLecteur[index].nomLecteur.toUpperCase()),
              Text(listLecteur[index].prenomLecteur),
            ],
          ),
          Row(
            children: [
              //------------------MODIFIER-----------------------
              IconButton(
                  onPressed: () {
                    _showDialogModifierLecteur(
                        context, listLecteur[index].numLecteur);
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 20,
                  )),

              //------------------FIN MODIFIER-----------------------

              //------------------SUPPRIMER-----------------------
              IconButton(
                  onPressed: () async {
                    await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => ComfirmDialog(
                            deleteIt: () async => supprLecteur(context)));
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                  )),
              //------------------fin SUPPRIMER-----------------------
            ],
          )
        ]),
      ),
    );
  }

  _showDialogModifierLecteur(BuildContext context, int index) async {
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.all(20),
              content:
                  //Center(child: CircularProgressIndicator()),
                  Column(
                children: [
                  Text("MODIFIER UN LECTEUR",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 6,
                  ),
                  Text("modifier..."),
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
                        print("Modifier...");
                        LecteurModel? data =
                            await editLecteurs(index, nom, prenom)
                                .then((response) {
                          nomInputController.clear();
                          prenomInputController.clear();
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Lecteur();
                          }));
                        }).catchError((onError) {
                          print(onError);
                        });
                      }
                    },
                    child: Text("MODIFIER"))
              ],
            ));
  }

  supprLecteur(BuildContext context) async {
    print("suppression...");
    LecteurModel? data =
        await deleteLecteurs(listLecteur[index].numLecteur).then((response) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return Lecteur();
      }));
    }).catchError((onError) {
      print(onError);
    });
  }
}
