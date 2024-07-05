import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipsn/model/Petugas/getkategori.dart';
import 'package:sipsn/model/getkontribusi.dart';
import 'package:sipsn/model/getpemasukan.dart';
import 'package:sipsn/model/getpoint.dart';
import 'package:sipsn/model/getprofile.dart';
import 'package:sipsn/model/user.dart';
import 'package:sipsn/nasabah/Mastercard.dart';
import 'package:sipsn/nasabah/Notifikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;
import 'package:sipsn/nasabah/button.dart';
import 'package:sipsn/nasabah/sampah.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});


  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;
  final _controller = PageController();
  late Future<List<Kategori>> kategori;
  // final now = DateTime.now();
  // String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

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

  Future<List<Kategori>> getRiwayat() async {
    // Riwayat user;
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + (await _token)
    };
    final response = await myHttp.get(
      // Uri.parse('http://pkmsmkteladankertasemaya.com/api/profile'),
      Uri.parse('http://192.168.1.5:8080/api/kategori-sampah'),
      headers: headers,
    );
    Map<String, dynamic> jsonResult = jsonDecode(response.body);
    print(jsonResult['data']['kategori']);
    List<Kategori> riwayat = [];
    for (var item in jsonResult['data']['kategori'] as List) {
      Kategori tasks = Kategori.fromJson(item);

      riwayat.add(tasks);

      print(riwayat.first);
    }
    // print("data riwayat");
    return riwayat;

    // return jsonResult.map((e) => Riwayat.fromJson(e)).toList();
  }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                      return Text(
                        "Hallo, ${snapshot.data!.name}",
                        style:  GoogleFonts.interTight(
                      textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 30,),
                    ),
                        );
                    }
                  },
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xFF00A368),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person,size: 50.0,color: Colors.white,),
                ),
                ],
              ),   
              ),
              SizedBox(height: 25,),
              Container(
                height: 200,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  children: [
                    //wrap with future builder
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
                          return MesterCard(
                          satuan: "Rupiah",
                          point: "Point", 
                          saldo: snapshot.data!.total.toString(), 
                          date: "12/08/2024", 
                          cardnumber: "1234567", 
                          color: Color(0xFF00A368),
                      );
                        }
                    }
                    ),
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
                          return MesterCard(
                          satuan: "Kg",
                          point: "Kontribusi Penjualan Sampah", 
                          saldo: snapshot.data!.tukar.toString(), 
                          date: "12/08/2024", 
                          cardnumber: "1234567", 
                          color: Colors.deepPurple,
                      );
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
                          return MesterCard(
                          satuan: "Kali",
                          point: "Banyak Penukaran Poin", 
                          saldo: snapshot.data!.tukar.toString(), 
                          date: "12/08/2024", 
                          cardnumber: "1234567", 
                          color: Colors.blue,
                      );
                        }
                    }
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25,),
              
              SmoothPageIndicator(
                controller: _controller, 
                count: 3,
                effect: ExpandingDotsEffect(
                  // activeDotColor: Colors.grey.shade800
                ),
                ),


              SizedBox(height: 25,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyButton(iconimage: "assets/images/ambil.jpg", buttontext: "Ambil"),
                    MyButton(iconimage: "assets/images/pilah.jpg", buttontext: "Pilah"),
                    MyButton(iconimage: "assets/images/koin.jpg", buttontext: "Tukar"),
                  ],
                ),
              ),

             

             Padding(
               padding: const EdgeInsets.all(25.0),
               child: Column(
                children: [
                  //wrapwithbuilder
                  FutureBuilder<List<Kategori>>(
                  future: getRiwayat(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // until data is fetched, show loader
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      // once data is fetched, display it on screen (call buildPosts())
                      final posts = snapshot.data!;
                      return buildPosts(posts);
                    } else {
                      // if no data, show simple Text
                      return const Text("No data available");
                    }
                  },
                ),
               
               ],),
             )


          ],
        )
      )),
    );
  }


  Widget buildPosts(List<Kategori> posts) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        children: posts.map((post) {
          return GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                  height: 80,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network("http://192.168.1.5:8080/storage/${post.gambar}"),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.jenisSampah,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Point : ${post.poinSampah}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

