import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as myHttp;
import 'package:sipsn/nasabah/Navigasi.dart';
import 'package:sipsn/nasabah/Profil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfil extends StatefulWidget {


  late final int id;
  late final String name;
  late final String notelp;
  late final String alamat;
  late final String email;

  EditProfil({required this.id,required this.name,required this.notelp,required this.alamat, required this.email});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
TextEditingController nameController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController alamatController = TextEditingController();
TextEditingController teleponController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController konfirmasipasswordController = TextEditingController();

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
late Future<String> _token;

@override
  void initState() {
    super.initState();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("token") ?? "";
    });
  }


Future update() async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + (await _token)
    };
    var response = await myHttp.post(
        Uri.parse('https://cleanearth.sintrenayu.com/api/edit/profile-nasabah'),
        headers: headers,
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
          SnackBar(content: Text("Berhasil Edit Profil")),
        );
        return Navigator.pushReplacement(context, 
            MaterialPageRoute(
            builder: (context) => Navigasi()
            ));
    }
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 50,),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        SizedBox(height: 30,),
                        Text(
                          "Edit Profil",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF00A368))
                        ),
                      ],
                    ),
                    // Spacer(),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.person,
                            color: Color(0xFF00A368),
                            ),
                          ),
                      Expanded(
                        child: TextField(
                          controller: nameController = TextEditingController(text: widget.name),
                          decoration: InputDecoration(
                            hintText: "Nama"
                          ),
                        ) 
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
                            child: Icon(Icons.alternate_email,
                            color: Color(0xFF00A368),
                            ),
                          ),
                      Expanded(
                        child: TextField(
                          controller: usernameController = TextEditingController(text: widget.email),
                          decoration: InputDecoration(
                            hintText: "Username"
                          ),
                        ) 
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
                            child: Icon(Icons.location_city,
                            color: Color(0xFF00A368),
                            ),
                          ),
                      Expanded(
                        child: TextField(
                          controller: alamatController = TextEditingController(text: widget.alamat),
                          decoration: InputDecoration(
                            hintText: "Alamat"
                          ),
                        ) 
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
                            child: Icon(Icons.phone,
                            color: Color(0xFF00A368),
                            ),
                          ),
                      Expanded(
                        child: TextField(
                          controller: teleponController = TextEditingController(text: widget.notelp),
                          decoration: InputDecoration(
                            hintText: "Telepon",
                          ),
                        ),  
                        ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          update();
                          // register();
                          // login(
                          //         usernameController.text,
                          //         passwordController.text,
                          //       );
                        }, 
                        child: Text("Edit Profil")
                        ),
                    ),
                  ],
                ),
              )
               )
        ],
      ),
    );
  }
}