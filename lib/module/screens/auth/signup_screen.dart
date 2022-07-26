import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/module/screens/auth/login_screen.dart';
import 'package:shopee/shared/widgets/pass_text_field.dart';
import 'package:shopee/shared/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  List<TextEditingController> controllers = [];

  @override
  void initState() {
    controllers.addAll([
      fname,
      lname,
      email,
      address,
      phone,
      gender,
      password,
    ]);
    super.initState();
  }

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
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      width: 70.0,
                      height: 20.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 32.0),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: InputTextField(
                  controller: fname,
                  hintText: 'John',
                  labelText: 'First Name',
                  icon: Icons.person,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: InputTextField(
                  controller: lname,
                  hintText: 'Doe',
                  labelText: 'Last Name',
                  icon: Icons.person,
                ),
              ),
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
                child: InputTextField(
                  controller: phone,
                  hintText: '080039392929',
                  labelText: 'Phone',
                  icon: Icons.phone,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: InputTextField(
                  controller: address,
                  hintText: 'john street',
                  labelText: 'Address',
                  icon: Icons.streetview,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: InputTextField(
                  controller: gender,
                  hintText: 'Male or Female',
                  labelText: 'Gender',
                  icon: Icons.female,
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text:
                            "By clicking Sign Up you agree to the following "),
                    TextSpan(
                        text: "Terms and Conditions",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.indigo)),
                    TextSpan(text: " withour reservations."),
                  ]),
                ),
              ),
              const SizedBox(height: 40.0),
              Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                  color: Colors.amberAccent,
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
                        .signUp(
                            firstname: fname.text,
                            lastname: lname.text,
                            email: email.text,
                            telephone: phone.text,
                            address: address.text,
                            gender: gender.text,
                            password: password.text)
                        .then((value) {
                      // si.routerService
                      //     .popReplaceScreen(context, const LoginScreen());
                      // LoginModel user = value;
                      // print(user.token);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          value.toString(),
                        ),
                      ));
                      si.utilityService.clearFields(controllers);
                    });
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Sign up".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     OutlineButton.icon(
              //       padding: const EdgeInsets.symmetric(
              //         vertical: 8.0,
              //         horizontal: 30.0,
              //       ),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20.0)),
              //       borderSide: const BorderSide(color: Colors.red),
              //       color: Colors.red,
              //       highlightedBorderColor: Colors.red,
              //       textColor: Colors.red,
              //       icon: const Icon(
              //         FontAwesomeIcons.googlePlusG,
              //         size: 18.0,
              //       ),
              //       label: const Text("Google"),
              //       onPressed: () {},
              //     ),
              //     const SizedBox(width: 10.0),
              //     OutlineButton.icon(
              //       padding: const EdgeInsets.symmetric(
              //         vertical: 8.0,
              //         horizontal: 30.0,
              //       ),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20.0)),
              //       highlightedBorderColor: Colors.indigo,
              //       borderSide: const BorderSide(color: Colors.indigo),
              //       color: Colors.indigo,
              //       textColor: Colors.indigo,
              //       icon: const Icon(
              //         FontAwesomeIcons.facebookF,
              //         size: 18.0,
              //       ),
              //       label: const Text("Google"),
              //       onPressed: () {},
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
