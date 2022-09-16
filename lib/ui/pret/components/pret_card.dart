import 'package:biblio/http-services/pret_api.dart';
import 'package:biblio/models/PretModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/utils.dart';
import '../pret.dart';

class PretCard extends StatefulWidget {
  final int index;
  final List<PretModel> listPret;

  const PretCard({
    Key? key,
    required this.index,
    required this.listPret,
  }) : super(key: key);

  @override
  State<PretCard> createState() => _PretCardState();
}

class _PretCardState extends State<PretCard> {
  bool isRendu = false;
  void onSwitchChange(bool value) {
    setState(() {
      isRendu = value;
    });
  }

  void supprPret(BuildContext context) async {
    var listPret = widget.listPret;
    var index = widget.index;
    if (listPret[index].rendu == "NON") {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => const LivreNonRenduDialog(),
      );
    } else {
      print("suppression pret n° " + listPret[index].numPret.toString());

      await deletePret(listPret[index].numPret).then((response) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const Pret();
            },
          ),
        );
      }).catchError((onError) {
        print(onError);
      });
    }
  }

  void rendreLivre(int id) async {
    await putRenduPret(id).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const Pret();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var listPret = widget.listPret;
    var index = widget.index;
    var dateFormatted =
        DateFormat('dd MMMM yyyy').format(listPret[index].datePret);

    String? rendu;

    if (listPret[index].rendu == "OUI") {
      rendu = "rendu";
      // isRendu = true;
    } else if (listPret[index].rendu == "NON") {
      rendu = "non-rendu";
      // isRendu = false;
    }

    return Column(
      children: [
        SizedBox(
          height: 160,
          child: Card(
            elevation: 3,
            child: Column(
              children: [
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Lecteur : ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            listPret[index].lecteur,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Livre : ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(listPret[index].livre),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Date de pret : ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(dateFormatted.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Situation : ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            rendu!,
                            style: TextStyle(
                                color: rendu == "rendu"
                                    ? Colors.teal
                                    : Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.brown[100],
                    radius: 26,
                    child: Text("${listPret[index].numPret}"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(children: [
                        const SizedBox(
                          width: 12,
                        ),
                        listPret[index].rendu == "NON"
                            ? const Text("Rendre :")
                            : const Text("Rendu :"),
                        Switch(
                          value: isRendu,
                          onChanged: listPret[index].rendu == "NON"
                              ? (value) async {
                                  onSwitchChange(value);

                                  await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) => ComfirmRenduPretDialog(
                                      cancelIt: () async {
                                        Navigator.pop(context);
                                        onSwitchChange(!value);
                                      },
                                      deleteIt: () async {
                                        //Go put Pret
                                        print("Go put Pret");
                                        rendreLivre(listPret[index].numPret);
                                      },
                                    ),
                                  );
                                }
                              : null,
                        ),
                      ]),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) => ComfirmDialog(
                                  deleteIt: () async => supprPret(context),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
