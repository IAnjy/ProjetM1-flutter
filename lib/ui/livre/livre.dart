// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:biblio/ui/shared/appBarWidget.dart';
import 'package:biblio/ui/shared/search.dart';
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
    );
    // return ListView(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(12.0),
    //       child: SearchTextField(),
    //     ),
    //     Center(
    //       child: Text("Livre be"),
    //     )
    //   ],
    // );
  }
}
