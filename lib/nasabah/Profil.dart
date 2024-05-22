import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 40,),
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage("assets/images/model.jpg"),
          ),
          SizedBox(height: 20,),
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
              trailing: Icon(Icons.arrow_forward, color: Colors.grey,),
              tileColor: Colors.white,
            ),
          )
        ],
      ),
      ),
    );
  }
}