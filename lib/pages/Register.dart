import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myHttp;
import 'package:sipsn/pages/Login.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

TextEditingController nameController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController alamatController = TextEditingController();
TextEditingController teleponController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController konfirmasipasswordController = TextEditingController();

Future register() async {
    var url = Uri.parse('https://cleanearth.sintrenayu.com/api/register');
    var response = await myHttp.post(
        Uri.parse('https://cleanearth.sintrenayu.com/api/register'),
        // Uri.parse('http://pkmsmkteladankertasemaya.com/api/login'),
        body:  {
      "name" : nameController.text,
      "username" : usernameController.text,
      "alamat" : alamatController.text,
      "no_hp" : teleponController.text,
      "password" : passwordController.text,
      "password_confirmation" : konfirmasipasswordController.text,
    },
      );
    // var response = await myHttp.post(url, body: {
    //   "name" : nameController.text,
    //   "username" : usernameController.text,
    //   "alamat" : alamatController.text,
    //   "no_hp" : teleponController.text,
    //   "password" : passwordController.text,
    //   "password_confirmation" : konfirmasipasswordController.text,
    // });

    var data = json.decode(response.body);
    print(data);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Akun Sudah Terdaftar")),
        );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Berhasil Daftar Akun")),
        );
        return Navigator.pushReplacement(context, 
            MaterialPageRoute(
            builder: (context) => Login()
            ));
    }
  }



  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                "Registrasi",
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 20, 
                  color: Color(0xFF00A368),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Password harus 8 karakter,1 Huruf Kapital dan Simbol",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF00A368),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF00A368),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Nama",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.alternate_email,
                        color: Color(0xFF00A368),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "Username",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.location_city,
                        color: Color(0xFF00A368),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: alamatController,
                        decoration: InputDecoration(
                          hintText: "Alamat",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.phone,
                        color: Color(0xFF00A368),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: teleponController,
                        decoration: InputDecoration(
                          hintText: "Telepon",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.lock,
                        color: Color(0xFF00A368),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.lock,
                        color: Color(0xFF00A368),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: konfirmasipasswordController,
                        decoration: InputDecoration(
                          hintText: "Konfirmasi Password",
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    register();
                  },
                  child: Text("Daftar"),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}