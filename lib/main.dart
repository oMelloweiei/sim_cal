import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  String equation = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  String operand_list = "-+/x";

  onPress(String btn_text) {
    if (btn_text == "CE") {
      equation = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (btn_text == "<-") {
      if (equation.isNotEmpty) {
        equation = equation.substring(0, equation.length - 1);
        if (equation.isEmpty) {
          equation = "0";
        }
      }
    } else if (operand_list.contains(btn_text)) {
      if (equation.isNotEmpty &&
          !operand_list.contains(equation.substring(equation.length - 1))) {
        num1 = double.parse(equation);
        operand = btn_text;
        equation = equation + btn_text;
      }
    } else if (btn_text == "=") {
      if (equation.isNotEmpty &&
          !operand_list.contains(equation.substring(equation.length - 1))) {
        num2 =
            double.parse(equation.substring(equation.lastIndexOf(operand) + 1));
        if (operand == "+") {
          equation = (num1 + num2).toString();
        } else if (operand == "-") {
          equation = (num1 - num2).toString();
        } else if (operand == "x") {
          equation = (num1 * num2).toString();
        } else if (operand == "/") {
          if (num2 != 0) {
            equation = (num1 / num2).toString();
          } else {
            equation = "Can't divide by zero";
          }
        }
      }
    } else {
      if (equation == "0") {
        equation = btn_text;
      } else {
        equation = equation + btn_text;
      }
    }
    setState(() {
      output = equation;
    });
  }

  Widget myButton(String btn_text) {
    return Expanded(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 30),
      ),
      child: Text(
        btn_text,
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        onPress(btn_text);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.amber,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                output,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                myButton("CE"),
                SizedBox(width: 10),
                myButton("<-"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                myButton("7"),
                SizedBox(width: 10),
                myButton("8"),
                SizedBox(width: 10),
                myButton("9"),
                SizedBox(width: 10),
                myButton("x"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                myButton("4"),
                SizedBox(width: 10),
                myButton("5"),
                SizedBox(width: 10),
                myButton("6"),
                SizedBox(width: 10),
                myButton("+"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                myButton("1"),
                SizedBox(width: 10),
                myButton("2"),
                SizedBox(width: 10),
                myButton("3"),
                SizedBox(width: 10),
                myButton("-"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                myButton("0"),
                SizedBox(width: 10),
                myButton("."),
                SizedBox(width: 10),
                myButton("/"),
                SizedBox(width: 10),
                myButton("="),
              ],
            ),
          ],
        ));
  }
}
