// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:biblio/models/livreModel.dart';
import 'package:biblio/ui/livre/components/livre_search.dart';
import 'package:biblio/ui/livre/livre_ajout.dart';
import 'package:biblio/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:biblio/http-services/livre_api.dart';

import 'components/livre_card.dart';

class Livre extends StatefulWidget {
  const Livre({Key? key}) : super(key: key);

  @override
  State<Livre> createState() => _LivreState();
}

class _LivreState extends State<Livre> {
  Future<List<LivreModel>>? _futureLivre;

  @override
  void initState() {
    super.initState();
    _futureLivre = getLivres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar("LIVRE", context),
      //-------------------- AJOUT LIVRE
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFAE8559),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return AjoutLivre();
          }));
        },
        child: const Icon(Icons.add),
      ),
      //-------------------- FIN AJOUT LIVRE
      body: Column(
        children: [
          //----------------------------Recherche
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                onTap: () {
                  print('recherche livre');
                  showSearch(context: context, delegate: LivreSearch());
                },
                readOnly: true,
                decoration: ReusableWidgets.getSearchTextFieldDecoration()),
          ),
          //-------------------------Fin Recherche
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return Livre();
              })),
              child: FutureBuilder(
                future: _futureLivre,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var livres = snapshot.data;
                    return ListView.builder(
                        itemCount: livres.length,
                        itemBuilder: (context, index) {
                          return LivreCard(listLivre: livres, index: index);
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
