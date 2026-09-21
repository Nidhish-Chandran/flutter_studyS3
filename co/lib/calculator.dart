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
      title: 'Calculator',
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
  String display = '0';

  double? firstNumber;
  String? operator;
  bool newNumber = true;

  // Number button
  void pressNumber(String number) {
    setState(() {
      if (display == '0' || newNumber) {
        display = number;
        newNumber = false;
      } else {
        display += number;
      }
    });
  }

  // Decimal button
  void pressDecimal() {
    setState(() {
      if (newNumber) {
        display = '0.';
        newNumber = false;
      } else if (!display.contains('.')) {
        display += '.';
      }
    });
  }

  // Operator button
  void pressOperator(String op) {
    setState(() {
      firstNumber = double.parse(display);
      operator = op;
      newNumber = true;
    });
  }

  // Equal button
  void calculate() {
    if (firstNumber == null || operator == null) {
      return;
    }

    double secondNumber = double.parse(display);
    double result = 0;

    switch (operator) {
      case '+':
        result = firstNumber! + secondNumber;
        break;

      case '-':
        result = firstNumber! - secondNumber;
        break;

      case '×':
        result = firstNumber! * secondNumber;
        break;

      case '÷':
        if (secondNumber == 0) {
          setState(() {
            display = 'Error';
            firstNumber = null;
            operator = null;
            newNumber = true;
          });
          return;
        }

        result = firstNumber! / secondNumber;
        break;
    }

    setState(() {
      display = result.toString();

      // Remove unnecessary .0
      if (display.endsWith('.0')) {
        display = display.substring(0, display.length - 2);
      }

      firstNumber = null;
      operator = null;
      newNumber = true;
    });
  }

  // Clear button
  void clear() {
    setState(() {
      display = '0';
      firstNumber = null;
      operator = null;
      newNumber = true;
    });
  }

  // Backspace button
  void backspace() {
    setState(() {
      if (display.length > 1) {
        display = display.substring(0, display.length - 1);
      } else {
        display = '0';
        newNumber = true;
      }
    });
  }

  // Calculator button
  Widget calculatorButton(
    String text, {
    VoidCallback? onPressed,
    bool operatorButton = false,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: SizedBox(
          height: 70,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  operatorButton ? Colors.blue : Colors.grey.shade200,
              foregroundColor:
                  operatorButton ? Colors.white : Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // Display
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  display,
                  style: const TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Calculator buttons
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [

                  // Row 1
                  Row(
                    children: [
                      calculatorButton(
                        'C',
                        onPressed: clear,
                      ),
                      calculatorButton(
                        '⌫',
                        onPressed: backspace,
                      ),
                      calculatorButton(
                        '÷',
                        onPressed: () => pressOperator('÷'),
                        operatorButton: true,
                      ),
                      calculatorButton(
                        '×',
                        onPressed: () => pressOperator('×'),
                        operatorButton: true,
                      ),
                    ],
                  ),

                  // Row 2
                  Row(
                    children: [
                      calculatorButton(
                        '7',
                        onPressed: () => pressNumber('7'),
                      ),
                      calculatorButton(
                        '8',
                        onPressed: () => pressNumber('8'),
                      ),
                      calculatorButton(
                        '9',
                        onPressed: () => pressNumber('9'),
                      ),
                      calculatorButton(
                        '-',
                        onPressed: () => pressOperator('-'),
                        operatorButton: true,
                      ),
                    ],
                  ),

                  // Row 3
                  Row(
                    children: [
                      calculatorButton(
                        '4',
                        onPressed: () => pressNumber('4'),
                      ),
                      calculatorButton(
                        '5',
                        onPressed: () => pressNumber('5'),
                      ),
                      calculatorButton(
                        '6',
                        onPressed: () => pressNumber('6'),
                      ),
                      calculatorButton(
                        '+',
                        onPressed: () => pressOperator('+'),
                        operatorButton: true,
                      ),
                    ],
                  ),

                  // Row 4
                  Row(
                    children: [
                      calculatorButton(
                        '1',
                        onPressed: () => pressNumber('1'),
                      ),
                      calculatorButton(
                        '2',
                        onPressed: () => pressNumber('2'),
                      ),
                      calculatorButton(
                        '3',
                        onPressed: () => pressNumber('3'),
                      ),
                      calculatorButton(
                        '=',
                        onPressed: calculate,
                        operatorButton: true,
                      ),
                    ],
                  ),

                  // Row 5
                  Row(
                    children: [
                      calculatorButton(
                        '0',
                        onPressed: () => pressNumber('0'),
                      ),
                      calculatorButton(
                        '.',
                        onPressed: pressDecimal,
                      ),
                      calculatorButton(
                        '00',
                        onPressed: () => pressNumber('00'),
                      ),
                      calculatorButton(
                        '=',
                        onPressed: calculate,
                        operatorButton: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
