import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_colis/views/MainScreen.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:gestion_colis/outils/globals.dart' as global;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  TextEditingController usernameController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return drawLogin(context);
  }

  Widget drawLogin(context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/logo.png",
                width: 150,
                height: 150,
              ),
              !_isLoading
                  ? Container(
                      width: 400,
                      child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: Form(
                              child: Column(
                                children: [
                                  Text(
                                    "Gestion colis",
                                    style: GoogleFonts.roboto(fontSize: 28),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.person),
                                        labelText: "Nom d'utilisateur"),
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock_outline),
                                        labelText: "Mot de passe"),
                                  ),
                                  SizedBox(
                                    height: 26,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                      child: Text('Se connecter'),
                                      onPressed: () {
                                         login(usernameController.text, passwordController.text);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "mot de passe oublié?",
                                    style: GoogleFonts.roboto(),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    )
                  : CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

  void login(String username, String password) async {

    setState(() {
      _isLoading = true;
    });
    final url = "http://localhost:8080/auth/token";

  try{

    var res = await http.post(Uri.parse(url),
        headers:<String, String> {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Access-Control-Allow-Origin": "*"
        },
        body: jsonEncode(<String,String>{
          "username": username,
          "password": password,
          "appId": "application-789",
          "customerId": "customer-456",
          "apiKey": "api-123"
        }));

    var data = jsonDecode(res.body);

    if (res.statusCode == 200) {

      global.token = data["jwsKey"];
      var userInfo = data["userEntity"];
      global.userame = userInfo["username"];
      global.nom = userInfo["nom"];
      global.prenom = userInfo["prenom"];
      global.addresse = userInfo["addresse"];
      global.loggedIn = userInfo["loggedIn"];

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MainScreen()));
    }

  }catch(_){
    setState(() {
      _isLoading=false;
    });
  }
  }
}
