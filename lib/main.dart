import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String _output = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        if (operand.isNotEmpty) {
          _performOperation();
        }
        _output += " $buttonText ";
        operand = buttonText;
      } else if (buttonText == "=") {
        _performOperation();
        operand = "";
      } else if (buttonText == "DE") {
        if (_output.isNotEmpty) {
          _output = _output.substring(0, _output.length - 1);
        }
      } else {
        _output += buttonText;
      }
    });
  }

  bool esNumeroEntero(double numero) {
    return numero == numero.toInt();
  }

  void _performOperation() {
    if (_output.contains(" ")) {
      List<String> values = _output.split(" ");
      num1 = double.parse(values[0]);
      num2 = double.parse(values[2]);

      switch (values[1]) {
        case "+":
          _output = (num1 + num2).toString();
          break;
        case "-":
          _output = (num1 - num2).toString();
          break;
        case "*":
          _output = (num1 * num2).toString();
          break;
        case "/":
          if (num2 != 0) {
            _output = (num1 / num2).toString();
          } else {
            _output = "Error: División por cero";
          }
          break;
      }
      // Verificar si el resultado es un número entero
      if (esNumeroEntero(double.parse(_output))) {
        _output = double.parse(_output).toInt().toString();
      }
    }
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(24.0),
          textStyle:
              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => _buttonPressed(buttonText),
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Text(
              _output,
              style:
                  const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              children: <Widget>[
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/"),
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("*"),
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-"),
                buildButton("C"),
                buildButton("0"),
                buildButton("="),
                buildButton("+"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
