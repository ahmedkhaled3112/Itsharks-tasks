import 'dart:io';

class calculator {
  int addition(int num1, int num2) {
    return num1 + num2;
  }

  int subtraction(int num1, int num2) {
    return num1 - num2;
  }

  int multiplication(int num1, int num2) {
    return num1 * num2;
  }

  int dividing(int num1, int num2) {
    return num1 ~/ num2;
  }

  int remainderOfTheDevision(int num1, int num2) {
    return num1 % num2;
  }
}

void main() {
  calculator result = calculator();
  int firstNumber, secondNumber;
  String operation;
  while (true) {
    print(
        "this is a simple calculator to do basic operation\nsuch as : + or - or * or / or % \non two integer numbers\nplease enter the first number or to exit please enter zero : ");
    while (true) {
      try {
        firstNumber = int.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print(
            "your first number is unvalid please enter a valid value or zero to exit : ");
      }
    }
    if (firstNumber == 0) {
      break;
    }
    print("please enter the second number : ");
    while (true) {
      try {
        secondNumber = int.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print("your second number is unvalid please enter a valid value");
      }
    }
    print(
        "please choose the operation you want.\nType + for addition\nType - for subtraction\nType * for multiplication\nType % to get the remainder of the division\nType / to divide");
    while (true) {
      operation = stdin.readLineSync()!;
      if (operation == "+" ||
          operation == '-' ||
          operation == '*' ||
          operation == '/' ||
          operation == '%') {
        break;
      } else {
        print("unvalid operation please enter a valid operation");
      }
    }
    bool switchOff = false;
    while (!switchOff) {
      switch (operation) {
        case "+":
          {
            print(
                "$firstNumber + $secondNumber =  ${result.addition(firstNumber, secondNumber)}");
            switchOff = true;
          }
          break;

        case "-":
          {
            print(
                "$firstNumber - $secondNumber =  ${result.subtraction(firstNumber, secondNumber)}");
            switchOff = true;
          }
          break;

        case "*":
          {
            print(
                "$firstNumber * $secondNumber =  ${result.multiplication(firstNumber, secondNumber)}");
            switchOff = true;
          }
          break;

        case "/":
          {
            try {
              result.dividing(firstNumber, secondNumber);
              print(
                  "$firstNumber / $secondNumber =  ${result.dividing(firstNumber, secondNumber)}");
            } on IntegerDivisionByZeroException {
              print('Cannot divide by zero');
            }
            switchOff = true;
          }
          break;

        case "%":
          {
            print(
                "$firstNumber % $secondNumber =  ${result.remainderOfTheDevision(firstNumber, secondNumber)}");
            switchOff = true;
          }
          break;

        default:
          {
            print("Invalid operator");
          }
          break;
      }
    }
  }
}
