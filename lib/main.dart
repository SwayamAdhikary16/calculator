import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Calculatori(),
    );
  }
}

class Calculatori extends StatefulWidget {
  const Calculatori({super.key});

  @override
  State<Calculatori> createState() => _CalculatoriState();
}

class _CalculatoriState extends State<Calculatori> {
  //variables
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var opr = '';
  var hideInput = false;
  var os = 40.0;

  onButtonClick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "⌫") {
      input = input.substring(0, input.length - 1);
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        os = 60.0;
      }
    } else {
      input = input + value;
      hideInput = false;
      os = 40;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              color: Colors.black26,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: os,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
//------------------------------------------------------------------------------------------------------------------------------
// Button Area
//-----------------------------------------------------------------------------------------------------------------------------
          Row(
            children: [
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.all(23),
                              backgroundColor: Color(0xff191919)),
                          onPressed: () => onButtonClick("AC"),
                          child: const Text(
                            "AC",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange,
                            ),
                          )))),
              button(text: "⌫"),
              button(text: "%"),
              button(text: "÷")
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x")
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-")
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+")
            ],
          ),
          Row(
            children: [
              button(text: "."),
              button(text: "0"),
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.all(23),
                              backgroundColor: Colors.orange),
                          onPressed: () => onButtonClick("="),
                          child: const Text(
                            "=",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ))))
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text}) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xff191919)),
                onPressed: () => onButtonClick(text),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ))));
  }
}
