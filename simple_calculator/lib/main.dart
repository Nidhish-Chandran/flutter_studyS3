import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Controllers for the two input fields
  final TextEditingController number1Controller = TextEditingController();
  final TextEditingController number2Controller = TextEditingController();

  // Variable to store the result
  String result = '';

  // Addition
  void add() {
    double num1 = double.parse(number1Controller.text);
    double num2 = double.parse(number2Controller.text);

    setState(() {
      result = (num1 + num2).toString();
    });
  }

  // Subtraction
  void subtract() {
    double num1 = double.parse(number1Controller.text);
    double num2 = double.parse(number2Controller.text);

    setState(() {
      result = (num1 - num2).toString();
    });
  }

  // Multiplication
  void multiply() {
    double num1 = double.parse(number1Controller.text);
    double num2 = double.parse(number2Controller.text);

    setState(() {
      result = (num1 * num2).toString();
    });
  }

  // Division
  void divide() {
    double num1 = double.parse(number1Controller.text);
    double num2 = double.parse(number2Controller.text);

    if (num2 == 0) {
      setState(() {
        result = 'Cannot divide by zero';
      });
      return;
    }

    setState(() {
      result = (num1 / num2).toString();
    });
  }

  // Clear all fields and result
  void clear() {
    number1Controller.clear();
    number2Controller.clear();

    setState(() {
      result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: Column(
          children: [

            // First number input
            TextField(
              controller: number1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter first number',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Second number input
            TextField(
              controller: number2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter second number',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            // Operation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                  onPressed: add,
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                ElevatedButton(
                  onPressed: subtract,
                  child: const Text(
                    '-',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                ElevatedButton(
                  onPressed: multiply,
                  child: const Text(
                    '×',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                ElevatedButton(
                  onPressed: divide,
                  child: const Text(
                    '÷',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Result
            Text(
              'Result: $result',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            // Clear button
            ElevatedButton(
              onPressed: clear,
              child: const Text(
                'Clear',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    number1Controller.dispose();
    number2Controller.dispose();
    super.dispose();
  }
}