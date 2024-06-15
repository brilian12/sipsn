import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipsn/model/getkontribusi.dart';
import 'package:sipsn/model/getpemasukan.dart';
import 'package:sipsn/model/getpoint.dart';
import 'package:sipsn/model/getprofile.dart';
import 'package:sipsn/model/user.dart';
import 'package:sipsn/nasabah/Notifikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;
import 'dart:convert';
import 'dart:developer';

class Beranda extends StatefulWidget {
  const Beranda({super.key});


  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;

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
    user = Datum.fromJson(jsonResult['data']['petugas']);
    log(user.toString());
    return user;
  }

  Future<Tukar> getPoint() async {
    Tukar user;
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + (await _token)
    };
    final response = await myHttp.get(
      // Uri.parse('http://pkmsmkteladankertasemaya.com/api/profile'),
      Uri.parse('http://192.168.1.5:8080/api/lihat-poin'),
      headers: headers,
    );
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);
    user = Tukar.fromJson(jsonResult['data']['tukar']);
    log(user.toString());
    return user;
  }

  Future<Kontribusi> getKontribusi() async {
    Kontribusi user;
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + (await _token)
    };
    final response = await myHttp.get(
      // Uri.parse('http://pkmsmkteladankertasemaya.com/api/profile'),
      Uri.parse('http://192.168.1.5:8080/api/kontribusi-sampah'),
      headers: headers,
    );
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);
    user = Kontribusi.fromJson(jsonResult['data']);
    log(user.toString());
    return user;
  }

  Future<Pemasukan> getPemasukan() async {
    Pemasukan user;
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + (await _token)
    };
    final response = await myHttp.get(
      // Uri.parse('http://pkmsmkteladankertasemaya.com/api/profile'),
      Uri.parse('http://192.168.1.5:8080/api/pemasukan-sampah'),
      headers: headers,
    );
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);
    user = Pemasukan.fromJson(jsonResult['data']);
    log(user.toString());
    return user;
  }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A368),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 20, left: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color(0xFF00A368),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 2,
                          ),
                        ]),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Notifikasi(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.notifications,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),

            //welcome text
            FutureBuilder(
              future: getData(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } 
                else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                else {
                  return Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hallo, ${snapshot.data!.name}",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   snapshot.data!.name,
                  //   style: TextStyle(color: Colors.white, fontSize: 20),
                  // ),
                  Text(
                    "Sudah Kumpulkan Sampah hari ini?",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            );
                }
              },
            ),

            FutureBuilder(
            future: getPoint(), 
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } 
                else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                else {
                  return Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 150,
                // padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.total.toString(),
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Point anda",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF00A368),
                      ),
                      child: Icon(
                        CupertinoIcons.money_dollar,
                        size: 30,
                      ),
                    ),
                  ],
                ));
                }
            }
            ),

            
            Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 150,
                // padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tracking",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Pickup",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF00A368),
                      ),
                      child: Icon(
                        CupertinoIcons.car,
                        size: 30,
                      ),
                    ),
                  ],
                )),

            FutureBuilder(
              future: getKontribusi(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } 
                else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                else {
                  return Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 150,
                // padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.tukar.toString(),
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Kontribusi Penjualan sampah (Kg)",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF00A368),
                      ),
                      child: Icon(
                        Icons.money,
                        size: 30,
                      ),
                    ),
                  ],
                ));
                }
              }
              ),
            


            FutureBuilder(
              future: getPemasukan(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } 
                else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                else {
                  return Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 150,
                // padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.tukar.toString(),
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Banyaknya Penukaran Poin",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF00A368),
                      ),
                      child: Icon(
                        CupertinoIcons.money_dollar,
                        size: 30,
                      ),
                    ),
                  ],
                ));
                }
                }
              ),
            

            //products widgets
          ],
        ),
      )),
    );
  }
}
