// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  // const SearchTextField(List list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextField(
      decoration: InputDecoration(
          hintText: "Rechercher...",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.all(8)),
      onChanged: (value) {},
    ));
  }
}
