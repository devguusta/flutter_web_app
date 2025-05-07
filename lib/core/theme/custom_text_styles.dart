import 'package:flutter/material.dart';
import 'package:flutter_web_app/core/theme/colors.dart';
import 'package:flutter_web_app/core/theme/sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyles {
  CustomTextStyles({
    required this.sizes,
    required this.colors,
  });

  final CustomSizes sizes;
  final CustomColors colors;

  TextStyle get heading1 => GoogleFonts.kanit(
        fontSize: 56,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );
  TextStyle get heading2 => GoogleFonts.kanit(
        fontSize: 48,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  TextStyle get heading3 => GoogleFonts.kanit(
        fontSize: 40,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  TextStyle get heading4 => GoogleFonts.kanit(
        fontSize: 32,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  TextStyle get heading5 => GoogleFonts.kanit(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  TextStyle get heading6 => GoogleFonts.kanit(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  TextStyle get body => GoogleFonts.kanit(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );
  TextStyle get subtitle => GoogleFonts.kanit(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );
  TextStyle get button => GoogleFonts.kanit(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );
  TextStyle get caption => GoogleFonts.kanit(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );
}
