import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_colis/views/colisScreen.dart';
import 'package:gestion_colis/widgets/appBar.dart';
import 'package:gestion_colis/widgets/myButton.dart';
import 'package:gestion_colis/widgets/textFormField.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gestion_colis/outils/globals.dart' as global;

import '../models.dart';

class AddColisScreen extends StatefulWidget {
  @override
  _AddColisScreenState createState() => _AddColisScreenState();
}

class _AddColisScreenState extends State<AddColisScreen> {
  var nomController;
   List<Client>? _items;
   List<Conteneur>? _itemsConteneur;
  var detailController;
  var dateController;
  var flamableController;
  var temperatureController;
  var humiditeController;
  var poidsController;

  bool _isLoading = false;
  int _step = 0;
  Client? _client;
  Conteneur? _conteneur;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nomController = TextEditingController();
    detailController = TextEditingController();
    dateController = TextEditingController();
    flamableController = TextEditingController();
    temperatureController = TextEditingController();
    humiditeController = TextEditingController();
    poidsController = TextEditingController();
    getListConteneur();
    getListClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Formulaire colis"),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              (_step > 0)
                  ? Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_step >= 0) _step--;
                            });
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 50,
                            color: Colors.teal,
                          )))
                  : SizedBox.shrink(),
              Expanded(
                flex: 9,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 60.0, left: 100, right: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            child: Text(
                              "1",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            radius: 30,
                            backgroundColor:
                                (_step >= 0) ? Colors.teal : Colors.grey[400],
                          ),
                          Expanded(
                              child: Container(
                            width: 100,
                            height: 2,
                            color: (_step > 0) ? Colors.teal : Colors.grey[400],
                          )),
                          CircleAvatar(
                            child: Text(
                              "2",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            radius: 30,
                            backgroundColor:
                                (_step >= 1) ? Colors.teal : Colors.grey[400],
                          ),
                          Expanded(
                              child: Container(
                            width: 100,
                            height: 2,
                            color: (_step > 1) ? Colors.teal : Colors.grey[400],
                          )),
                          CircleAvatar(
                            child: Text(
                              "3",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            radius: 30,
                            backgroundColor:
                                (_step >= 2) ? Colors.teal : Colors.grey[400],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        width: 1000,
                        child: Card(
                          child: Column(
                            children: [
                              switchContainer(),
                              (_step == 2)
                                  ? Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(width:400,child: myButton("sauvgarder", addColis, Colors.blueGrey, context)),
                                  )
                                  : SizedBox.shrink()
                            ],
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              (_step <=2)
                  ? Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_step < 2) _step++;
                            });
                          },
                          icon: Icon(
                            Icons.navigate_next,
                            size: 80,
                            color: Colors.teal,
                          )))
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  Widget containerInfo() {
    return Column(
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

              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget containerClient() {
    return Column(
      children: [
        _isLoading ? LinearProgressIndicator() : SizedBox.shrink(),
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
    );
  }
  Widget containerConteneur() {
    return Column(
      children: [
        _isLoading ? LinearProgressIndicator() : SizedBox.shrink(),
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
 Widget switchContainer(){
    Widget? w;
    switch(_step){
      case 0:w=containerInfo();break;
      case 1:w=containerClient();break;
      case 2:w=containerConteneur();break;
    }
    return w!;

  }
  void addColis() async {
    setState(() {
      _isLoading = true;
    });
    final url = "http://localhost:8080/api/colis/SaveColis";
    try {
      final header=<String, dynamic>{
        "nom": nomController.text,
        "detail": detailController.text,
        "dateReception": dateController.text,
        "temperatureIdial": temperatureController.text,
        "flamable": flamableController.text,
        "poids": poidsController.text,
        "client": _client!.toJson(),
        "conteneur": _conteneur!.toJson()
      };
      print(header);
      var res = await http.post(Uri.parse(url),
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
