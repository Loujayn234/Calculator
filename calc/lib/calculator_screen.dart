import 'package:calc/btn_values.dart';
import 'package:flutter/material.dart';
import 'dart:math' show cos, e, log, pi, pow, sin, sqrt, tan;

class CalculatorScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const CalculatorScreen({super.key, required this.toggleTheme});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = "";
  String operand = "";
  String number2 = "";
  String advancedOperation = "";
  bool showAdvancedButtons = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.grey[850]
                : Color.fromARGB(91, 33, 149, 243),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Calculator',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.brightness_6),
                onPressed: widget.toggleTheme,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Display output
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _displayText(),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            // Toggle Advanced Buttons
            IconButton(
              icon: Icon(
                  showAdvancedButtons ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  showAdvancedButtons = !showAdvancedButtons;
                });
              },
            ),

            // Advanced buttons
            if (showAdvancedButtons)
              Wrap(
                children: Btn.buttonValuesAdvanced
                    .map((value) => SizedBox(
                          width: screenSize.width / 5,
                          height: screenSize.width / 6,
                          child: buildButton(value),
                        ))
                    .toList(),
              ),

            // Basic buttons
            Wrap(
              children: Btn.buttonValuesBasic
                  .map((value) => SizedBox(
                        width: screenSize.width / 4,
                        height: screenSize.width / 5,
                        child: buildButton(value),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Display text including advanced operation
  String _displayText() {
    if (advancedOperation == Btn.power) {
      return "$number1^$number2";
    } else if (advancedOperation == Btn.pi) {
      return pi.toString();
    } else if (advancedOperation == Btn.e) {
      return e.toString();
    } else if (advancedOperation.isNotEmpty) {
      return "$advancedOperation($number1)$operand$number2";
    }
    return "$number1$operand$number2".isEmpty
        ? "0"
        : "$number1$operand$number2";
  }

  Widget buildButton(dynamic value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: getBtnColor(value), // Use the color determined by getBtnColor
        clipBehavior: Clip.hardEdge,
        shape: CircleBorder(),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
            child: value is IconData
                ? Icon(value,
                    color: const Color.fromARGB(255, 255, 145, 0), size: 20)
                : Text(
                    value,
                    style: TextStyle(
                      color: value ==
                              Btn.calculate // Check if the button is equal
                          ? Colors
                              .black // Set text color to black for better contrast
                          : const Color.fromARGB(255, 255, 145, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void onBtnTap(dynamic value) {
    if (value == Btn.del) {
      delete();
      return;
    }
    if (value == Btn.clr) {
      clearAll();
      return;
    }
    if (value == Btn.calculate) {
      calculate();
      return;
    }

    if (Btn.buttonValuesAdvanced.contains(value)) {
      advancedOperation = value;
      if (value == Btn.pi || value == Btn.e) {
        setState(() {
          if (operand.isEmpty) {
            number1 = (value == Btn.pi) ? pi.toString() : e.toString();
          } else {
            number2 = (value == Btn.pi) ? pi.toString() : e.toString();
          }
        });
        return;
      }
      setState(() {});
      return;
    }

    appendValue(value is String ? value : '');
  }

  // Main calculation function
  void calculate() {
    if (number1.isEmpty) return;

    final num1 = double.parse(number1);
    final num2 = number2.isNotEmpty ? double.parse(number2) : null;
    double result = 0.0;

    if (advancedOperation == Btn.power && num2 != null) {
      result = pow(num1, num2).toDouble();
    } else if (advancedOperation.isNotEmpty) {
      result = performAdvancedCalculation(num1, advancedOperation);
    } else if (operand.isNotEmpty && num2 != null) {
      result = performBasicOperation(num1, num2);
    }

    setState(() {
      number1 = (result % 1 == 0
          ? result.toInt().toString()
          : result.toStringAsPrecision(3));
      operand = "";
      number2 = "";
      advancedOperation = "";
    });
  }

  double performBasicOperation(double num1, double num2) {
    switch (operand) {
      case Btn.add:
        return num1 + num2;
      case Btn.subtract:
        return num1 - num2;
      case Btn.multiply:
        return num1 * num2;
      case Btn.divide:
        return num2 != 0 ? num1 / num2 : 0.0;
      default:
        return 0.0;
    }
  }

  double performAdvancedCalculation(double value, String operation) {
    switch (operation) {
      case Btn.sin:
        return sin(value * pi / 180);
      case Btn.cos:
        return cos(value * pi / 180);
      case Btn.tan:
        return tan(value * pi / 180);
      case Btn.log:
        return log(value) / log(10);
      case Btn.sqrt:
        return sqrt(value);
      default:
        return value;
    }
  }

  Color getBtnColor(dynamic value) {
    if (value == Btn.calculate) {
      // Yellow color for the equal button
      return const Color.fromARGB(255, 255, 145, 0);
    } else if (value == Btn.clr || value == Btn.del) {
      return const Color.fromARGB(147, 158, 158, 158);
    }
    // Default color for other buttons
    return const Color.fromARGB(148, 0, 24, 80);
  }

  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (operand.isEmpty) operand = value;
    } else if (operand.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      number1 += value;
    } else {
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      number2 += value;
    }

    setState(() {});
  }

  void clearAll() {
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
      advancedOperation = "";
    });
  }

  void delete() {
    setState(() {
      if (number2.isNotEmpty) {
        number2 = number2.substring(0, number2.length - 1);
      } else if (operand.isNotEmpty) {
        operand = "";
      } else if (number1.isNotEmpty) {
        number1 = number1.substring(0, number1.length - 1);
      }
    });
  }
}
