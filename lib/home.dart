import 'package:blue_calculator/calc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double widthButtons = 75;

  double _result = 0;
  String _expression = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF7F8FB),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 160),
            calculatorScreen(),
            const SizedBox(height: 10),
            calculatorPad()
          ],
        ));
  }

  Row calculatorPad() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          /*Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              createButton("e", const Color(0xff7CC9FF), Colors.white, 16,
                  FontWeight.normal, widthButtons, 40),
              const SizedBox(width: 20),
              createButton("µ", const Color(0xff7CC9FF), Colors.white, 16,
                  FontWeight.normal, widthButtons, 40),
              const SizedBox(width: 20),
              createButton("sin", const Color(0xff7CC9FF), Colors.white, 16,
                  FontWeight.normal, widthButtons, 40),
              const SizedBox(width: 20),
            ],
          ),*/
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              createButton("Ac", const Color(0xff858585), Colors.white, 32,
                  FontWeight.w500, widthButtons, 62),
              const SizedBox(width: 20),
              createButton("⌫", const Color(0xff858585), Colors.white, 25,
                  FontWeight.w500, widthButtons, 62),
              const SizedBox(width: 20),
              createButton(
                  "/",
                  const Color(0xff109DFF),
                  const Color(0xffADE2FF),
                  28,
                  FontWeight.w500,
                  widthButtons,
                  62),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              createButton("7", const Color(0xff38B9FF), Colors.white, 32,
                  FontWeight.w500, widthButtons, 60),
              const SizedBox(width: 20),
              createButton("8", const Color(0xff38B9FF), Colors.white, 32,
                  FontWeight.w500, widthButtons, 60),
              const SizedBox(width: 20),
              createButton("9", const Color(0xff38B9FF), Colors.white, 32,
                  FontWeight.w500, widthButtons, 60),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              createButton("4", const Color(0xff38B9FF), Colors.white, 32,
                  FontWeight.w500, widthButtons, 60),
              const SizedBox(width: 20),
              createButton("5", const Color(0xff38B9FF), Colors.white, 32,
                  FontWeight.w500, widthButtons, 60),
              const SizedBox(width: 20),
              createButton("6", const Color(0xff38B9FF), Colors.white, 32,
                  FontWeight.w500, widthButtons, 60),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              createButton("1", const Color(0xff38B9FF), Colors.white, 32,
                  FontWeight.w500, widthButtons, 60),
              const SizedBox(width: 20),
              createButton("2", const Color(0xff38B9FF), Colors.white, 32,
                  FontWeight.w500, widthButtons, 60),
              const SizedBox(width: 20),
              createButton("3", const Color(0xff38B9FF), Colors.white, 32,
                  FontWeight.w500, widthButtons, 60),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              createButton("0", const Color(0xff38B9FF), Colors.white, 32,
                  FontWeight.w500, 164, 62),
              const SizedBox(width: 20),
              createButton(".", const Color(0xff38B9FF), Colors.white, 32,
                  FontWeight.w500, widthButtons, 62),
              const SizedBox(width: 20),
            ],
          ),
        ]),
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          /*createButton("deg", const Color(0xff7CC9FF), Colors.white, 16,
              FontWeight.normal, widthButtons, 40),*/
          const SizedBox(height: 16),
          createButton("*", const Color(0xff109DFF), const Color(0xffADE2FF),
              32, FontWeight.w500, widthButtons, 62),
          const SizedBox(height: 23),
          createButton("-", const Color(0xff109DFF), const Color(0xffADE2FF),
              32, FontWeight.w500, widthButtons, 60),
          const SizedBox(height: 24),
          createButton("+", const Color(0xff109DFF), const Color(0xffADE2FF),
              32, FontWeight.w500, widthButtons, 96),
          const SizedBox(height: 27),
          createButtonEqual(),
        ])
      ],
    );
  }

  GestureDetector createButton(
      String text,
      Color textColor,
      Color backgroundColor,
      double textSize,
      FontWeight fontWeight,
      double width,
      double height) {
    return GestureDetector(
      onTap: () => calculateProcess(text),
      child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(16)),
          child: Text(text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: fontWeight,
                  fontSize: textSize))),
    );
  }

  void calculateProcess(text) {
    if (Calculator.isNumeric(text) ||
        text == '.' ||
        Calculator.isOperator(text)) {
      setState(() {
        _expression += text;
      });
    } else if (text == "Ac") {
      setState(() {
        _expression = "";
        _result = 0;
      });
    } else if (text == "⌫") {
      if (_expression.isNotEmpty) {
        setState(() {
          _expression = _expression.substring(0, _expression.length - 1);
        });
      }
    } else if (text == "=") {
      setState(() {
        _result = Calculator.calculateExpression(_expression);
        _expression = _result.toString();
      });
    }
  }

  GestureDetector createButtonEqual() {
    return GestureDetector(
      onTap: () => calculateProcess("="),
      child: Container(
          width: widthButtons,
          height: 96,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xff19ACFF),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff00A3FF),
                  spreadRadius: 0,
                  blurRadius: 23,
                  offset: Offset(-9, 13), // changes position of shadow
                ),
              ]),
          child: const Text("=",
              style: TextStyle(
                  color: Color(0xffB2DAFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 32))),
    );
  }

  Container calculatorScreen() {
    return Container(
      height: 200,
      //decoration: BoxDecoration(color: Colors.red),
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text.rich(TextSpan(
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff818181)),
              children: writtenExpression(_expression))),
          Text(
            "=$_result",
            style: const TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.w500,
                color: Color(0xff424242)),
          )
        ],
      ),
    );
  }
}

List<String> separateString(String input) {
  List<String> separatedList = [];
  String currentToken = '';

  for (int i = 0; i < input.length; i++) {
    String char = input[i];

    // Si le caractère est un opérateur arithmétique, ajoute le jeton actuel à la liste et ensuite l'opérateur
    if (char == '+' || char == '-' || char == '*' || char == '/') {
      if (currentToken.isNotEmpty) {
        separatedList.add(currentToken);
        currentToken = '';
      }
      separatedList.add(char);
    }
    // Si le caractère est un chiffre ou un point décimal, ajoute-le au jeton actuel
    else if (RegExp(r'[0-9.]').hasMatch(char)) {
      currentToken += char;
    }
    // Si le caractère est un espace, ignore-le
    else if (char == ' ') {
      continue;
    }
    // Si le caractère n'est ni un chiffre, ni un point décimal, ni un opérateur, renvoie une erreur
    else {
      throw ArgumentError('Input contains invalid characters');
    }
  }

  // Ajoute le dernier jeton à la liste si nécessaire
  if (currentToken.isNotEmpty) {
    separatedList.add(currentToken);
  }

  return separatedList;
}

List<TextSpan> writtenExpression(String input) {
  List<String> separatedList = separateString(input);
  List<TextSpan> result = [];
  for (String operationMember in separatedList) {
    result.add(TextSpan(
        text: operationMember,
        style: TextStyle(
            color: Calculator.isOperator(operationMember)
                ? const Color(0xff109DFF)
                : null)));
  }
  return result;
}
