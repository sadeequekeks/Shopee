import 'package:flutter/material.dart';

class PrimaryOutlinedButton extends StatelessWidget {
  const PrimaryOutlinedButton({Key? key, required this.buttonTitle})
      : super(key: key);
  final String buttonTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        buttonTitle,
        maxLines: 1,
        style: TextStyle(
          color: Colors.orange.withOpacity(0.5),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
