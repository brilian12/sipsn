import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChangePoint extends StatelessWidget {
  const ChangePoint({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    return Scaffold(
      appBar: AppBar(title: Text("Form Penukaran Poin"),),
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
                      TextFormField(
                        // controller: _namecontroller,
                        decoration: InputDecoration(
                          hintText: "Nama Nasabah",
                          border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        // controller: _namecontroller,
                        decoration: InputDecoration(
                          hintText: "Poin yang ditukar",
                          border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 30,),
                      ElevatedButton(
                      onPressed: (){},
                      child: Text("Submit")
                      )
                    ],
                  )
                  ),
              ),
          ),
        ],
      ),
    );
  }
}