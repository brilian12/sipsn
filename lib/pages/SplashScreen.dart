import 'package:flutter/material.dart';
import 'package:sipsn/navigation_menu.dart';
import 'package:sipsn/pages/Homepage.dart';
import 'package:sipsn/pages/Login.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
              SizedBox(height: 450,),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                child: Ink(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF00A368),
                  ),
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 18,),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  "",
                  style: TextStyle(
                      color: Color(0xFF00A368),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}