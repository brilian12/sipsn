import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifikasi extends StatelessWidget {
  const Notifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
      title: Text("Notifikasi"),
    ),
    body: Center( //biar listnya ada di tengah
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(20, (index) {
                // SizedBox(height: 10,),
                return GestureDetector(
                  child: Container(
                    color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  height: 100,
                    child: ListTile(
                                leading: Icon(Icons.location_city,color: Color(0xFF00A368),),
                                title: Text("Tanggal", style: TextStyle(fontWeight: FontWeight.bold),),
                                subtitle: Text(" Jumlah Point Ditukar"),
                                // trailing: Icon(CupertinoIcons.money_dollar),
                      textColor: Color(0xFF00A368),
                    ),
                  ),
                );
              }),
              ),
        ),
      ),
    )

    );
  }
}