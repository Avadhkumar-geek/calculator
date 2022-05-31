import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

class MyCalc extends StatelessWidget {
  const MyCalc({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: GoogleFonts.lato().fontFamily,
          textTheme: const TextTheme(
              subtitle1: TextStyle(fontWeight: FontWeight.w100, fontSize: 80),
              subtitle2: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 40,
                  color: Colors.blueGrey))),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var usrInput = '';
  var usrAns = '';

  TextStyle len() {
    if (usrInput.length > 11) {
      TextStyle l = const TextStyle(
        fontSize: 40,
      );
      return l;
    }
    if (usrInput.length > 8) {
      TextStyle l = const TextStyle(
        fontSize: 60,
      );
      return l;
    }

    TextStyle l = const TextStyle(
      fontSize: 80,
    );
    return l;
  }

  final List<String> buttons = [
    'AC',
    'DEL',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    '00',
    '=',
  ];

  Color colors(String item) {
    if (item == '+' ||
        item == '=' ||
        item == '-' ||
        item == '%' ||
        item == '÷' ||
        item == '×') {
      return const Color.fromARGB(255, 245, 215, 176);
    } else if (item == 'AC' || item == 'DEL') {
      return const Color.fromARGB(255, 198, 212, 158);
    }
    return const Color.fromARGB(255, 247, 237, 228);
  }

  double eval() {
    String expr1 = usrInput.replaceAll('÷', '/');
    String expr = expr1.replaceAll('×', '*');
    Parser p = Parser();
    Expression exp = p.parse(expr);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    return eval;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 225, 212),
      body: Center(
        child: Column(
          children: <Widget>[
            // Screen
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 80,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,

                    // User Expression

                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        usrInput,
                        style: len(),
                      ),
                    ),
                  ),

                  // Answer
                  Container(
                    padding: const EdgeInsets.only(right: 8),
                    alignment: Alignment.centerRight,
                    child: Text(
                      usrAns,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
            ),

            // NumPad
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int item) {
                      // AC Button
                      if (item == 0) {
                        return MyButton(
                            buttonTapped: () {
                              setState(() {
                                usrInput = '';
                                usrAns = '';
                              });
                            },
                            color: colors(buttons[item]),
                            textColor: Colors.black,
                            text: buttons[item]);
                      }

                      // DEL Button
                      else if (item == 1) {
                        return MyButton(
                            buttonTapped: () {
                              setState(() {
                                usrInput =
                                    usrInput.substring(0, usrInput.length - 1);
                              });
                            },
                            color: colors(buttons[item]),
                            textColor: Colors.black,
                            text: buttons[item]);
                      }

                      // = Button
                      else if (item == buttons.length - 1) {
                        return MyButton(
                            buttonTapped: () {
                              setState(() {
                                usrAns = eval().toString().replaceAll('.0', '');
                              });
                            },
                            color: colors(buttons[item]),
                            textColor: Colors.black,
                            text: buttons[item]);
                      }

                      // All Other Buttons
                      else {
                        return MyButton(
                            buttonTapped: () {
                              setState(() {
                                usrInput += buttons[item];
                              });
                            },
                            color: colors(buttons[item]),
                            textColor: Colors.black,
                            text: buttons[item]);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
