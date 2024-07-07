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
import 'package:sipsn/pages/Login.dart';
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
      Uri.parse('https://cleanearth.sintrenayu.com/api/profile-nasabah'),
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
      Uri.parse('https://cleanearth.sintrenayu.com/api/lihat-poin'),
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
    Uri.parse('https://cleanearth.sintrenayu.com/api/kontribusi-sampah'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);

    log(jsonResult.toString()); // Log the entire JSON response

    if (jsonResult['data'] != null) {
      user = Kontribusi.fromJson(jsonResult['data']);
      log(user.toString());
      return user;
    } else {
      throw Exception("Failed to load kontribusi data");
    }
  } else {
    throw Exception("Failed to load kontribusi data");
  }
}

  Future<Pemasukan> getPemasukan() async {
    Pemasukan user;
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + (await _token)
    };
    final response = await myHttp.get(
      // Uri.parse('http://pkmsmkteladankertasemaya.com/api/profile'),
      Uri.parse('https://cleanearth.sintrenayu.com/api/pemasukan-sampah'),
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
      Uri.parse('https://cleanearth.sintrenayu.com/api/kategori-sampah'),
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
                      return Container(
                              width: MediaQuery.of(context).size.width * 0.5, // Adjust width as necessary
                              child: Text(
                                "Hallo, ${snapshot.data!.name}",
                                style: GoogleFonts.interTight(
                                textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 22,),
                    ),
                                softWrap: true,
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
                          date: "", 
                          cardnumber: "Aplikasi Manajemen Pengelolaan Sampah", 
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
                          date: "", 
                          cardnumber: "Aplikasi Manajemen Pengelolaan Sampah", 
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
                          date: "", 
                          cardnumber: "Aplikasi Manajemen Pengelolaan Sampah", 
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

              Container(
                child: Column(
                  children: [
                     Text(
                        "3 Cara Mudah Menjual Sampah",
                        textAlign: TextAlign.center,
                        style:  GoogleFonts.interTight(
                      textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 20,),
                    ),
                        ),
                    SizedBox(height: 10,),
                    Image.asset("assets/images/poster.png")
                  ],
                ),
              ),

             

             Padding(
               padding: const EdgeInsets.all(25.0),
               child: Column(
                children: [
                  Text(
                        "Daftar Harga Sampah",
                        textAlign: TextAlign.center,
                        style:  GoogleFonts.interTight(
                      textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 20,),
                    ),
                        ),
                  SizedBox(height: 10,),
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
    child: SingleChildScrollView(
      child: Column(
        children: posts.map((post) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.network(
                          "https://cleanearth.sintrenayu.com/storage/${post.gambar}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.5, // Adjust width as necessary
                              child: Text(
                                post.jenisSampah,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                softWrap: true,
                              ),
                            ),
                          SizedBox(height: 8),
                          Text(
                            "Point: ${post.poinSampah}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

}

