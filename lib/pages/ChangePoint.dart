import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipsn/model/Petugas/getkategori.dart';
import 'package:sipsn/model/Petugas/getkelolapoin.dart';
import 'package:sipsn/model/Petugas/getnasabah.dart';
import 'package:sipsn/navigation_menu.dart';
import 'package:sipsn/pages/Transaction.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePoint extends StatefulWidget {
  @override
  _ChangePointState createState() => _ChangePointState();
}

class _ChangePointState extends State<ChangePoint> {
  int? _selectedItem;
  int? _selectednasabah;
  late Future<List<Kategori>> _kategori;
  late Future<List<Poin>> _poin;
  late Future<List<Nasabahp>> _nasabah;
  late Future<String> _token;
  List data = [];
  int? _values;

  @override
  void initState() {
    super.initState();
    _token = _getToken();
    _kategori = fetchDropdownItems();
    _poin = poin();
    _nasabah = nasabah();
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }

  Future<List<Kategori>> fetchDropdownItems() async {
    final token = await _token;
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(Uri.parse('https://cleanearth.sintrenayu.com/api/lihat-kategori-sampah'), headers: headers);

    if (response.statusCode == 200) {
      final datas = json.decode(response.body);
      List<dynamic> data = datas['data']['kategori'];
      return data.map((item) => Kategori.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<List<Poin>> poin() async {
    final token = await _token;
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(Uri.parse('https://cleanearth.sintrenayu.com/api/lihat-kelola-poin'), headers: headers);

    if (response.statusCode == 200) {
      final datas = json.decode(response.body);
      List<dynamic> data = datas['data']['poin'];
      return data.map((item) => Poin.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<List<Nasabahp>> nasabah() async {
    final token = await _token;
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(Uri.parse('https://cleanearth.sintrenayu.com/api/lihat-nasabah'), headers: headers);

    if (response.statusCode == 200) {
      final datas = json.decode(response.body);
      List<dynamic> data = datas['data']['nasabah'];
      return data.map((item) => Nasabahp.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

 Future<void> changepoint() async {
    final token = await _token;
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      Uri.parse('https://cleanearth.sintrenayu.com/api/tukar-poin'),
      headers: headers,
      body: json.encode({
        "nasabah_id": _selectednasabah,
        "poin_id": _selectedItem,
      }),
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Berhasil Tukar Poin")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationMenu()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal Tukar Poin: ${data['message']}")),
      );
    }
  }
  // Future<void> getData() async {
  //   try {
  //     final response = await http.get(Uri.parse("http://192.168.21.131:8080/api/lihat-nasabah"));
  //     log(response.body);

  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.body);
  //       data = jsonData['data']['nasabah'] as List;

  //       if (data.isNotEmpty) {
  //         _values = data[0]["id"]; // Set the initial value to the first item's id
  //       }
        
  //       setState(() {});
  //     } else {
  //       print('Error: ${response.statusCode} ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/sp.jpeg"),
          fit: BoxFit.cover
          ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "Form Penukaran Poin",
              textAlign: TextAlign.center,
              style: GoogleFonts.interTight(
                        textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 20,),
                      ),
              ),
          backgroundColor: Color(0xFF00A368),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // DropdownButton(
                            //   items: data.map((e) {
                            //     return DropdownMenuItem(
                            //       value: e["id"],
                            //       child: Text(e["name"].toString()),
                            //     );
                            //   }).toList(),
                            //   value: _values,
                            //   onChanged: (v) {
                            //     setState(() {
                            //       _values = v as int?;
                            //     });
                            //   },
                            // ),
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
                          Text(
                            'Silahkan Input Poin',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontSize: 18,),
                            ),
                          ),
                          SizedBox(height: 10,),
                            FutureBuilder<List<Poin>>(
                              future: _poin,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return Text('No items available');
                                } else {
                                  return DropdownButton(
                                    value: _selectedItem,
                                    hint: Text(
                                      'Poin yang di tukar',
                                      style: GoogleFonts.lato(
                                      textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontSize: 18,),
                                    ),
                                      ),
                                    isExpanded: true,
                                    items: snapshot.data!.map((Poin item) {
                                      return DropdownMenuItem(
                                        value: item.id,
                                        child: Text(item.jumlahPoin.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedItem = newValue;
                                      });
                                    },
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 15),
                            FutureBuilder<List<Nasabahp>>(
                              future: _nasabah,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return Text('No items available');
                                } else {
                                  return DropdownButton(
                                    value: _selectednasabah,
                                    hint: Text(
                                      'Nama Nasabah',
                                      style: GoogleFonts.lato(
                                      textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontSize: 18,),
                                    ),
                                      ),
                                    isExpanded: true,
                                    items: snapshot.data!.map((Nasabahp item) {
                                      return DropdownMenuItem(
                                        value: item.id,
                                        child: Text(item.name),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectednasabah = newValue;
                                      });
                                    },
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                changepoint();
                              },
                              child: Text(
                                      'Submit',
                                      style: GoogleFonts.lato(
                                      textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontSize: 18,),
                                    ),
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      
      ),
    );
  }
}