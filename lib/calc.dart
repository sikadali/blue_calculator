import 'dart:collection';

class Calculator {
  static double calculateExpression(String input) {
    List<String> tokens = tokenize(input);
    Queue<String> operatorStack = Queue();
    Queue<double> valueStack = Queue();

    for (String token in tokens) {
      if (isNumeric(token)) {
        valueStack.add(double.parse(token));
      } else if (token == '+' || token == '-' || token == '*' || token == '/') {
        while (operatorStack.isNotEmpty &&
            precedence(operatorStack.last) >= precedence(token)) {
          processOperator(operatorStack.removeLast(), valueStack);
        }
        operatorStack.add(token);
      }
    }

    while (operatorStack.isNotEmpty) {
      processOperator(operatorStack.removeLast(), valueStack);
    }

    return valueStack.single;
  }

  static List<String> tokenize(String input) {
    List<String> tokens = [];
    String currentToken = '';

    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      if (isNumeric(char) || char == '.') {
        currentToken += char;
      } else {
        if (currentToken.isNotEmpty) {
          tokens.add(currentToken);
          currentToken = '';
        }
        tokens.add(char);
      }
    }
    if (currentToken.isNotEmpty) {
      tokens.add(currentToken);
    }
    return tokens;
  }

  static isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  static int precedence(String op) {
    switch (op) {
      case '+':
      case '-':
        return 1;
      case '*':
      case '/':
        return 2;
      default:
        return 0;
    }
  }

  static void processOperator(String op, Queue<double> values) {
    double rightOperand = values.removeLast();
    double leftOperand = values.removeLast();

    switch (op) {
      case '+':
        values.add(leftOperand + rightOperand);
        break;
      case '-':
        values.add(leftOperand - rightOperand);
        break;
      case '*':
        values.add(leftOperand * rightOperand);
        break;
      case '/':
        values.add(leftOperand / rightOperand);
        break;
    }
  }

  static bool isOperator(String operationMember) {
    List<String> operators = ["+", "-", "*", "/"];
    return operators.contains(operationMember);
  }
}
