import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sipsn/model/user.dart';
import 'package:sipsn/nasabah/Navigasi.dart';
import 'package:sipsn/navigation_menu.dart';
import 'package:sipsn/pages/Homepage.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
late Future<String> _name, _role, _token;
bool _showPassword = false;


  @override
  void initState() {
    super.initState();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("token") ?? "";
    });
    _name = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("name") ?? "";
    });
    _role = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("role") ?? "";
    });
    checkToken(_token, _role);
  }

  void checkToken(Future<String> token, Future<String> role) async {
    String tokenStr = await token;
    String roleStr = await role;
    if (tokenStr != "" &&
        (roleStr != "superadmin" && roleStr != "admin" && roleStr != "nasabah")) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NavigationMenu()), //petugas
        );
      });
      
    }
    else if (tokenStr != "" &&
        (roleStr != "superadmin" && roleStr != "admin" && roleStr != "petugas")) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Navigasi()), //nasabah
        );
      });
    }
  }


  Future<void> login(String username, String password) async {
    User? user;
    Map<String, String> body = {
      "username": username,
      "password": password,
    };
    final headers = {'Content-Type': 'application/json'};

    try {
      var response = await myHttp.post(
        Uri.parse('http://192.168.56.131:8080/api/login'),
        // Uri.parse('http://pkmsmkteladankertasemaya.com/api/login'),
        body: json.encode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        user = User.fromJson(json.decode(response.body));
        saveUser(user.data.token, user.data.role, user.data.student.name);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Username atau Password salah")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan. Silakan coba lagi.")),
      );
    }
  }


  Future<void> saveUser(String token, String role, String name) async {
    try {
      final SharedPreferences pref = await _prefs;
      pref.setString("name", name);
      pref.setString("token", token);
      pref.setString("role", role);

      String roleStr = await role;

      if (roleStr == "petugas") {
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NavigationMenu()), //petugas
      );
      }

      else if  (roleStr == "nasabah"){
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Navigasi()), //nasabah
      );
      }

      
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err.toString())),
      );
    }
  }





  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/model.jpg"),
                fit: BoxFit.cover
                )
              ),
            ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        Text(
                          "SIGN IN",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xFF00A368))
                        ),
                        Text(
                          "SIGN UP",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ],
                    ),
                    // Spacer(),
                    SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.alternate_email,
                            color: Color(0xFF00A368),
                            ),
                          ),
                      Expanded(
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email Address"
                          ),
                        ) 
                        ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(Icons.lock,
                          color: Color(0xFF00A368),
                          ),
                        ),
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              }, 
                            icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off ),
                            
                            )
                        ),
                      ) 
                      ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                onTap: () {
                  login(
                                  emailController.text,
                                  passwordController.text,
                                );
                },
                child: Ink(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF00A368),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
                        ],
                      ),
                    )
                  ],
                ),
              )
               )
        ],
      ),
    );
  }
}
