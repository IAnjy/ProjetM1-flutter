import 'package:biblio/ui/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion bibliothécaire',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        // primarySwatch: Color(hexColor('#AE8559')),
      ),
      home: const Home(),
    );
  }
}
