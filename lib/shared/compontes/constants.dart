import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 
 String uId = '';
 void navigateTo(context, widget) =>
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=> widget));

void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(context
        , MaterialPageRoute(builder: (context)=> widget)
        , (route) => false);

Widget textStyle(
    {required String text,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    text,
    style: GoogleFonts.poppins(fontSize: fontSize),
  );
}

