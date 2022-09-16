import 'package:biblio/http-services/lecteur-api.dart';
import 'package:biblio/http-services/livre_api.dart';
import 'package:biblio/http-services/pret_api.dart';
import 'package:biblio/models/livreModel.dart';
import 'package:biblio/ui/pret/pret.dart';
import 'package:flutter/material.dart';

import '../../models/lecteurModel.dart';

class AjoutPret extends StatefulWidget {
  const AjoutPret({Key? key}) : super(key: key);

  @override
  State<AjoutPret> createState() => _AjoutPretState();
}

class _AjoutPretState extends State<AjoutPret> {
  dynamic lecteurValue;
  dynamic livreValue;

  Future<List<LecteurModel>>? _futureLecteur;
  Future<List<LivreModel>>? _futureLivre;

  @override
  void initState() {
    super.initState();
    _futureLecteur = getLecteurs();
    _futureLivre = getLivres(query: "disponible");
  }

  List<DropdownMenuItem> buildMenuItemLecteur(List<LecteurModel> lecteurs) {
    List<DropdownMenuItem> lecteursItems = [];
    for (var i = 0; i < lecteurs.length; i++) {
      var item = DropdownMenuItem(
        value: lecteurs[i].numLecteur,
        child: Text(lecteurs[i].nomLecteur + " " + lecteurs[i].prenomLecteur),
      );
      lecteursItems.add(item);
    }
    return lecteursItems;
  }

  List<DropdownMenuItem> buildMenuItemLivre(List<LivreModel> livres) {
    List<DropdownMenuItem> livresItems = [];
    for (var i = 0; i < livres.length; i++) {
      var item = DropdownMenuItem(
        value: livres[i].numLivre,
        child: Text(livres[i].design),
      );
      livresItems.add(item);
    }
    return livresItems;
  }

  void validate(dynamic lecteurValue, dynamic livreValue) async {
    if (lecteurValue == null || livreValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez Sélectionner un item"),
        ),
      );
    } else {
      //---Go Post Pret
      await postPrets(lecteurValue, livreValue).then(
        (response) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const Pret();
              },
            ),
          );
        },
      ).catchError(
        (onError) {
          print(onError);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      "assets/pret.png",
                      width: 120,
                      height: 120,
                      alignment: Alignment.center,
                    ),
                    const Text(
                      "Faire un pret",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FutureBuilder(
                        future: _futureLecteur,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var lecteurs = snapshot.data;
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<dynamic>(
                                hint: const Text("Sélectionner un lecteur"),
                                value: lecteurValue,
                                items: buildMenuItemLecteur(lecteurs),
                                onChanged: (value) {
                                  setState(() => lecteurValue = value);
                                  print(lecteurValue);
                                },
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FutureBuilder(
                        future: _futureLivre,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var livres = snapshot.data;
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<dynamic>(
                                hint: const Text("Sélectionner un livre"),
                                value: livreValue,
                                items: buildMenuItemLivre(livres),
                                onChanged: (val) {
                                  setState(() => livreValue = val);
                                  print(livreValue);
                                },
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(90, 50)),
                            child: const Text("EMPREINTER"),
                            onPressed: () => validate(lecteurValue, livreValue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
