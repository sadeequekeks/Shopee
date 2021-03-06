import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/module/screens/auth/login_screen.dart';
import 'package:shopee/module/screens/orders/orders_screen.dart';
import 'package:shopee/shared/global/global_var.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    si.orderService.getAllOrder();
    super.initState();
  }

  @override
  void dispose() {
    lateOrderList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.amber,
      //   label: const Text('Log Out'),
      //   icon: const Icon(Icons.logout),
      //   onPressed: () {
      //     si.routerService.popReplaceScreen(
      //       context,
      //       const LoginScreen(),
      //     );
      //   },
      // ),
      floatingActionButton: SpeedDial(icon: Icons.open_with, children: [
        SpeedDialChild(
          labelBackgroundColor: Colors.amber,
          child: const Icon(
            Icons.logout,
            color: Colors.amber,
          ),
          label: 'Log Out',
          onTap: () {
            si.routerService.popReplaceScreen(
              context,
              const LoginScreen(),
            );
          },
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.amber,
          child: const Icon(
            Icons.shopping_basket,
            color: Colors.amber,
          ),
          label: 'My Orders',
          onTap: () {
            si.routerService.nextScreen(
              context,
              const MyOrders(),
            );
          },
        ),
      ]),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            child: Column(
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 50.0,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                UserInfo(
                  name: userObj.user.firstname,
                  lname: userObj.user.lastname,
                  phone: userObj.user.telephone,
                  address: userObj.user.address,
                  email: userObj.user.email,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.address,
    required this.email,
    required this.name,
    required this.phone,
    required this.lname,
  }) : super(key: key);

  final String name;
  final String email;
  final String phone;
  final String address;
  final String lname;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: const Text(
              "User Information",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            leading: const Icon(
                              Icons.person,
                              color: Colors.amberAccent,
                            ),
                            title: const Text("Name"),
                            subtitle: Text('$name $lname'),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.email,
                              color: Colors.amberAccent,
                            ),
                            title: const Text("Email"),
                            subtitle: Text(email),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.phone,
                              color: Colors.amberAccent,
                            ),
                            title: const Text("Phone"),
                            subtitle: Text(phone),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: const Icon(
                              Icons.my_location,
                              color: Colors.amberAccent,
                            ),
                            title: const Text("Address"),
                            subtitle: Text(address),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
