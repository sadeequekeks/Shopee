import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RouterService {
  void popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  void nextScreen(BuildContext context, Widget widget) {
    Navigator.push(context,
        MaterialPageRoute<Widget>(builder: (BuildContext context) => widget));
  }

  void popReplaceScreen(BuildContext context, Widget widget) {
    Navigator.pushReplacement(context,
        MaterialPageRoute<Widget>(builder: (BuildContext context) => widget));
  }

  void popUntil(BuildContext context, Widget widget) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<Widget>(builder: (BuildContext context) => widget),
        (Route<dynamic> route) => false);
    ModalRoute.withName('/');
  }

  void popDialog(BuildContext context, bool? value) {
    Navigator.of(context, rootNavigator: true).pop(value);
  }

  void exitApp() {
    SystemChannels.platform.invokeMethod<String>('SystemNavigator.pop');
  }
}
