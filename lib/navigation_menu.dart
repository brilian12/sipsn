import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipsn/pages/Homepage.dart';
import 'package:sipsn/pages/Profile.dart';
import 'package:sipsn/pages/Transaction.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _currentIndex = 0;
  //isi menu/page
  List<Widget> body = const [
    Homepage(),
    Transaction(),
    Profile(),
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
            label: "Tukar",
            icon: Icon(CupertinoIcons.money_dollar)
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
