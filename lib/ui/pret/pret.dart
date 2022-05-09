// ignore_for_file: prefer_const_constructors

import 'package:biblio/ui/shared/widgetsReutilisable.dart';
import 'package:flutter/material.dart';

class Pret extends StatefulWidget {
  const Pret({Key? key}) : super(key: key);

  @override
  State<Pret> createState() => _PretState();
}

class _PretState extends State<Pret> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar("PRET", context),
      //-------------------- AJOUT PRET
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFAE8559),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      //-------------------- FIN AJOUT PRET
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
          Expanded(child: Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }
}
