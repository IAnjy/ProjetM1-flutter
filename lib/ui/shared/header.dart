// ignore_for_file: prefer_const_constructors

import 'package:biblio/ui/lecteur/lecteur.dart';
import 'package:biblio/ui/livre/livre.dart';
import 'package:biblio/ui/pret/pret.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

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
              title: Text(
                "GESTION BIBLIOTHECAIRE",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              bottom: TabBar(
                // labelColor: Color(0xFFAE8559),
                labelColor: Colors.black,
                indicatorWeight: 3,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  Tab(
                    text: 'Lecteur',
                  ),
                  Tab(
                    text: 'Livre',
                  ),
                  Tab(
                    text: 'Prêt',
                  ),
                ],
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {},
            //   tooltip: 'Increment',
            //   child: const Icon(Icons.add),
            // ),
            body: TabBarView(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Lecteur(),
                Livre(),
                Pret(),
              ],
            )));
  }
}
