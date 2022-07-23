import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color lightBlue = Color.fromARGB(255, 47, 46, 86);
Color green = Color.fromARGB(255, 77, 225, 191);
Color grey = Color.fromARGB(255, 145, 143, 192);
Color blue = Color.fromARGB(255, 35, 36, 67);
Color red = Color.fromARGB(255, 225, 77, 77);

TextStyle interText(Color color, double size, [FontWeight fontWeight = FontWeight.normal]) {
  return GoogleFonts.inter(
    color: color,
    fontSize: size,
    fontWeight: fontWeight,
  );
  
  // return TextStyle(
  //   color: color,
  //   fontSize: size,
  //   fontWeight: fontWeight,
  // );
}

TextStyle poppinsText(Color color, double size, [FontWeight fontWeight = FontWeight.normal]) {
  return GoogleFonts.poppins(
    color: color,
    fontSize: size,
    fontWeight: fontWeight,
  );
  // return TextStyle(
  //   color: color,
  //   fontSize: size,
  //   fontWeight: fontWeight,
  // );
}
