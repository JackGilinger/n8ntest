import 'package:flutter/material.dart';
import 'math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorApp extends StatefulWidget {
  CalculatorApp({super.key});

  @override
  CalculatorAppState createState() => CalculatorAppState();
}

class CalculatorAppState extends State<CalculatorApp> {
  String input = "";

  buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = "";
      } else if (value == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(input);
          ContextModel cm = ContextModel();
          input = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          input = "Error";
        }
      } else {
        input += value;
      }
    });
  }

  Widget buildButton(String buttonValue) {
    return Expanded(
      child: MaterialButton(
        padding: EdgeInsets.all(20.0),
        child: Text(
          buttonValue,
          style: TextStyle(fontSize: 24.0),
        ),
        color: Colors.blueAccent,
        textColor: Colors.white,
        onPressed: () => buttonPressed(buttonValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(input, style: TextStyle(fontSize: 32)),
          ),
          Expanded(child: Divider()),
          Column(children: [
            Row(children: ['C', '/', '*', '-'].map(buildButton).toList()),
            Row(children: ['7', '8', '9', '+'].map(buildButton).toList()),
            Row(children: ['4', '5', '6', '='].map(buildButton).toList()),
            Row(children: ['1', '2', '3', '0', '.'].map(buildButton).toList())
          ]),
        ],
      ),
    );
  }
}