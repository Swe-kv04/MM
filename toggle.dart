import 'package:flutter/material.dart';

void main() {
  runApp(ColorChangerApp());
}

class ColorChangerApp extends StatefulWidget {
  @override
  _ColorChangerAppState createState() => _ColorChangerAppState();
}

class _ColorChangerAppState extends State<ColorChangerApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: _isDarkMode ? Colors.black : Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Black & White Theme"),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
              onPressed: _toggleTheme,
            ),
          ],
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _toggleTheme,
            child: Text("Toggle Black & White Theme"),
          ),
        ),
      ),
    );
  }
}
