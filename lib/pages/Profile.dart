import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A368),
      body: Padding(
        padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 60,),
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage("assets/images/model.jpg"),
          ),
          SizedBox(height: 40,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  color: Colors.deepOrange.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 10
                )
              ]
            ),
            child: ListTile(
              title: Text('Nama'),
              subtitle: Text("Brilian Faqih"),
              leading: Icon(CupertinoIcons.person),
              // trailing: Icon(Icons.arrow_forward, color: Colors.grey,),
              tileColor: Colors.white,
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  color: Colors.deepOrange.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 10
                )
              ]
            ),
            child: ListTile(
              title: Text('Email'),
              subtitle: Text("brilianfaqih123@gmail.com"),
              leading: Icon(CupertinoIcons.mail),
              // trailing: Icon(Icons.arrow_forward, color: Colors.grey,),
              tileColor: Colors.white,
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  color: Colors.deepOrange.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 10
                )
              ]
            ),
            child: ListTile(
              title: Text('Telp'),
              subtitle: Text("082134568977"),
              leading: Icon(CupertinoIcons.phone),
              // trailing: Icon(Icons.arrow_forward, color: Colors.grey,),
              tileColor: Colors.white,
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  color: Colors.deepOrange.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 10
                )
              ]
            ),
            child: ListTile(
              title: Text('Alamat'),
              subtitle: Text("Jl Jendral Sudirman No 34, Kecamatan Jatibarang, Kabupaten Indramayu"),
              leading: Icon(CupertinoIcons.location),
              // trailing: Icon(Icons.arrow_forward, color: Colors.grey,),
              tileColor: Colors.white,
            ),
          ),
        ],
      ),
      ),
    );
  }
}