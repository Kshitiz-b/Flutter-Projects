import 'package:flutter/material.dart';
import 'calculator_screen.dart';

void main() {
  runApp(const Calci());
}

class Calci extends StatelessWidget {
  const Calci({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorScreen(),
    );
  }
}
