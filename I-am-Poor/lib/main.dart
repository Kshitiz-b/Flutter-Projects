import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.brown[400],
      appBar: AppBar(
        backgroundColor: Colors.brown[900],
        title: const Text('I AM POOR!!'),
      ),
      body: const Center(
        child: Image(
          image: AssetImage('images/poor_house.jpg'),
        ),
      ),
    ),
  ));
}
