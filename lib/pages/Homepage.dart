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
      Uri.parse('http://10.0.141.25:8080/api/profile-petugas'),
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
      Uri.parse('http://192.168.1.5:8080/api/lihat-lokasi'),
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
      backgroundColor: Color(0xFF00A368),
      body: Center(
        child: 
            FutureBuilder(
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
              ) , 
      )
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
                  color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                height: 100,
                  child: ListTile(
                              leading: Icon(Icons.location_city,color: Color(0xFF00A368),),
                              title: Text("Mulai: ${dateTime.day}-${dateTime.month}-${dateTime.year}  Selesai: ${dateTimes.day}-${dateTimes.month}-${dateTimes.year}", style: TextStyle(fontWeight: FontWeight.bold),),
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


