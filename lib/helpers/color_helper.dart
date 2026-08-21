
import 'package:flutter/material.dart';

class ColorHelper {

  static Color colorPorTipo(String tipo) {
    const colores = {
      'fire': Colors.deepOrange,
      'water': Colors.blue,
      'grass': Colors.green,
      'electric': Colors.amber,
      'psychic': Colors.pink,
      'steel': Colors.blueGrey,
      'ghost': Colors.deepPurple,
      'normal': Colors.brown,
      'poison': Colors.purple,
      'rock': Colors.grey,
    };
    return colores[tipo] ?? Colors.teal;
  }
}