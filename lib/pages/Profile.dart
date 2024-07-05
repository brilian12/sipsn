import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sipsn/model/Petugas/getpetugas.dart';
import 'package:sipsn/model/getprofile.dart';
import 'package:sipsn/model/petugas.dart';
import 'package:sipsn/pages/EditProfile.dart';
import 'package:sipsn/pages/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';




class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;
  GetPetugas? profile;
  List<Petugass> profiles = [];



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
      Uri.parse('http://10.0.172.63:8080/api/profile-petugas'),
      headers: headers,
    );
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);
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
      appBar: AppBar(
        title: 
          Text(
              "Profil",
              textAlign: TextAlign.center,
              style: GoogleFonts.interTight(
                        textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 20,),
                      ),
              ),
            backgroundColor: Color(0xFF00A368),
        ),
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
                        backgroundImage: AssetImage("assets/images/user icon.png")),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
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
                        tileColor: Color(0xFF00A368),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
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
                        tileColor: Color(0xFF00A368),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
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
                        tileColor: Color(0xFF00A368),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
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
                        tileColor: Color(0xFF00A368),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                      child: const Text('Edit Profil', style: TextStyle(color: Color(0xFF00A368))),
                      onPressed: () {
                        Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditProfile(id: snapshot.data!.id, name: snapshot.data!.name, notelp: snapshot.data!.no_hp, alamat: snapshot.data!.alamat, email: snapshot.data!.username),
                        ),
                      );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20,),
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
