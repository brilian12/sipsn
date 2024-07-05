import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sipsn/model/Petugas/getjadwal.dart';
import 'package:sipsn/model/Petugas/getpetugas.dart';
import 'package:sipsn/model/getprofile.dart';
import 'package:sipsn/pages/ChangeTrash.dart';
import 'package:sipsn/pages/Profile.dart';
import 'package:sipsn/widgets/BottomCartSheet.dart';
import 'package:sipsn/widgets/CategoriesWidget.dart';
import 'package:sipsn/widgets/ItemsWidget.dart';
import 'package:sipsn/widgets/PopularItemsWidget.dart';
// import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

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

  Future<List<Jadwal>> getJadwal() async {
    // Riwayat user;
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + (await _token)
    };
    final response = await myHttp.get(
      // Uri.parse('http://pkmsmkteladankertasemaya.com/api/profile'),
      Uri.parse('http://10.0.172.63:8080/api/lihat-lokasi'),
      headers: headers,
    );
    Map<String, dynamic> jsonResult = jsonDecode(response.body);
    print(jsonResult['data']);
    List<Jadwal> riwayat = [];
    for (var item in jsonResult['data']['jadwal'] as List) {
      Jadwal tasks = Jadwal.fromJson(item);

      riwayat.add(tasks);

      print(riwayat.first);
    }
    // print("data riwayat");
    return riwayat;

    // return jsonResult.map((e) => Riwayat.fromJson(e)).toList();
  }


  
  @override
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
                  SizedBox(height: 20,),
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
              
              
              // SmoothPageIndicator(
              //   controller: _controller, 
              //   count: 3,
              //   effect: ExpandingDotsEffect(
              //     // activeDotColor: Colors.grey.shade800
              //   ),
              //   ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // MyButton(iconimage: "assets/images/ambil.jpg", buttontext: "Ambil"),
                    // MyButton(iconimage: "assets/images/pilah.jpg", buttontext: "Pilah"),
                    // MyButton(iconimage: "assets/images/koin.jpg", buttontext: "Tukar"),
                  ],
                ),
              ),

             

             Padding(
               padding: const EdgeInsets.all(25.0),
               child: Column(
                children: [
                  Text(
                              'SAMPEL',
                              style: GoogleFonts.interTight(
                                textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 30,),
                              ),
                            ),
                              Text(
                              'Aplikasi Manajemen Pengelolaan Sampah',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 18,),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Image.asset("assets/images/sp.jpeg"),
                            SizedBox(height: 20,),
                  SizedBox(height: 30,),
                  Text(
                        "Jadwal Penjemputan Sampah",
                        style:  GoogleFonts.lato(
                      textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 25,),
                    ),
                        ),
                  SizedBox(height: 15,),
                  //wrapwithbuilder
                  FutureBuilder<List<Jadwal>>(
                  future: getJadwal(),
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
  
  Widget buildPosts(List<Jadwal> posts) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(posts.length, (index) {
              // SizedBox(height: 10,);
              final post = posts[index];
              DateTime dateTime = DateTime.parse(post.jadwalTugas.mulaiPenjemputan.toString());
              DateTime dateTimes = DateTime.parse(post.jadwalTugas.selesaiPenjemputan.toString());
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeTrash(id: post.jadwalTugasId,),
                  ),
                );
                },
                child: Container(
                  color: Colors.grey[100],
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                height: 100,
                  child: ListTile(
                              leading: Icon(Icons.location_city,color: Color(0xFF00A368),),
                              title: Text("Mulai: ${dateTime.day}-${dateTime.month}-${dateTime.year}               Selesai: ${dateTimes.day}-${dateTimes.month}-${dateTimes.year}", style: TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: Text(post.jadwalTugas.keterangan.toString()),
                              // trailing: Icon(CupertinoIcons.money_dollar),
                    textColor: Color(0xFF00A368),
                  ),
                ),
              );
            }),
            ),
      ),
    );

  }
}


