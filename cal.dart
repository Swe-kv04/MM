import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  double num1 = 0;
  double num2 = 0;
  String operation = "";
  String result = "0";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        result = "0";
        num1 = 0;
        num2 = 0;
        operation = "";
      } else if (value == "=") {
        num2 = double.tryParse(input) ?? 0;
        if (operation == "+") result = (num1 + num2).toString();
        if (operation == "-") result = (num1 - num2).toString();
        if (operation == "*") result = (num1 * num2).toString();
        if (operation == "/")
          result = num2 != 0 ? (num1 / num2).toString() : "Error";
        input = result;
      } else if (["+", "-", "*", "/"].contains(value)) {
        num1 = double.tryParse(input) ?? 0;
        operation = value;
        input = "";
      } else {
        input += value;
        result = input;
      }
    });
  }

  Widget buildButton(String text) {
    return ElevatedButton(
      onPressed: () => onButtonPressed(text),
      child: Text(text, style: TextStyle(fontSize: 24)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Basic Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(result, style: TextStyle(fontSize: 40)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            buildButton("1"),
            buildButton("2"),
            buildButton("3"),
            buildButton("+")
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            buildButton("4"),
            buildButton("5"),
            buildButton("6"),
            buildButton("-")
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            buildButton("7"),
            buildButton("8"),
            buildButton("9"),
            buildButton("*")
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            buildButton("C"),
            buildButton("0"),
            buildButton("="),
            buildButton("/")
          ]),
        ],
      ),
    );
  }
}
