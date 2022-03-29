// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:biblio/home.dart';
import 'package:flutter/material.dart';

class Lecteur extends StatefulWidget {
  const Lecteur({Key? key}) : super(key: key);

  @override
  State<Lecteur> createState() => _LecteurState();
}

class _LecteurState extends State<Lecteur> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pink[100],
              // backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
              title: Image.asset(
                "assets/LogoT.png",
                width: 160,
                height: 140,
                alignment: Alignment.center,
              ),
              bottom: TabBar(
                labelColor: Colors.black87,
                indicatorWeight: 3,
                tabs: [
                  // Tab(
                  //   icon: Icon(Icons.home),
                  //   text: 'Accueil',
                  // ),
                  Tab(
                    icon: Icon(Icons.face),
                    text: 'Lecteur',
                  ),
                  Tab(
                    icon: Icon(Icons.book),
                    text: 'Livre',
                  ),
                  Tab(
                    icon: Icon(Icons.bookmark_add),
                    text: 'Prêt',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                buildPage('Lecteur'),
                buildPage('Livre'),
                buildPage('Pret'),
              ],
            )));
  }

  buildPage(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
