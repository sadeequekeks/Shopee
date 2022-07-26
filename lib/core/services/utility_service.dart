import 'package:flutter/material.dart';

class UtilityService {
  void clearFields(List<TextEditingController> controller) {
    for (TextEditingController field in controller) {
      field.clear();
    }
  }
}
