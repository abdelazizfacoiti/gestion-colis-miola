import 'package:flutter/material.dart';

Widget myButton(String text,onPressed,color,context){
  return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,child: ElevatedButton(

    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<
            RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(18.0),
            ))),
    child: Text(text),
    onPressed: onPressed,
  ));
}