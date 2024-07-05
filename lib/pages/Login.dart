import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sipsn/model/petugas.dart';
import 'package:sipsn/model/user.dart';
import 'package:sipsn/nasabah/Navigasi.dart';
import 'package:sipsn/navigation_menu.dart';
import 'package:sipsn/pages/Homepage.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;
import 'package:sipsn/pages/Profile.dart';
import 'package:sipsn/pages/Register.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
late Future<String> _name, _role, _token;
bool _showPassword = false;

void _toggleObscured() {
    setState(() {
      _showPassword = !_showPassword;  // Prevents focus if tap on eye
    });
  }


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
    String roleStr = await role; //pake ini buat login
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
    Welcome? user;
    Map<String, String> body = {
      "username": username,
      "password": password,
    };
    final headers = {'Content-Type': 'application/json'};

    try {
      var response = await myHttp.post(
        Uri.parse('http://10.0.172.63:8080/api/login'),
        // Uri.parse('http://pkmsmkteladankertasemaya.com/api/login'),
        body: json.encode(body),
        headers: headers,
      );


      if (response.statusCode == 200) { //if user data role == petugas dia ke petugas
        // print(json.decode(response.body));
        var datas = (json.decode(response.body));

        if (datas["data"]["role"] == "nasabah") {
         Navigator.pushReplacement(context, 
            MaterialPageRoute(
            builder: (context) => Navigasi()
            ));
        print(datas["data"]["role"]);
        user = Welcome.fromJson(json.decode(response.body));
        saveUser(user.data.token, user.data.role, user.data.nasabah.name);
        }

        else {
            Navigator.pushReplacement(context, 
            MaterialPageRoute(
            builder: (context) => NavigationMenu()
            ));
            print(json.decode(response.body));
            var petuas = Will.fromJson(json.decode(response.body));
            print(petuas.data.petugas.name);
            // user = Welcomes.fromJson(json.decode(response.body)) as Welcome?;
            saveUser(petuas.data.token, petuas.data.role, petuas.data.petugas.name);
            print(petuas.data.petugas.name);
        }
        
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
                image: DecorationImage(image: AssetImage("assets/images/sp.jpeg"),
                fit: BoxFit.fitHeight
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
                          "Masuk Akun",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Color(0xFF00A368))
                        ),
                        ElevatedButton(
                        onPressed: (){
                           Navigator.of(context).push(
                           MaterialPageRoute(
                          builder: (context) => Register(),
                    ),
                  );
                        }, 
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00A368),
                        ),
                        child: Text("Daftar",style: TextStyle(color: Colors.white, fontSize: 15),)
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
                          controller: usernameController,
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
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                              ),
                            ),
                          )
                        ),
                      ) 
                      ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          login(
                                  usernameController.text,
                                  passwordController.text,
                                );
                        }, 
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00A368),
                      ),
                        child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)
                        
                        ),
                    ),
              //       Padding(
              //         padding: const EdgeInsets.only(bottom: 30),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             InkWell(
              //   onLongPress: () {
              //     login(
              //                     usernameController.text,
              //                     passwordController.text,
              //                   );
              //   },
              //   child: Ink(
              //     padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30),
              //       color: Color(0xFF00A368),
              //     ),
              //     child: Text(
              //       "Login",
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              //           ],
              //         ),
              //       )
                  ],
                ),
              )
               )
        ],
      ),
    );
  }
}
