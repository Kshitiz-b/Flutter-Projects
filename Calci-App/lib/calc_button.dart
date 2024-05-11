import 'package:flutter/material.dart';

ElevatedButton buildElevatedButton(
    String text, Color bgColour, Color fgColour, Function()? buttonPressed) {
  return ElevatedButton(
    onPressed: buttonPressed,
    style: ElevatedButton.styleFrom(
      elevation: 7.0,
      backgroundColor: bgColour,
      foregroundColor: fgColour,
      fixedSize: const Size(80, 70),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(34),
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 32.5),
    ),
  );
}
