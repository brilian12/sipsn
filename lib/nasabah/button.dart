import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatefulWidget {

  final String iconimage;
  final String buttontext;

  MyButton({
  Key? key,
  required this.iconimage,
  required this.buttontext
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}



class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
                    children: [
                      Container(
                    height: 90,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white10,
                          blurRadius: 40,
                          spreadRadius: 10,
                        )
                      ]
                      ),
                    child: Center(
                      child: Image.asset(widget.iconimage),

                    ),
                  ),
                  SizedBox(height: 12,),
                  Text(widget.buttontext,
                  style: GoogleFonts.interTight(
                      textStyle: TextStyle(color: Colors.grey[700], letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 18,),
                    ),
                  )
                    ],
                  );
  }
}







