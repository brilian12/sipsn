import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipsn/pages/ItemPage.dart';

class TrashCategory extends StatelessWidget {
  const TrashCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Kategori Sampah", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ItemPage(),
                  ),
                );
                },
                child: Card(
                child: ListTile(
                  leading: Image.asset("assets/images/model.jpg",height: 150,),
                  title: Text('Plastik', style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text('Here is a second line'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TrashCategory(),
                  ),
                );
                },
                child: Card(
                child: ListTile(
                  leading: Image.asset("assets/images/model.jpg",height: 150,),
                  title: Text('Botol Kaca', style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text('Here is a second line'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TrashCategory(),
                  ),
                );
                },
                child: Card(
                child: ListTile(
                  leading: Image.asset("assets/images/model.jpg",height: 150,),
                  title: Text('Kardus', style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text('Here is a second line'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}