import 'package:flutter/material.dart';
import 'package:gestion_colis/outils/data.dart';
import 'package:gestion_colis/views/clientScreen.dart';
import 'package:gestion_colis/views/colisScreen.dart';
import 'package:gestion_colis/views/conteneurScreen.dart';
import 'package:gestion_colis/views/incidenceScreen.dart';
import 'package:google_fonts/google_fonts.dart';

Drawer myDrawer(context) {
  return Drawer(
    child: Container(
      color: Color(0xFF212121),
      child: ListView(
        children: fillListViewItem(context),
      ),
    ),
  );
}

fillListViewItem(context) {
  int index = 0;
  return listMenu.map((e) {
    Widget header = Container();
    if (index == 0) {
      header = DrawerHeader(
          child: Container(
              child: Image.asset(
        "images/logo.png",
        width: 100,
        height: 100,
      )));
      index = 1;
    } else
      header = Container();

    return Column(
      children: [
        header,
        ListTile(
          title: Text(e["title"],
              style: GoogleFonts.abel(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          leading: Icon(
            e["icon"],
            color: Colors.white,
          ),
          onTap: () {
            if (e["title"] == "Clients")
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ClientScren()));
            else if (e["title"] == "Conteneurs")
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ConteneurScreen()));
            else if (e["title"] == "Colis")
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ColisScreen()));
            else if (e["title"] == "Insidences")
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => IncidenceScreen()));
          },
        ),
        Divider(
          color: Colors.black54,
        )
      ],
    );
  }).toList();
}
