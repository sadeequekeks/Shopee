import 'package:flutter/material.dart';
import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/module/screens/auth/login_screen.dart';

class LandingOnePage extends StatelessWidget {
  const LandingOnePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: const Image(
              image: NetworkImage(
                'https://startupjungle.com/wp-content/uploads/2017/02/cosmetic-products-3018845-1.jpg',
              ),
              fit: BoxFit.contain,
            ),
          ),
          Column(
            children: <Widget>[
              const SizedBox(height: 30.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 5.0)
                      ]),
                  margin: const EdgeInsets.all(48.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y29zbWV0aWNzfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              )),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        "How will you do?",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Lorem ipsuim is simply dummy text of the \nprinting and typesetting industry.\nLorem ipsum has been the",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey.shade400, fontSize: 14.0),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                width: double.infinity,
                child: MaterialButton(
                  padding: const EdgeInsets.all(16.0),
                  textColor: Colors.white,
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  onPressed: () {
                    si.routerService.popReplaceScreen(
                      context,
                      const LoginScreen(),
                    );
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
            ],
          )
        ],
      ),
    );
  }
}
