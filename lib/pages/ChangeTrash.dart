import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as myHttp;
import 'package:sipsn/model/Petugas/getkategori.dart';
import 'package:sipsn/model/Petugas/getnasabah.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipsn/navigation_menu.dart';

class ChangeTrash extends StatefulWidget {
  late final int id;

  ChangeTrash({required this.id});

  //widget.id

  @override
  State<ChangeTrash> createState() => _ChangeTrashState();
}

class _ChangeTrashState extends State<ChangeTrash> {

  

  List data = [];
  late Future<List<Kategori>> _kategori;
  late Future<List<Nasabahp>> _nasabah;
  int? _values;
  int? _selectedkategori;
  int? _selectednasabah;
  late Future<String> _token;

  TextEditingController beratController = TextEditingController();
  
  

  @override
  void initState() {
    super.initState();
    _token = _getToken();
    _nasabah = nasabah();
    _kategori = fetchDropdownItems();
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
    final response = await myHttp.get(Uri.parse('http://192.168.1.5:8080/api/lihat-kategori-sampah'), headers: headers);

    if (response.statusCode == 200) {
      final datas = json.decode(response.body);
      List<dynamic> data = datas['data']['kategori'];
      return data.map((item) => Kategori.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<List<Nasabahp>> nasabah() async {
    final token = await _token;
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token'
    };
    final response = await myHttp.get(Uri.parse('http://192.168.1.5:8080/api/lihat-nasabah'), headers: headers);

    if (response.statusCode == 200) {
      final datas = json.decode(response.body);
      List<dynamic> data = datas['data']['nasabah'];
      return data.map((item) => Nasabahp.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<List<Nasabahp>> tukarsampah() async {
    final token = await _token;
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token'
    };
    final response = await myHttp.get(Uri.parse('http://192.168.1.5:8080/api/pemasukan-sampah/${widget.id}'), headers: headers);

    if (response.statusCode == 200) {
      final datas = json.decode(response.body);
      List<dynamic> data = datas['data']['nasabah'];
      return data.map((item) => Nasabahp.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  //  Future<List<Nasabahp>> fetchDropdownItems() async {
  //   final response = await myHttp.get(Uri.parse('http://192.168.1.5:8080/api/lihat-nasabah'));

  //   if (response.statusCode == 200) {
  //     final datas = json.decode(response.body);
  //     List<dynamic> data = datas['data']['nasabah'];
  //     return data.map((item) => Nasabahp.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load items');
  //   }
  // }

  Future<void> changepoint() async {
    final token = await _token;
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final response = await myHttp.post(
      Uri.parse('http://192.168.1.5:8080/api/pemasukan-sampah/${widget.id}'),
      headers: headers,
      body: json.encode({
        "kategori_sampah_id": _selectedkategori,
        "nasabah_id": _selectednasabah,
        "pemasukan_sampah": beratController.text,
      }),
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Berhasil Tukar Sampah")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationMenu()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal Tukar Sampah: ${data['message']}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text("Form Penukaran Sampah"),
      ),
      backgroundColor: Color(0xFF00A368),
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
                                  hint: Text('Nama Nasabah'),
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
                          FutureBuilder<List<Kategori>>(
                          future: _kategori,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Text('No items available');
                            } else {
                              return DropdownButton(
                                value: _selectedkategori,
                                hint: Text('Jenis Sampah'),
                                isExpanded: true,
                                items: snapshot.data!.map((Kategori item) {
                                  return DropdownMenuItem(
                                    value: item.id,
                                    child: Text(item.jenisSampah),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedkategori = newValue;
                                  });
                                },
                              );
                            }
                          },
                        ),
                          
                          TextFormField(
                            controller: beratController,
                            decoration: InputDecoration(
                                hintText: "Berat (Kg)",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              changepoint();
                            },
                            child: Text("Submit"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
