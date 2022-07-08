// ignore_for_file: file_names, prefer_const_constructors

import 'package:biblio/ui/lecteur/lecteur.dart';
import 'package:biblio/ui/livre/livre.dart';
import 'package:biblio/ui/pret/pret.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class ReusableWidgets {
  static getAppBar(String title, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.pink[100],
      // backgroundColor: Colors.white,
      // centerTitle: true,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              icon: Icon(
                Icons.home,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text("Lecteur")),
              PopupMenuItem(value: 1, child: Text("Livre")),
              PopupMenuItem(value: 2, child: Text("Pret")),
            ],
            child: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              switch (value) {
                case 0:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Lecteur()));
                  break;
                case 1:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Livre()));
                  break;
                case 2:
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Pret()));
                  break;
              }
            },
          ),
        ),
      ],
    );
  }

  static getSearchTextFieldDecoration() {
    return InputDecoration(
        hintText: "Appuyez pour rechercher...",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        contentPadding: EdgeInsets.all(8));
  }
}

class ComfirmDialog extends StatelessWidget {
  final Future<void> Function() deleteIt;
  const ComfirmDialog({Key? key, required this.deleteIt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      //Center(child: CircularProgressIndicator()),

      title: Text(
        "CONFIRMATION",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.all(20),

      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Image.asset(
          "assets/pirateT.png",
          width: 80,
          height: 80,
          alignment: Alignment.center,
        ),
        Container(height: 25.0),
        Text("Voulez-vous vraiment supprimez ?", textAlign: TextAlign.center),
        Text("*Cette action est irréversible !!!", textAlign: TextAlign.center),
        Container(height: 25.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("ANNULER")),
            TextButton(
                onPressed: () => deleteIt(),
                child: Text("SUPPRIMER",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold))),
          ],
        )
      ],
    );
  }
}

//-------------Pret Rendu
class ComfirmRenduPretDialog extends StatelessWidget {
  final Future<void> Function() deleteIt;
  final Future<void> Function() cancelIt;
  const ComfirmRenduPretDialog(
      {Key? key, required this.deleteIt, required this.cancelIt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      //Center(child: CircularProgressIndicator()),

      title: Text(
        "CONFIRMATION",
        style: TextStyle(color: Color(0xFFAE8559), fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.all(20),

      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Container(height: 12.0),
        Text("Voulez-vous vraiment rendre le LIVRE ?",
            textAlign: TextAlign.center),
        Container(height: 25.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: () => cancelIt(), child: Text("NON")),
            TextButton(
              onPressed: () => deleteIt(),
              child: Text(
                "OUI",
                style: TextStyle(
                  color: Color(0xFFAE8559),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class LivreNonRenduDialog extends StatelessWidget {
  const LivreNonRenduDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      //Center(child: CircularProgressIndicator()),

      title: Text(
        "INFORMATION",
        style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.all(20),

      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Container(height: 20.0),
        Text("Impossible de Supprimez !!", textAlign: TextAlign.center),
        Text("Livre non-rendu !!", textAlign: TextAlign.center),
        Container(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("RETOUR")),
          ],
        )
      ],
    );
  }
}
