import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Helper {
  String formattNumber(int number) {
    return NumberFormat.simpleCurrency(name: 'NGN').format(number);
  }

  Widget setSvgFromAsset({required String svg, required double height}) {
    return Container(
      height: height,
      child: SvgPicture.asset(
        svg,
      ),
    );
  }
}
