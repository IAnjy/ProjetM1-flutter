// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:biblio/ui/lecteur/lecteur.dart';
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
    return Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("GESTION BIBLIOTHECAIRE"),
                _getCard("assets/lecteur.png", "LECTEUR"),
                _getCard("assets/livre.png", "LIVRE"),
                _getCard("assets/pret.png", "PRET"),
              ],
            )
          ],
        ));
  }

  _getCard(String icone, String label) {
    return InkWell(
      // ignore: avoid_print
      onTap: () {
        // ignore: avoid_print
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return Lecteur();
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
