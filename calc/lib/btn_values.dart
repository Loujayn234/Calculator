import 'package:flutter/material.dart';

class Btn {
  // Basic operation and numeric buttons
  static const IconData del = Icons.backspace_outlined;
  static const String clr = "C";
  static const String per = "%";
  static const String multiply = "×";
  static const String divide = "÷";
  static const String add = "+";
  static const String subtract = "-";
  static const String calculate = "=";
  static const String dot = ".";
  static const String n0 = "0";
  static const String n1 = "1";
  static const String n2 = "2";
  static const String n3 = "3";
  static const String n4 = "4";
  static const String n5 = "5";
  static const String n6 = "6";
  static const String n7 = "7";
  static const String n8 = "8";
  static const String n9 = "9";

  // Advanced/scientific function buttons
  static const String sin = "sin(";
  static const String cos = "cos(";
  static const String tan = "tan(";
  static const String log = "log";
  static const String ln = "ln";
  static const String sqrt = "√";
  static const String power = "x^y";
  static const String pi = "π";
  static const String e = "e";
  static const String openParen = "(";
  static const String closeParen = ")";
  static const String factorial = "!";

  // Lists for button values
  static const List<dynamic> buttonValuesBasic = [
    // First row
    clr, del, openParen, closeParen,

    // Second row
    n7, n8, n9, multiply,

    // Third row
    n4, n5, n6, subtract,

    // Fourth row
    n1, n2, n3, divide,

    // Fifth row
    n0, dot, calculate, add
  ];

  static const List<dynamic> buttonValuesAdvanced = [
    sin,
    cos,
    tan,
    log,
    ln,
    sqrt,
    power,
    pi,
    e,
    factorial,
    per,
  ];
}
