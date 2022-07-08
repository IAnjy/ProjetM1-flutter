// ignore_for_file: prefer_const_constructors

import 'package:biblio/http-services/pret_api.dart';
import 'package:biblio/ui/pret/components/pret_search.dart';
import 'package:biblio/ui/pret/pret_ajout.dart';
import 'package:biblio/ui/shared/utils.dart';
import 'package:flutter/material.dart';

import '../../models/PretModel.dart';
import 'components/pret_card.dart';

class Pret extends StatefulWidget {
  const Pret({Key? key}) : super(key: key);

  @override
  State<Pret> createState() => _PretState();
}

class _PretState extends State<Pret> {
  Future<List<PretModel>>? _futurePrets;

  @override
  void initState() {
    super.initState();
    _futurePrets = getPrets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar("LISTE DES PRETS", context),
      //-------------------- AJOUT PRET
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFAE8559),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return AjoutPret();
            },
          ),
        ),
        child: const Icon(Icons.add),
      ),
      //-------------------- FIN AJOUT PRET
      body: Column(
        children: [
          //----------------------------Recherche
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              readOnly: true,
              decoration: ReusableWidgets.getSearchTextFieldDecoration(),
              onTap: () {
                print('recherche de prêt');
                showSearch(context: context, delegate: PretSearch());
              },
            ),
          ),
          //-------------------------Fin Recherche
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Pret();
                  },
                ),
              ),
              child: FutureBuilder(
                future: _futurePrets,
                builder: (context, AsyncSnapshot snapchot) {
                  if (snapchot.hasData) {
                    var prets = snapchot.data;
                    return ListView.builder(
                      itemCount: prets.length,
                      itemBuilder: (context, index) {
                        return PretCard(listPret: prets, index: index);
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
