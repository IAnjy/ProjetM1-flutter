// ignore_for_file: prefer_const_constructors

import 'package:biblio/ui/shared/appBarWidget.dart';
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
    );
    // return Center(
    //   child: Text(
    //     "Pret be",
    //     style: TextStyle(fontSize: 14),
    //   ),
    // );
  }
}
