import 'package:flutter/material.dart';

List<SelectColor> listColor = [
  SelectColor(Colors.white, Colors.black),
  SelectColor(Colors.black26, Colors.white),
  SelectColor(Colors.red.shade200, Colors.red.shade900),
  SelectColor(Colors.green.shade200, Colors.green.shade900),
  SelectColor(Colors.blue.shade200, Colors.blue.shade900),
  SelectColor(Colors.deepPurple.shade200, Colors.deepPurple.shade900),
];

class SelectColor {
  final Color backColor;
  final Color textColor;
  SelectColor(this.backColor, this.textColor);
}
