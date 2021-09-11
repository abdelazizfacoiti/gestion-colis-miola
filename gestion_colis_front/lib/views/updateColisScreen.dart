import 'package:flutter/material.dart';
import 'package:gestion_colis/models.dart';
import 'package:gestion_colis/widgets/appBar.dart';
import 'package:gestion_colis/widgets/myButton.dart';
import 'package:gestion_colis/widgets/textFormField.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gestion_colis/outils/globals.dart' as global;

import 'colisScreen.dart';
class UpdateColisScreen extends StatefulWidget {

  var map;

  UpdateColisScreen(this.map);

  @override
  _UpdateColisScreenState createState() => _UpdateColisScreenState();
}

class _UpdateColisScreenState extends State<UpdateColisScreen> {

  var nomController;
  List<Client>? _items;
  List<Conteneur>? _itemsConteneur;
  var detailController;
  var dateController;
  var flamableController;
  var temperatureController;
  var humiditeController;
  var poidsController;
  Client? _client;
  Conteneur? _conteneur;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nomController = TextEditingController(text: widget.map["nom"]);
    detailController = TextEditingController(text: widget.map["detail"]);
    dateController = TextEditingController(text: widget.map["dateReception"]);
    flamableController = TextEditingController(text: widget.map["flamable"].toString());
    temperatureController = TextEditingController(text: widget.map["temperatureIdial"].toString());
    humiditeController = TextEditingController(text: widget.map["humidite"].toString());
    poidsController = TextEditingController(text: widget.map["poids"].toString());
    getListClient();
    getListConteneur();

  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: myAppBar("Mise à jour du colis"),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Card(child: Center(
                      child: Container(width: 400,height: 300,
                      child: Column(
                        children: [
                          _isLoading ? LinearProgressIndicator() : SizedBox.shrink(),
                          Text("Info Client",style: GoogleFonts.lato(fontSize: 14),),
                          Padding(
                            padding: const EdgeInsets.only(right: 19.0, left: 19.0, bottom: 19.0),
                            child: Form(
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButton<Client>(
                                        value: _client,
                                        onChanged: (client){
                                          setState(() {
                                            _client=client;
                                          });

                                        },
                                        items: _items
                                        !.map<DropdownMenuItem<Client>>(
                                                (e) => DropdownMenuItem<Client>(
                                              value: e,
                                              child: Text(e.cin!),
                                            ))
                                            .toList()),
                                  ),
                                  Table(

                                    children: [
                                      TableRow(children: [
                                        Text("Cin",style: TextStyle(color: Colors.blueGrey),),
                                        Text(_client!.cin!),
                                      ]),
                                      TableRow(children: [
                                        Text("Nom",style: GoogleFonts.lato(color: Colors.blueGrey),),
                                        Text(_client!.nom!,style: GoogleFonts.lato(),),
                                      ]),
                                      TableRow(children: [
                                        Text("Prenom",style: GoogleFonts.lato(color: Colors.blueGrey),),
                                        Text(_client!.prenom!,style: GoogleFonts.lato(),),
                                      ]),
                                      TableRow(children: [
                                        Text("Addresse",style: GoogleFonts.lato(color: Colors.blueGrey),),
                                        Text(_client!.addresse!,style: GoogleFonts.lato(),),
                                      ]),
                                      TableRow(children: [
                                        Text("Ville",style: GoogleFonts.lato(color: Colors.blueGrey),),
                                        Text(_client!.ville!,style: GoogleFonts.lato(),),
                                      ]),
                                      TableRow(children: [
                                        Text("Tel",style: GoogleFonts.lato(color: Colors.blueGrey),),
                                        Text(_client!.tel!,style: GoogleFonts.lato(),),
                                      ])

                                    ],)

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      ),
                    ),

                    )),


                    Expanded(
                      child: Card(
                        child: Column(
                          children: [
                            _isLoading ? LinearProgressIndicator() : SizedBox.shrink(),

                            Padding(
                              padding: const EdgeInsets.only(right: 19.0, left: 19.0, bottom: 19.0),
                              child: Form(
                                child: Column(
                                  children: [
                                    myTextField(Icons.label, "nom", nomController),
                                    myTextField(Icons.title, "detail", detailController),
                                    myTextField(Icons.update, "date réception", dateController),
                                    myTextField(Icons.wb_sunny, "flamable", flamableController),
                                    myTextField(
                                        Icons.wb_sunny, "temperature ideal", temperatureController),
                                    myTextField(
                                        Icons.ac_unit, "humidite ideal", humiditeController),
                                    myTextField(Icons.ac_unit, "poids", poidsController),
                                    SizedBox(height: 20,),
                                    myButton("modifier", updateColis, Colors.blueGrey, context),
                                    SizedBox(height: 5,),
                                    myButton("supprimer", updateColis, Colors.red, context),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(child: Card(child: Center(
                      child: Container(width: 400,height: 300,
                      child: Column(
                        children: [

                          _isLoading ? LinearProgressIndicator() : SizedBox.shrink(),
                          Text("Info Contneur",style: GoogleFonts.lato(fontSize: 14),),
                          Padding(
                            padding: const EdgeInsets.only(right: 19.0, left: 19.0, bottom: 19.0),
                            child: Form(
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButton<Conteneur>(
                                        value: _conteneur,
                                        onChanged: (c){
                                          setState(() {
                                            _conteneur=c;
                                          });

                                        },
                                        items: _itemsConteneur
                                        !.map<DropdownMenuItem<Conteneur>>(
                                                (e) => DropdownMenuItem<Conteneur>(
                                              value: e,
                                              child: Text(e.reference),
                                            ))
                                            .toList()),
                                  ),
                                  Table(

                                    children: [
                                      TableRow(children: [
                                        Text("Reference",style: TextStyle(color: Colors.blueGrey),),
                                        Text(_conteneur!.reference),
                                      ]),
                                      TableRow(children: [
                                        Text("titre",style: GoogleFonts.lato(color: Colors.blueGrey),),
                                        Text(_conteneur!.titre,style: GoogleFonts.lato(),),
                                      ]),
                                      TableRow(children: [
                                        Text("description",style: GoogleFonts.lato(color: Colors.blueGrey),),
                                        Text(_conteneur!.description,style: GoogleFonts.lato(),),
                                      ]),
                                      TableRow(children: [
                                        Text("temperature",style: GoogleFonts.lato(color: Colors.blueGrey),),
                                        Text(_conteneur!.temperature,style: GoogleFonts.lato(),),
                                      ]),
                                      TableRow(children: [
                                        Text("humidite",style: GoogleFonts.lato(color: Colors.blueGrey),),
                                        Text(_conteneur!.humidite,style: GoogleFonts.lato(),),
                                      ]),
                                      TableRow(children: [
                                        Text("coordonne_Gps",style: GoogleFonts.lato(color: Colors.blueGrey),),
                                        Text(_conteneur!.coordonneGps,style: GoogleFonts.lato(),),
                                      ])

                                    ],)

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      ),
                    ),

                    )),
                  ],
                ),
              ),
            ),
          ),
        ),





      );
  }
  void getListConteneur() async {
    var url = "http://localhost:8080/api/conteneurs/GetConteneurs";
    try {
      var res = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': 'Bearer ${global.token}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Access-Control-Allow-Origin": "*",
        },
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        setState(() {

          _itemsConteneur = data.map<Conteneur>((e) => Conteneur.fromJson(e)).toList();
          _conteneur=_itemsConteneur![0];
        });
      }
    } catch (_) {
      print("erreor");
    }
  }
  void getListClient() async {
    var url = "http://localhost:8080/api/clients/GetClients";
    try {
      var res = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': 'Bearer ${global.token}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Access-Control-Allow-Origin": "*",
        },
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        setState(() {
          _items = data.map<Client>((e) => Client.fromJson(e)).toList();
          _client=_items![0];
        });
      }
    } catch (_) {
      print("erreor");
    }
  }
  void updateColis() async {
    setState(() {
      _isLoading = true;
    });
    final url = "http://localhost:8080/api/colis/UpdateColis";
    try {
      final header=<String, dynamic>{
        "id": widget.map["id"],
        "nom": nomController.text,
        "detail": detailController.text,
        "dateReception": dateController.text,
        "temperatureIdial": temperatureController.text,
        "flamable": flamableController.text,
        "poids": poidsController.text,
        "client": _client!.toJson(),
        "conteneur": _conteneur!.toJson()
      };
      print(jsonEncode(header));
      var res = await http.put(Uri.parse(url),
          headers: <String, String>{
            'Authorization': 'Bearer ${global.token}',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Access-Control-Allow-Origin": "*",
          },
          body: jsonEncode(header),

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
                                builder: (context) => ColisScreen()));
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
