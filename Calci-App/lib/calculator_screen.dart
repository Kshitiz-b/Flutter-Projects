import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:calci/calc_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String equation = '0';
  String result = '0';
  String expression = '';

  buttonPressed(String buttonText) {
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == 'AC') {
        equation = '0';
        result = '0';
      } else if (buttonText == '⌫') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '±') {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == '=') {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '/100');
        expression = expression.replaceAll('√', 'sqrt');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = doesContainDecimal(result);
          }
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4c4f51),
            Color(0xff434343),
            Color(0xff303335),
            Color(0xff202325),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        equation,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                        maxLines: 1,
                        minFontSize: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              result != '0' ? '= $result' : '',
                              style: TextStyle(
                                fontSize: 100,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.none,
                              ),
                              minFontSize: 10,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildElevatedButton('AC', Colors.orangeAccent,
                          Colors.white, () => buttonPressed('AC')),
                      buildElevatedButton('√', const Color(0xff845b38),
                          Colors.orangeAccent, () => buttonPressed('√')),
                      buildElevatedButton('7', const Color(0xff41403e),
                          Colors.grey.shade400, () => buttonPressed('7')),
                      buildElevatedButton('4', const Color(0xff41403e),
                          Colors.grey.shade400, () => buttonPressed('4')),
                      buildElevatedButton('1', const Color(0xff41403e),
                          Colors.grey.shade400, () => buttonPressed('1')),
                      buildElevatedButton('.', const Color(0xff41403e),
                          Colors.grey.shade400, () => buttonPressed('.')),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildElevatedButton('(', const Color(0xff845b38),
                          Colors.orangeAccent, () => buttonPressed('(')),
                      buildElevatedButton('%', const Color(0xff845b38),
                          Colors.orangeAccent, () => buttonPressed('%')),
                      buildElevatedButton('8', const Color(0xff41403e),
                          Colors.grey.shade400, () => buttonPressed('8')),
                      buildElevatedButton('5', const Color(0xff41403e),
                          Colors.grey.shade400, () => buttonPressed('5')),
                      buildElevatedButton('2', const Color(0xff41403e),
                          Colors.grey.shade400, () => buttonPressed('2')),
                      buildElevatedButton('0', const Color(0xff41403e),
                          Colors.grey.shade400, () => buttonPressed('0')),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildElevatedButton(')', const Color(0xff845b38),
                          Colors.orangeAccent, () => buttonPressed(')')),
                      buildElevatedButton('±', const Color(0xff845b38),
                          Colors.orangeAccent, () => buttonPressed('±')),
                      buildElevatedButton('9', const Color(0xff41403e),
                          Colors.grey.shade400, () => buttonPressed('9')),
                      buildElevatedButton('6', const Color(0xff41403e),
                          Colors.grey.shade400, () => buttonPressed('6')),
                      buildElevatedButton('3', const Color(0xff41403e),
                          Colors.grey.shade400, () => buttonPressed('3')),
                      buildElevatedButton('⌫', const Color(0xff2b2f2e),
                          Colors.grey.shade400, () => buttonPressed('⌫')),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildElevatedButton('×', const Color(0xff583d6e),
                          Colors.purpleAccent, () => buttonPressed('×')),
                      buildElevatedButton('÷', const Color(0xff583d6e),
                          Colors.purpleAccent, () => buttonPressed('÷')),
                      buildElevatedButton('-', const Color(0xff583d6e),
                          Colors.purpleAccent, () => buttonPressed('-')),
                      buildElevatedButton('+', const Color(0xff583d6e),
                          Colors.purpleAccent, () => buttonPressed('+')),
                      ElevatedButton(
                        onPressed: () => buttonPressed('='),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade600,
                          fixedSize: const Size(80, 150),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34.0),
                          ),
                        ),
                        child: const Text(
                          '=',
                          style: TextStyle(
                              fontSize: 32.5, fontWeight: FontWeight.w900),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
