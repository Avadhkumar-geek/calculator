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
              subtitle2: TextStyle(
            fontWeight: FontWeight.w100,
            fontSize: 38,
            color: Color.fromRGBO(30, 125, 125, 1),
          ))),
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
  var lastChar = '';

  TextStyle len() {
    if (usrInput.length > 11) {
      TextStyle l = const TextStyle(
        color: Color.fromRGBO(243, 230, 0, 1),
        fontSize: 38,
      );
      return l;
    }
    if (usrInput.length > 8) {
      TextStyle l = const TextStyle(
        color: Color.fromRGBO(243, 230, 0, 1),
        fontSize: 49,
      );
      return l;
    }

    TextStyle l = const TextStyle(
      color: Color.fromRGBO(243, 230, 0, 1),
      fontSize: 60,
    );
    return l;
  }

  final List<String> buttons = [
    'AC',
    '⌫',
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

  bool isChar(String item) {
    if (item == '+' ||
        item == '=' ||
        item == '-' ||
        item == '%' ||
        item == '÷' ||
        item == '×') {
      return true;
    }
    return false;
  }

  double eval() {
    String expr2 = usrInput.replaceAll('%', '*(1/100)');
    String expr1 = expr2.replaceAll('÷', '/');
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
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(19, 99, 119, 0),
        actions: <Widget>[
          PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: Color.fromRGBO(243, 230, 0, 1),
              ),
              color: const Color.fromRGBO(108, 140, 156, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  const Color.fromRGBO(108, 140, 156, 1),
                              title:
                                  const Center(child: Text('Privacy Policy')),
                              content: Padding(
                                padding: const EdgeInsets.all(10),
                                child: RichText(
                                    text: const TextSpan(children: [
                                  TextSpan(
                                    text: 'Information Collection and Use\n',
                                    style: TextStyle(
                                        color: Color.fromRGBO(243, 230, 0, 1),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      style: TextStyle(
                                        color: Color.fromRGBO(243, 230, 0, 1),
                                      ),
                                      text:
                                          'For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.\nThe app does use third party services that may collect information used to identify you.\n\n'),
                                  TextSpan(
                                      text: 'Log Data\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(243, 230, 0, 1))),
                                  TextSpan(
                                      style: TextStyle(
                                        color: Color.fromRGBO(243, 230, 0, 1),
                                      ),
                                      text:
                                          'I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.\n\n'),
                                  TextSpan(
                                      text: 'Cookies\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(243, 230, 0, 1))),
                                  TextSpan(
                                      style: TextStyle(
                                        color: Color.fromRGBO(243, 230, 0, 1),
                                      ),
                                      text:
                                          "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory."),
                                ])),
                              ),
                            );
                          }),
                      child: const Text(
                        'Privacy Policy',
                      ),
                    ),
                    PopupMenuItem<String>(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Image.asset('assets/icon/babg_logo.png'),
                              content: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                    'BΔBG Corporation is a group of IT professionals enthusiastic in creating free quality tools and content on the Internet.\n\n©2022 All Rights Reserved.'),
                              ),
                            );
                          }),
                      child: const Text('About'),
                    ),
                  ])
        ],
      ),
      backgroundColor: const Color.fromRGBO(13, 53, 76, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // Screen
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,

                  // User Expression
                  child: Container(
                    height: 76,
                    padding: const EdgeInsets.only(right: 8),
                    alignment: Alignment.centerRight,
                    child: Text(
                      usrInput,
                      style: len(),
                    ),
                  ),
                ),

                //Answer
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: const EdgeInsets.only(right: 8),
                      alignment: Alignment.centerRight,
                      child: Text(
                        usrAns,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // NumPad
          Container(
            height: 413,
            color: const Color.fromRGBO(0, 0, 0, 0.3),
            child: Center(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 100 / 85,
                    crossAxisCount: 4,
                    mainAxisSpacing: 0),
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
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
                        color: const Color.fromRGBO(50, 84, 99, 1),
                        textColor: const Color.fromRGBO(100, 200, 220, 1),
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
                        color: const Color.fromRGBO(50, 84, 99, 1),
                        textColor: const Color.fromRGBO(100, 200, 220, 1),
                        text: buttons[item]);
                  }

                  // '=' Button
                  else if (item == buttons.length - 1) {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            usrAns = eval().toString().replaceAll('.0', '');
                            usrInput = usrAns;
                          });
                        },
                        color: const Color.fromRGBO(243, 230, 0, 1),
                        textColor: const Color.fromRGBO(13, 53, 76, 1),
                        text: buttons[item]);
                  }

                  //'%' button
                  else if (item == 2) {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            lastChar = buttons[item];
                            if (isChar(usrInput[usrInput.length - 1])) {
                              usrInput =
                                  usrInput.substring(0, usrInput.length - 1) +
                                      buttons[item];
                            } else {
                              usrInput += buttons[item];
                            }
                            usrAns = eval().toString().replaceAll('.0', '');
                          });
                        },
                        color: const Color.fromRGBO(0, 0, 0, 0.75),
                        textColor: const Color.fromARGB(255, 233, 77, 49),
                        text: buttons[item]);
                  }

                  // Characters
                  else if (isChar(buttons[item])) {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            lastChar = buttons[item];
                            //isChar(usrInput[usrInput.length - 1])
                            if (usrInput[usrInput.length - 1] == '+' ||
                                usrInput[usrInput.length - 1] == '-') {
                              usrInput =
                                  usrInput.substring(0, usrInput.length - 1) +
                                      buttons[item];
                            } else {
                              usrInput += buttons[item];
                            }
                          });
                        },
                        color: const Color.fromRGBO(0, 0, 0, 0.75),
                        textColor: const Color.fromARGB(255, 233, 77, 49),
                        text: buttons[item]);
                  }

                  // All Other Buttons
                  else {
                    return MyButton(
                        buttonTapped: () {
                          setState(() {
                            lastChar = buttons[item];
                            usrInput += buttons[item];
                            usrAns = eval().toString();
                          });
                        },
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        textColor: const Color.fromARGB(255, 233, 77, 49),
                        text: buttons[item]);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
