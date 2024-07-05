import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class TransDetail extends StatefulWidget {

  late final int id;
  late final DateTime tanggal;
  late final String status;
  late final int poin;

 

  TransDetail({required this.id,required this.tanggal, required this.status, required this.poin});

   

  @override
  State<TransDetail> createState() => _TransDetailState();
}

class _TransDetailState extends State<TransDetail> {
 
 
 
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
          backgroundColor: Color(0xFF00A368),
          title: Text(
            "Detail Transaksi",
            textAlign: TextAlign.center,
            style: GoogleFonts.interTight(
                      textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 20,),
                    ),
            ),
        ),
        body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                            SizedBox(height: 20,),
                            Image.asset("assets/images/sp.jpeg"),
                            SizedBox(height: 20,),
                            Text(
                              'Riwayat Tukar Poin',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(color: Color(0xFF00A368), letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 18,),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              height: 200,
                              width: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.grey.withOpacity(0.5),
                                )
                              ),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 15, left: 20),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            color: Colors.green,
                                          ),
                                          child: Icon(Icons.done,size: 20,color: Colors.white,),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            Text(
                                              "Status",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                        SizedBox(width: 100),
                                        Text(
                                              "            ${widget.status}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 15, left: 20),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            color: Colors.green,
                                          ),
                                          child: Icon(Icons.done,size: 20,color: Colors.white,),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            Text(
                                              "Tanggal",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                        SizedBox(width: 100),
                                        Text(
                                              "         ${widget.tanggal.day.toString()} / ${widget.tanggal.month.toString()} / ${widget.tanggal.year.toString()}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 15, left: 20),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            color: Colors.green,
                                          ),
                                          child: Icon(Icons.done,size: 20,color: Colors.white,),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            Text(
                                              "Point Ditukar",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                        SizedBox(width: 100),
                                        Text(
                                              "- ${widget.poin.toString()}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ],
                          ),
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