import 'package:flutter/material.dart';
import 'package:shopee/module/screens/landing_page/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce Mobile app',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const LandingOnePage(),
    );
  }
}
