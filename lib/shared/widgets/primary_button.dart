import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final dynamic Function(Function, Function, ButtonState)? onTap;

  const PrimaryButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: 50,
      width: 150,
      borderRadius: 5.0,
      color: Colors.amberAccent,
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      loader: Container(
        padding: const EdgeInsets.all(10),
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
