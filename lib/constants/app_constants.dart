import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  // Se usa 'final' porque GoogleFonts y .shade700 se calculan en tiempo de ejecución
  static final estiloFuenteGris = GoogleFonts.poppins(color: Colors.grey[700]); 
  
  static final estiloFuenteBlanco = GoogleFonts.poppins(
    color: Colors.white, 
    fontWeight: FontWeight.bold, 
    fontSize: 12,
  ); 
  
  static final estiloFuenteGrueso = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 13,
  ); 
}
