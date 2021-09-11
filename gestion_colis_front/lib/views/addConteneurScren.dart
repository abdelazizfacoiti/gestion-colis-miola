import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gestion_colis/views/conteneurScreen.dart';
import 'package:gestion_colis/widgets/appBar.dart';
import 'package:gestion_colis/widgets/myButton.dart';
import 'package:gestion_colis/widgets/textFormField.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:gestion_colis/outils/globals.dart' as global;


import 'clientScreen.dart';

class AddConteneurScreen extends StatefulWidget {
  @override
  _AddConteneurScreenState createState() => _AddConteneurScreenState();
}

class _AddConteneurScreenState extends State<AddConteneurScreen> {
  var referenceController;

  var titreController;
  var descriptionController;
  var temperatureController;
  var humuditeController;
  var xController;
  var yController;
  bool _isLoading = false;
  var id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = DateTime.now().millisecondsSinceEpoch;
    referenceController = new TextEditingController(text:id.toString());
    descriptionController = new TextEditingController();
    titreController = new TextEditingController();
    temperatureController = new TextEditingController();
    humuditeController = new TextEditingController();
    xController = new TextEditingController();
    yController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: myAppBar("Formulaire Conteneur Ref°"+ id.toString()),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        child: Center(
            child: Container(
              padding: EdgeInsets.all(10),
              width: 500,
              child: Card(
                child: Column(
                  children: [
                    _isLoading ? LinearProgressIndicator() : SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 19.0, left: 19.0, bottom: 19.0),
                      child: Form(
                        child: Column(
                          children: [
                            myTextField(
                                Icons.label, "référence", referenceController),
                            myTextField(Icons.label, "titre", titreController),
                            myTextField(
                                Icons.edit, "description", descriptionController),
                            myTextField(Icons.wb_sunny, "temperature",
                                temperatureController),
                            myTextField(
                                Icons.ac_unit, "humidité", humuditeController),
                            Row(
                              children: [
                                Expanded(
                                  child: myTextField(Icons.edit_location,
                                      "Coordonnée latitude", xController),
                                ),
                                Expanded(
                                  child: myTextField(Icons.edit_location,
                                      "Coordonnée longitude", yController),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            myButton(
                                "Ajouter", addConteneur, Colors.blueGrey, context)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ),
      ),
          )),
    );
  }

  void addConteneur() async {
    setState(() {
      _isLoading = true;
    });
    final url = "http://localhost:8080/api/conteneurs/SaveConteneur";
    try {
      var res = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Authorization': 'Bearer ${global.token}',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Access-Control-Allow-Origin": "*",
          },
          body: jsonEncode(<String, String>{
            "reference": referenceController.text,
            "titre": titreController.text,
            "description": descriptionController.text,
            "temperature": temperatureController.text,
            "humidite": humuditeController.text,
            "coordonne_Gps": xController.text + " | " + yController.text
          }),
          encoding: Utf8Codec());
      if (res.statusCode == 200) {
        showDialog(
            context: context,
            builder: (cnxt) {
              return AlertDialog(
                content: Text(
                  res.body,
                  style: GoogleFonts.lato(),
                ),
                actions: [
                  GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "ok",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(cnxt);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConteneurScreen()));
                      })
                ],
              );
            });

        setState(() {
          _isLoading = false;
        });
      }
    } catch (_) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
