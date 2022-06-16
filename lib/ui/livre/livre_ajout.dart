// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:biblio/http-services/livre_api.dart';
import 'package:biblio/ui/livre/livre.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AjoutLivre extends StatefulWidget {
  const AjoutLivre({Key? key}) : super(key: key);

  @override
  State<AjoutLivre> createState() => _AjoutLivreState();
}

class _AjoutLivreState extends State<AjoutLivre> {
  late TextEditingController titleInputController;
  late TextEditingController auteurInputController;
  late TextEditingController dateInputController;

  DateTime _dateEdition = DateTime.now();

  @override
  void initState() {
    super.initState();
    titleInputController = TextEditingController();
    auteurInputController = TextEditingController();
    dateInputController = TextEditingController(
        text: DateFormat('dd MMMM yyyy').format(_dateEdition).toString());
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> _validate() async {
    if (formkey.currentState!.validate()) {
      print("livre ajout...");

      var titre = titleInputController.text;
      var auteur = auteurInputController.text;
      var dateEdition = _dateEdition;

      await postLivres(titre, auteur, dateEdition).then((response) {
        titleInputController.clear();
        auteurInputController.clear();
        dateInputController = TextEditingController(
            text: DateFormat('dd MMMM yyyy').format(_dateEdition).toString());

        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return Livre();
        }));
      }).catchError((onError) {
        print(onError);
      });
    } else {
      print("non valide");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _dateEdition,
        firstDate: DateTime(1880),
        lastDate: DateTime.now());
    if (_datePicker != null && _datePicker != _dateEdition) {
      setState(() {
        _dateEdition = _datePicker;
        dateInputController = TextEditingController(
            text: DateFormat('dd MMMM yyyy').format(_dateEdition).toString());
      });
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
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Form(
                key: formkey,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.menu_book_outlined,
                        color: Color(0xFFAE8559),
                        size: 140,
                      ),
                      Text(
                        "ajouter un livre",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: TextFormField(
                            style: TextStyle(fontSize: 16),
                            controller: titleInputController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.edit_note_rounded,
                                  size: 30,
                                ),
                                labelText: "titre..."),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "champ obligatoire !";
                              } else {
                                return null;
                              }
                            },
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: TextFormField(
                            controller: auteurInputController,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.person_add_alt_rounded,
                                  size: 30,
                                ),
                                labelText: "auteur..."),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "champ obligatoire !";
                              } else {
                                return null;
                              }
                            },
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: TextFormField(
                              controller: dateInputController,
                              readOnly: true,
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(
                                    Icons.calendar_month_rounded,
                                    size: 30,
                                  ),
                                  labelText: "Date d'édition...",
                                  hintText: DateFormat('dd MMMM yyyy')
                                      .format(_dateEdition)
                                      .toString()),
                              onTap: () => _selectDate(context))),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(90, 50)),
                              child: Text("AJOUTER"),
                              onPressed: () => _validate(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
