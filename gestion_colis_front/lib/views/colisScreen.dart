import 'package:gestion_colis/widgets/appBar.dart';
import 'dart:convert';
import 'dart:math';
import 'package:data_tables/data_tables.dart';
import 'package:gestion_colis/widgets/textFormField.dart';
import 'package:http/http.dart' as http;
import 'package:gestion_colis/outils/globals.dart' as global;
import 'package:flutter/material.dart';

import 'addColis.dart';
import 'addConteneurScren.dart';

class ColisScreen extends StatefulWidget {
  @override
  _ColisScreenState createState() => _ColisScreenState();
}

class _ColisScreenState extends State<ColisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: myAppBar("Gestion Colis"),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(50.0),
        child: FloatingActionButton(
          onPressed: () async => await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AddColisScreen())),
          backgroundColor: Colors.blueGrey,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: JsonExample(),
    );
  }
}

class JsonExample extends StatefulWidget {
  @override
  _JsonExampleState createState() => _JsonExampleState();
}

class _JsonExampleState extends State<JsonExample> {
  int _rowsPerPage = 100;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  List<Map<String, dynamic>> _items = [];
  int _rowsOffset = 0;
  var jsonData;
  var list;

  @override
  void initState() {
    super.initState();
    getListColis();
  }

  int index = 0;
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _rows = min(40, _items.length);
    return Center(
      child: SizedBox(
        height: 400,
        width: 1100,
        child: Card(
          child: Column(
            children: [
              Center(
                  child: Container(
                   padding: EdgeInsets.all(30),
                      child: myTextField(
                          Icons.search, "Chercher", searchController))),
             
              Expanded(

                child: Container(
                  child: _items == null || _items.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : NativeDataTable.fromJson(
                          tag: "ColisScreen",
                          context: context,
                          showSelect: false,
                          showSort: false,
                          items: _items,
                          firstRowIndex: index,
                          rowsPerPage: _rows,
                          handleNext: () {
                            if (mounted) {
                              setState(() {
                                if (index == _items.length - 1) {
                                  index = _items.length - 1;
                                } else {
                                  index += _rows;
                                }
                              });
                            }
                          },
                          handlePrevious: () {
                            if (mounted) {
                              setState(() {
                                if (index == 0) {
                                  index = 0;
                                } else {
                                  index -= _rows;
                                }
                              });
                            }
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getListColis() async {
    var url = "http://localhost:8080/api/colis/GetColis";
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
          _items = List.from(data);
        });
      }
    } catch (_) {
      print("erreor");
    }
  }
}
