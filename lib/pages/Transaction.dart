import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipsn/pages/ChangePoint.dart';
import 'package:intl/intl.dart';

class Transaction extends StatelessWidget {

  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    return Scaffold( appBar: AppBar(
      title: Text("Tukar Poin"),
      // backgroundColor: Color(0xFF00A368),
    ),
    body: Container(
      color: Color(0xFF00A368),
      child: ListView(
                children: [
                  SizedBox(height: 20,),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                   
                  },
                  child: Card(
                  child: ListTile(
                    leading: Icon(Icons.check_box,color: Color(0xFF00A368),),
                    title: Text(formattedDate, style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text('Sukses Tukar Poin'),
                    trailing: Icon(CupertinoIcons.money_dollar),
                  ),
                ),
                ),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Card(
                  child: ListTile(
                    leading: Icon(Icons.check_box,color: Color(0xFF00A368),),
                    title: Text('21 Mei 2024', style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text('Sukses Tukar Poin'),
                    trailing: Icon(CupertinoIcons.money_dollar),
                  ),
                ),
                ),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Card(
                  child: ListTile(
                    leading: Icon(Icons.check_box,color: Color(0xFF00A368),),
                    title: Text('22 Mei 2024', style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text('Sukses Tukar Poin'),
                    trailing: Icon(CupertinoIcons.money_dollar),
                  ),
                ),
                ),
                
              ],
            ),
          ],
      ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangePoint(),
                  ),
                );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add, color: Colors.white,),
        backgroundColor: Color(0xFF00A368),
      ),
    );
  }
}