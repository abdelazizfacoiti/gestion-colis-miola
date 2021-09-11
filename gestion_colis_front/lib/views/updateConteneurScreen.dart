import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_colis/views/clientScreen.dart';
import 'package:gestion_colis/views/conteneurScreen.dart';
import 'package:gestion_colis/widgets/appBar.dart';
import 'package:gestion_colis/widgets/appBar.dart';
import 'package:gestion_colis/widgets/myButton.dart';
import 'package:gestion_colis/widgets/textFormField.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:gestion_colis/outils/globals.dart' as global;

class UpdateConteneurScreen extends StatefulWidget {
  final map;

  UpdateConteneurScreen(this.map);

  @override
  _UpdateConteneurScreenState createState() => _UpdateConteneurScreenState();
}

class _UpdateConteneurScreenState extends State<UpdateConteneurScreen> {
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

    referenceController = new TextEditingController(text:widget.map["reference"]);
    descriptionController = new TextEditingController(text:widget.map["description"]);
    titreController = new TextEditingController(text: widget.map["titre"]);
    temperatureController = new TextEditingController(text:widget.map["temperature"]);
    humuditeController = new TextEditingController(text:widget.map["humidite"]);
    var tab=widget.map["coordonne_Gps"].split("|");
    String x=tab[0].trim();
    String y=tab[1].trim();
    xController = new TextEditingController(text:x);
    yController = new TextEditingController(text:y);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: myAppBar("Mise à jour Conteneur Ref° " + widget.map["reference"]),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:45.0),
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
                                    "Modifier", updateClient, Colors.blueGrey, context),
                                SizedBox(
                                  height: 10,
                                ),
                                myButton(
                                    "Supprimer", supprimerClient, Colors.red, context)
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

  void updateClient() async {

    setState(() {
      _isLoading = true;
    });

    final url = "http://localhost:8080/api/conteneurs/UpdateConteneur";
    final body=jsonEncode(<String, String>{
      "id":widget.map["id"].toString(),
      "reference": referenceController.text,
      "titre": titreController.text,
      "description": descriptionController.text,
      "temperature": temperatureController.text,
      "humidite": humuditeController.text,
      "coordonne_Gps": xController.text + " | " + yController.text
    });
    print(body);
    try {

      var res = await http.put(Uri.parse(url),
          headers: <String, String>{
            'Authorization': 'Bearer ${global.token}',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Access-Control-Allow-Origin": "*",
          },
          body: body,
          encoding: Utf8Codec());
      if (res.statusCode == 200) {

        showDialog(
            context: context,
            builder: (ctxt) {
              return AlertDialog(
                content: Text(
                  res.body,
                  style: GoogleFonts.lato(),

                ),
                actions: [
                  GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("ok",style: TextStyle(color: Colors.blue),),
                      ),
                      onTap: () {
                        Navigator.pop(ctxt);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ConteneurScreen()));

                      }
                  )
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

  Future<void> supprimerClient() async {
    setState(() {
      _isLoading = true;
    });
    final url = "http://localhost:8080/api/conteneurs/DeleteConteneur/" +
        widget.map["id"].toString();
    try {
      var res = await http.delete(Uri.parse(url), headers: <String, String>{
        'Authorization': 'Bearer ${global.token}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      });
      print(res.body + " " + res.statusCode.toString());
      if (res.statusCode == 200) {
        showDialog(
            context: context,
            builder: (ctxt) {
              return AlertDialog(
                content: Text(
                  res.body,
                  style: GoogleFonts.lato(),
                ),
                actions: [
                  GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("ok",style: TextStyle(color: Colors.blue),),
                      ),
                      onTap: () {
                        Navigator.pop(ctxt);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ConteneurScreen()));

                      }
                  )
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
