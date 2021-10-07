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
  print(
      "this is a simple calculator to do basic operation\nsuch as : + or - or * or / or % \non two integer numbers\nplease enter the first number or to exit please enter zero : ");
  int firstNumber = int.parse(stdin.readLineSync()!);
  if (firstNumber == 0) {
    exit(0);
  } else {
    print("please enter the second number : ");
    int secondNumber = int.parse(stdin.readLineSync()!);
    print(
        "please choose the operation you want.\nType + for addition\nType - for subtraction\nType * for multiplication\nType % to get the remainder of the division\nType / to divide");
    String operation = stdin.readLineSync()!;
    switch (operation) {
      case "+":
        {
          print(
              "$firstNumber + $secondNumber =  ${result.addition(firstNumber, secondNumber)}");
        }
        break;

      case "-":
        {
          print(
              "$firstNumber - $secondNumber =  ${result.subtraction(firstNumber, secondNumber)}");
        }
        break;

      case "*":
        {
          print(
              "$firstNumber * $secondNumber =  ${result.multiplication(firstNumber, secondNumber)}");
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
        }
        break;

      case "%":
        {
          print(
              "$firstNumber % $secondNumber =  ${result.remainderOfTheDevision(firstNumber, secondNumber)}");
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
