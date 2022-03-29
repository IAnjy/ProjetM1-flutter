import 'package:biblio/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion bibliothécaire',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        // primarySwatch: Color(hexColor('#AE8559')),
      ),
      home: const MyHomePage(title: 'Biblio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        // backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Image.asset(
          "assets/LogoT.png",
          width: 140,
          height: 140,
          alignment: Alignment.center,
        ),
      ),
      // ignore: prefer_const_constructors
      body: Home(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // )
    );
  }
}
