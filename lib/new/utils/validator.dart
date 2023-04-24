import 'package:flutter/material.dart';

extension Validator on TextEditingController {
  String getText() => this.text.trim();

  bool isValidEmail() {
    if (this.isEmpty()) return false;
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(this.text);
  }

  bool isValidPassword() {
    if (this.isEmpty()) return false;
    return this.text.length < 6 ? false : true;
  }

  bool isValidPhone() {
    if (this.isEmpty()) return false;
    return this.text.length == 11 &&
        this.text.startsWith(RegExp('^(010|012|015|011)'));
  }

  bool isEmpty() {
    return this == null || this.text == null || this.text.isEmpty;
  }

  bool trimmedAndStillEmpty() {
    return this == null || this.text == null || this.text.trim().isEmpty;
  }

  bool isValidName() {
    if (this.isEmpty()) return false;
    return RegExp(r"^(?=.*?[a-z A-Z]).{2,}$").hasMatch(this.text);
  }
  bool isValidFullName() {
    final nameList = this.text.trim().split(" ");
    return isValidName() && nameList.length > 2 && nameList.last != "";
  }

  bool isValidHeight() {
    if (this.isEmpty()) return false;
    final height = double.parse(this.text) ;
    return height >= 50 && height <= 200;
  }

  bool isValidWeight() {
    if (this.isEmpty()) return false;
    final weight = double.parse(this.text) ;
    return weight >= 4 && weight <= 250;
  }
  bool isValidAge() {
    if (this.isEmpty()) return false;
    final age = double.parse(this.text) ;
    return age >= 4 && age <= 120;
  }
}
