import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;
import 'package:sipsn/model/getprofile.dart';
import 'package:sipsn/pages/Login.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;
  GetProfile? profile;
  List profiles = [];

  @override
  void initState() {
    super.initState();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("token") ?? "";
    });
  }

  Future<Datum> getData() async {
    Datum user;
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + (await _token)
    };
    final response = await myHttp.get(
      // Uri.parse('http://pkmsmkteladankertasemaya.com/api/profile'),
      Uri.parse('http://192.168.1.5:8080/api/profile-nasabah'),
      headers: headers,
    );
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);
    print(jsonResult['data']['petugas']);
    user = Datum.fromJson(jsonResult['data']['petugas']);
    log(user.toString());
    return user;
    profile!.data.forEach((element) {
      profiles.add(element);
    });
  }

  void _logout(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login()),
      );
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin keluar dari Aplikasi ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: Text('Keluar'),
              onPressed: () {
                _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: ElevatedButton(
      //                 child: const Text('Logout'),
      //                 onPressed: () {
      //                   _showLogoutConfirmationDialog(context);
      //                 },
      //                 style: ElevatedButton.styleFrom(
      //                   backgroundColor: Colors.red,
      //                 ),
      //               ),
      // ),
      backgroundColor: Color(0xFF00A368),
      body: FutureBuilder<Datum>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage("assets/images/model.jpg")),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(8, 5),
                            color: Colors.deepOrange.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 18,
                          )
                        ],
                      ),
                      child: ListTile(
                        title: const Text("Name"),
                        subtitle: Text(snapshot.data!.name),
                        leading: const Icon(CupertinoIcons.person),
                        tileColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(8, 5),
                            color: Colors.deepOrange.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 18,
                          )
                        ],
                      ),
                      child: ListTile(
                        title: const Text("Whatsapp"),
                        subtitle: Text(snapshot.data!.no_hp),
                        leading: const Icon(CupertinoIcons.phone_circle),
                        tileColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(8, 5),
                            color: Colors.deepOrange.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 18,
                          )
                        ],
                      ),
                      child: ListTile(
                        title: const Text("Alamat"),
                        subtitle: Text(snapshot.data!.alamat),
                        leading: const Icon(CupertinoIcons.location_circle),
                        tileColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(8, 5),
                            color: Colors.deepOrange.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 18,
                          )
                        ],
                      ),
                      child: ListTile(
                        title: const Text("Email"),
                        subtitle: Text(snapshot.data!.username  ),
                        leading: const Icon(CupertinoIcons.mail),
                        tileColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text('Logout', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        _showLogoutConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

