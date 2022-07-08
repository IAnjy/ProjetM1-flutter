// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:biblio/ui/lecteur/lecteur.dart';
import 'package:biblio/ui/livre/livre.dart';
import 'package:biblio/ui/pret/pret.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<GDPData> _chartData;

  @override
  void initState() {
    super.initState();
    initialization();
    _chartData = getChartData();
  }

  void initialization() async {
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
          child: AppBar(
            leading: null,
            toolbarHeight: 100,
            backgroundColor: Color(0xFFAE8559),
            centerTitle: true,
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gestion",
                  style: GoogleFonts.sail().copyWith(fontSize: 30),
                ),
                Text(
                  "Bibliothécaire",
                  style: GoogleFonts.sail().copyWith(fontSize: 30),
                ),
              ],
            ),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 20),
            //     child:
            //         Icon(Icons.account_circle_rounded, color: Colors.black),
            //   ),
            // ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Menu"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _getCard("assets/lecteur.png", "LECTEUR", Lecteur()),
                        _getCard("assets/livre.png", "LIVRE", Livre()),
                        _getCard("assets/pret.png", "PRETS", Pret()),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Card(
                elevation: 1,
                color: Colors.white,
                child: SfCircularChart(
                  title:
                      ChartTitle(text: "Un aperçu de la situation des livres"),
                  legend: Legend(
                    position: LegendPosition.bottom,
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                  ),
                  series: <CircularSeries>[
                    PieSeries<GDPData, String>(
                      dataSource: _chartData,
                      xValueMapper: (GDPData data, _) => data.continent,
                      yValueMapper: (GDPData data, _) => data.gdp,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData("Dispobible", 16),
      GDPData("Non-disponible", 24),
      GDPData("En pret", 34),
      GDPData("Jamais preter", 9),
      // GDPData("Asia", 7),
      // GDPData("Madagascar", 34),
    ];
    return chartData;
  }

  _getCard(String icone, String label, Widget target) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext newContext) {
          return target;
        }));
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.pink[100], borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              icone,
              width: 40,
              height: 40,
              alignment: Alignment.center,
            ),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}

class GDPData {
  final String continent;
  final int gdp;

  GDPData(this.continent, this.gdp);
}
