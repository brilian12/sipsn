import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sipsn/nasabah/Beranda.dart';
import 'package:sipsn/nasabah/Profil.dart';
import 'package:sipsn/nasabah/Transaksi.dart';

class Navigasi extends StatefulWidget {
  const Navigasi({super.key});

  @override
  State<Navigasi> createState() => _NavigasiState();
}

class _NavigasiState extends State<Navigasi> {
  int _currentIndex = 0;
  //isi menu/page
  List<Widget> body = const [
    Beranda(),
    Transaksi(),
    Profil(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Beranda",
            icon: Icon(Icons.home)
            ),
          BottomNavigationBarItem(
            label: "Transaksi",
            icon: Icon(Icons.menu)
            ),
          BottomNavigationBarItem(
            label: "Profil",
            icon: Icon(Icons.person)
            ),
        ],
        ),
    );
  }
}