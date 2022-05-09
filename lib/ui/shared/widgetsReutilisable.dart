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
        hintText: "Rechercher...",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(8));
  }
}
