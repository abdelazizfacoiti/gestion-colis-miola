import 'package:flutter/material.dart';
import 'package:gestion_colis/outils/globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget myAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.blueGrey,
    elevation: 0,
    title: Text(title,style: GoogleFonts.lato(fontSize: 23),),
    centerTitle: true,
    actions: [
      CircleAvatar(
        child: Icon(Icons.person),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              globals.userame,
              style: GoogleFonts.lato(),
            ),
            Text(
              globals.nom + " " + globals.prenom,
              style: GoogleFonts.lato(),
            ),
          ],
        ),
      )
    ],
  );
}
