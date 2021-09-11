import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextFormField myTextField(IconData iconData,String label,TextEditingController controller){

  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.lato(fontSize: 12),
      prefixIcon: Icon(iconData)

    ),
  );
}