import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipsn/model/Petugas/getriwayat.dart';
import 'package:sipsn/pages/ChangePoint.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';


import 'package:sipsn/pages/TransDetail.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;
  late Future<List<Riwayatp>> riwayat;
  final riwayatListKey = GlobalKey<_TransactionState>();

  @override
  void initState() {
    super.initState();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("token") ?? "";
    });
    riwayat = getRiwayat();
  }

  Future<List<Riwayatp>> getRiwayat() async {
    // Riwayat user;
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + (await _token)
    };
    final response = await myHttp.get(
      // Uri.parse('http://pkmsmkteladankertasemaya.com/api/profile'),
      Uri.parse('https://cleanearth.sintrenayu.com/api/lihat-riwayat-tukar-poin-petugas'),
      headers: headers,
    );
    Map<String, dynamic> jsonResult = jsonDecode(response.body);
    print(jsonResult['data']);
    List<Riwayatp> riwayat = [];
    for (var item in jsonResult['data']['tukar'] as List) {
      Riwayatp tasks = Riwayatp.fromJson(item);

      riwayat.add(tasks);

      print(riwayat.first);
    }
    // print("data riwayat");
    return riwayat;

    // return jsonResult.map((e) => Riwayat.fromJson(e)).toList();
  }


 @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    return Scaffold( 
      backgroundColor: Colors.white,
    body: Center(
        // FutureBuilder
        child: FutureBuilder<List<Riwayatp>>(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangePoint(),
                  ),
                );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add, color: Colors.white,),
        backgroundColor: Color(0xFF00A368),
      ),
    );
  }

Widget buildPosts(List<Riwayatp> posts) {
    return Scaffold(
      appBar: AppBar(
        title: 
          Text(
              "Riwayat Tukar Poin",
              textAlign: TextAlign.center,
              style: GoogleFonts.interTight(
                        textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 20,),
                      ),
              ),
            backgroundColor: Color(0xFF00A368),
        ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(posts.length, (index) {
                // SizedBox(height: 10,);
                final post = posts[index];
                DateTime dateTime = DateTime.parse(post.tanggal.toString());
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TransDetail(id: post.id, tanggal: post.tanggal, status: post.status, poin: post.kurang_poin),
                          ),
                    );
                  },
                  child: Container(
                    color: Colors.grey[100],
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  height: 100,
                    child: ListTile(
                                leading: Icon(Icons.transfer_within_a_station,color: Color(0xFF00A368),),
                                title: Text("Tanggal : ${dateTime.day}-${dateTime.month}-${dateTime.year}", style: TextStyle(fontWeight: FontWeight.bold),),
                                subtitle: Text(" Jumlah Point Ditukar : ${post.status}"),
                                // trailing: Icon(CupertinoIcons.money_dollar),
                      textColor: Color(0xFF00A368),
                    ),
                  ),
                );
              }),
              ),
        ),
      ),
    );

  }
  
}


