import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shopee/core/helper/helper_functions.dart';
import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/module/screens/auth/signup_screen.dart';
import 'package:shopee/shared/data/models/login_model.dart';
import 'package:shopee/shared/widgets/nav/bottom_nav.dart';
import 'package:shopee/shared/widgets/pass_text_field.dart';
import 'package:shopee/shared/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  final Helper _helper = Helper();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 80.0),
              Stack(
                children: <Widget>[
                  Positioned(
                    left: 20.0,
                    top: 15.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      width: 70.0,
                      height: 20.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 32.0),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Align(
                alignment: Alignment.center,
                child: _helper.setSvgFromAsset(
                    svg: 'images/makeup.svg', height: 250.0),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: InputTextField(
                  controller: email,
                  hintText: 'john@gmail.com',
                  labelText: 'Email',
                  icon: Icons.person,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: PassTextField(
                  controller: password,
                  hintText: '*******',
                  labelText: 'Password',
                  icon: Icons.password,
                ),
              ),
              GestureDetector(
                onTap: () {
                  si.routerService.nextScreen(context, const SignUpScreen());
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "Already have an account "),
                      TextSpan(
                          text: " Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo)),
                    ]),
                  ),
                ),
              ),
              const SizedBox(height: 60.0),
              Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                  color: Colors.amber,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await si.authService
                        .login(email: email.text, password: password.text)
                        .then((value) {
                      if (value.runtimeType == LoginModel) {
                        si.routerService
                            .popReplaceScreen(context, const BootomNav());
                        // LoginModel user = value;
                        // print(user.token);
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            value.toString(),
                          ),
                        ));
                        setState(() {
                          isLoading = false;
                        });
                      }
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Sign in".toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 40.0),
                      const Icon(
                        FontAwesomeIcons.arrowRight,
                        size: 18.0,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
