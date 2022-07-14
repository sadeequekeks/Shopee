import 'dart:convert';

LoginModel loginModelFromMap(String str) =>
    LoginModel.fromMap(json.decode(str));

String loginModelToMap(LoginModel data) => json.encode(data.toMap());

class LoginModel {
  LoginModel({
    required this.user,
    required this.token,
    required this.message,
  });

  final User user;
  final String token;
  final String message;

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        user: User.fromMap(json["user"]),
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
        "token": token,
        "message": message,
      };
}

class User {
  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.telephone,
    required this.address,
    required this.gender,
    required this.password,
    required this.v,
  });

  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;
  final String address;
  final String gender;
  final String password;
  final int v;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        telephone: json["telephone"],
        address: json["address"],
        gender: json["gender"],
        password: json["password"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "telephone": telephone,
        "address": address,
        "gender": gender,
        "password": password,
        "__v": v,
      };
}
