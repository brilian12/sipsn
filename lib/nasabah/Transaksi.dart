import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as myHttp;
import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';

import 'package:sipsn/model/getriwayat.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;
  late Future<List<Riwayat>> riwayat;
  final riwayatListKey = GlobalKey<_TransaksiState>();

  @override
  void initState() {
    super.initState();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("token") ?? "";
    });
    riwayat = getRiwayat();
  }

  Future<List<Riwayat>> getRiwayat() async {
    // Riwayat user;
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + (await _token)
    };
    final response = await myHttp.get(
      // Uri.parse('http://pkmsmkteladankertasemaya.com/api/profile'),
      Uri.parse('http://192.168.1.5:8080/api/lihat-riwayat-tukar-poin'),
      headers: headers,
    );
    Map<String, dynamic> jsonResult = jsonDecode(response.body);
    print(jsonResult['data']);
    List<Riwayat> riwayat = [];
    for (var item in jsonResult['data']['tukar'] as List) {
      Riwayat tasks = Riwayat.fromJson(item);

      riwayat.add(tasks);

      print(riwayat.first);
    }
    // print("data riwayat");
    return riwayat;

    // return jsonResult.map((e) => Riwayat.fromJson(e)).toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A368),
      body: Center(
        // FutureBuilder
        child: FutureBuilder<List<Riwayat>>(
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
    );
    }



     Widget buildPosts(List<Riwayat> posts) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(posts.length, (index) {
              // SizedBox(height: 10,);
              final post = posts[index];
              DateTime dateTime = DateTime.parse(post.tanggal.toString());
              return GestureDetector(
                child: Container(
                  color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                height: 80,
                  child: ListTile(
                              leading: Icon(Icons.location_city,color: Color(0xFF00A368),),
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
    );

  }
}
      // body: SafeArea(
      //     child: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       FutureBuilder<List<Riwayat>>(
      //           future: riwayat,
      //           builder: (context, snapshot) {
      //             if (snapshot.connectionState == ConnectionState.waiting) {
      //               return const Center(child: CircularProgressIndicator());
      //             } else if (snapshot.hasError) {
      //               return Center(child: Text(snapshot.error.toString()));
      //             } else {
      //               return ListView.builder(
      //                   itemCount: snapshot.data!.length,
      //                   itemBuilder: (BuildContext context, int index) {
      //                     var data = snapshot.data![index];
      //                     print(data);
      //                     return Text("");
      //                   });
      //             }
      //           }),
      //     ],
      //   ),
      // )),
    