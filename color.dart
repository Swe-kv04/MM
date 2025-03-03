import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(ColorChangerApp());
}

class ColorChangerApp extends StatefulWidget {
  @override
  _ColorChangerAppState createState() => _ColorChangerAppState();
}

class _ColorChangerAppState extends State<ColorChangerApp> {
  Color _bgColor = Colors.white;

  void _changeColor() {
    setState(() {
      _bgColor = Color.fromRGBO(
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: _bgColor,
        body: Center(
          child: ElevatedButton(
            onPressed: _changeColor,
            child: Text("Change Background Color"),
          ),
        ),
      ),
    );
  }
}
