import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/module/screens/auth/login_screen.dart';
import 'package:shopee/module/screens/landing_page/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () async {
      bool? appState =
          await si.persistentStorage.getBoolFromStorage(key: 'appState');
      si.routerService.popUntil(
        context,
        appState == true ? const LoginScreen() : const LandingOnePage(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Image(
                  image: AssetImage(
                    'images/shop.png',
                  ),
                  width: 200.0,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
