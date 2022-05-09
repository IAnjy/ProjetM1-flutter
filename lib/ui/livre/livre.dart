// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:biblio/ui/shared/widgetsReutilisable.dart';
import 'package:flutter/material.dart';

class Livre extends StatefulWidget {
  const Livre({Key? key}) : super(key: key);

  @override
  State<Livre> createState() => _LivreState();
}

class _LivreState extends State<Livre> {
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
          Expanded(child: Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }
}
