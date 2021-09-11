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

class UpdateClientScren extends StatefulWidget {
  final clientMap;

  UpdateClientScren(this.clientMap);

  @override
  _UpdateClientScrenState createState() => _UpdateClientScrenState();
}

class _UpdateClientScrenState extends State<UpdateClientScren> {
  var cinController;
  var nomController;
  var prenomController;
  var addresseController;
  var telController;
  var villeController;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cinController = new TextEditingController(text: widget.clientMap["cin"]);
    nomController = new TextEditingController(text: widget.clientMap["nom"]);
    prenomController =
        new TextEditingController(text: widget.clientMap["prenom"]);
    addresseController =
        new TextEditingController(text: widget.clientMap["addresse"]);
    telController = new TextEditingController(text: widget.clientMap["tel"]);
    villeController =
        new TextEditingController(text: widget.clientMap["ville"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: myAppBar("Mise à jour client " + widget.clientMap["cin"]),
      body: SingleChildScrollView(
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
                          myTextField(Icons.label, "CIN", cinController),
                          myTextField(Icons.person, "Nom", nomController),
                          myTextField(Icons.person, "Prenom", prenomController),
                          myTextField(
                              Icons.location_city, "Ville", villeController),
                          myTextField(Icons.location_city, "Addresse",
                              addresseController),
                          myTextField(Icons.label, "Tel", telController),
                          SizedBox(
                            height: 50,
                          ),
                          myButton(
                              "Modifier", addClient, Colors.blueGrey, context),
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
      )),
    );
  }

  void addClient() async {
    setState(() {
      _isLoading = true;
    });
    final url = "http://localhost:8080/api/clients/UpdateClient";
    try {
      var res = await http.put(Uri.parse(url),
          headers: <String, String>{
            'Authorization': 'Bearer ${global.token}',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Access-Control-Allow-Origin": "*",
          },
          body: jsonEncode(<String, String>{
            "cin": cinController.text,
            "nom": nomController.text,
            "prenom": prenomController.text,
            "addresse": addresseController.text,
            "ville": villeController.text,
            "tel": telController.text
          }),
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
    final url = "http://localhost:8080/api/clients/DeleteClient/" +
        widget.clientMap["cin"];
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientScren()));

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
