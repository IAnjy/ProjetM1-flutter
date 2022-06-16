// ignore_for_file: prefer_const_constructors

import 'package:biblio/http-services/livre_api.dart';
import 'package:biblio/models/livreModel.dart';
import 'package:biblio/ui/livre/livre.dart';
import 'package:biblio/ui/livre/livre_modifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/widgetsReutilisable.dart';

class LivreCard extends StatelessWidget {
  final int index;
  final List<LivreModel> listLivre;

  const LivreCard({Key? key, required this.index, required this.listLivre})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateFormatted =
        DateFormat('dd MMMM yyyy').format(listLivre[index].dateEdition);

    return Column(
      children: [
        Container(
          height: 171,
          child: Card(
            elevation: 3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: listLivre[index].disponible == "OUI"
                                ? Colors.teal
                                : Colors.red,
                            borderRadius: BorderRadius.circular(2)),
                        child: Padding(
                          padding: const EdgeInsets.all(3.1),
                          child: Text(
                            listLivre[index].disponible == "OUI"
                                ? "DISPONIBLE"
                                : "NON-DISPONIBLE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                ListTile(
                  title: Text(listLivre[index].design),
                  subtitle: Text("auteur : " + listLivre[index].auteur),
                  leading: CircleAvatar(
                    backgroundColor: Colors.brown[100],
                    radius: 26,
                    child: Text("${listLivre[index].numLivre}"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          // "Edition: " + listLivre[index].dateEdition.toString(),
                          "Edition: " + dateFormatted.toString()),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    IconButton(
                        onPressed: () {
                          //------------------modifier
                          var model = LivreModel(
                              numLivre: listLivre[index].numLivre,
                              design: listLivre[index].design,
                              auteur: listLivre[index].auteur,
                              dateEdition: listLivre[index].dateEdition,
                              disponible: "");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (
                                BuildContext context,
                              ) =>
                                      ModifLivre(
                                        unLivre: model,
                                      )));
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                        )),
                    IconButton(
                        onPressed: () async {
                          await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => ComfirmDialog(
                                  deleteIt: () async => supprLivre(context)));
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 20,
                        )),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  supprLivre(BuildContext context) async {
    print("suppression...");
    await deleteLivre(listLivre[index].numLivre).then((response) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return Livre();
      }));
    }).catchError((onError) {
      print(onError);
    });
  }
}
