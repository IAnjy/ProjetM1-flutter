// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:biblio/ui/lecteur/lecteur.dart';
import 'package:biblio/ui/livre/livre.dart';
import 'package:biblio/ui/pret/pret.dart';
import 'package:biblio/ui/shared/header.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[100],
          // backgroundColor: Colors.white,
          // centerTitle: true,
          elevation: 0,
          title: Image.asset(
            "assets/LogoT.png",
            width: 140,
            height: 140,
            alignment: Alignment.center,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.account_circle_rounded, color: Colors.black),
            ),
          ],
        ),
        // ignore: prefer_const_constructors
        body: Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("GESTION BIBLIOTHECAIRE"),
                    _getCard("assets/lecteur.png", "LECTEUR", Lecteur()),
                    _getCard("assets/livre.png", "LIVRE", Livre()),
                    _getCard("assets/pret.png", "PRET", Pret()),
                  ],
                )
              ],
              // floatingActionButton: FloatingActionButton(
              //   onPressed: _incrementCounter,
              //   tooltip: 'Increment',
              //   child: const Icon(Icons.add),
              // )
            )));
  }

  _getCard(String icone, String label, Widget target) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return target;
        }));
      },
      child: Container(
        width: 170,
        height: 145,
        decoration: BoxDecoration(
            color: Colors.pink[100], borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              icone,
              width: 60,
              height: 60,
              alignment: Alignment.center,
            ),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
