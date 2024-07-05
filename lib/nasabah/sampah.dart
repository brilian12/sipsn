import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySampah extends StatefulWidget {
  final String imicon;
  final String tilename;
  final String tilesubname;

  MySampah({
  Key? key,
  required this.imicon,
  required this.tilename,
  required this.tilesubname
  }) : super(key: key);

  @override
  State<MySampah> createState() => _MySampahState();
}

class _MySampahState extends State<MySampah> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [Container(
                          height: 80,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Image.asset(widget.imicon),
                        ),
      
                        SizedBox(width: 20,),
                 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tilename,
                              style: GoogleFonts.interTight(
                              textStyle: TextStyle(color: Colors.blue, letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 20,),
                        ),

                            ),
                            SizedBox(height: 8,),
                            Text(widget.tilesubname,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600]
                            ),
                            )
                          ],
                        ),],
                        ),
                        Icon(Icons.arrow_forward_ios
                        )
                      ],
                    ),
    );
  }
}


