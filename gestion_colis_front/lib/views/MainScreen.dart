import 'package:flutter/material.dart';
import 'package:gestion_colis/widgets/appBar.dart';
import 'package:gestion_colis/widgets/drawerMenu.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(""),
        drawer: myDrawer(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                odds(Colors.teal, Icons.person_outline, "Total users 20"),
                odds(Colors.orange, Icons.title, "Total conteneurs 40"),
                odds(Colors.blueGrey, Icons.settings, "Total colis 30"),
                odds(Colors.lightBlue, Icons.ac_unit, "Total insident 20")
              ],
            ),
          ),
        ));
  }

  Widget odds(Color color, IconData iconData, String title) {
    return SizedBox(
      height: 200,
      width: 400,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 80,
            ),
            Text(
              title,
              style: GoogleFonts.lato(color: Colors.white),
            )
          ],
        ),
        color: color,
      ),
    );
  }
}
