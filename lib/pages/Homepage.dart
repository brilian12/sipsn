import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sipsn/pages/Profile.dart';
import 'package:sipsn/widgets/BottomCartSheet.dart';
import 'package:sipsn/widgets/CategoriesWidget.dart';
import 'package:sipsn/widgets/ItemsWidget.dart';
import 'package:sipsn/widgets/PopularItemsWidget.dart';
// import 'package:sliding_sheet/sliding_sheet.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A368),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 20, left: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color(0xFF00A368),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 2,
                          ),
                        ]),
                    child: InkWell(
                      onTap: () {
                        // showSlidingBottomSheet(
                        //   context, 
                        //   builder: (context){
                        //     return SlidingSheetDialog(
                        //       elevation: 8,
                        //       cornerRadius: 16,
                        //       builder: (context, state) {
                        //         return BottomCartSheet();
                        //       },
                        //     );
                        //   }
                        //   );
                      },
                      child: Icon(
                        CupertinoIcons.cart,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),

            //welcome text
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hallo, Petugas",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Miftahus Surur",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "Tetap Semangat Melakukan Pekerjaan Ini",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "Penyetoran Sampah", textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            //search widget
            
                  // Icon(Icons.search),
                  // Container(
                  //   margin: EdgeInsets.only(left: 10),
                  //   width: 200,
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //       hintText: "Search Here....",
                  //       border: InputBorder.none,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.all(15),
                  //   padding: EdgeInsets.symmetric(horizontal: 15),
                  //   height: 150,
                  //   // padding: EdgeInsets.all(30),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(20)),
                  //     color: Color(0xfff1f3f6)
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "20,000",
                  //             style: TextStyle(
                  //               fontSize: 22,
                  //               fontWeight: FontWeight.w700
                  //             ),
                  //           ),
                  //           SizedBox(height: 5,),
                  //           Text(
                  //             "Point anda",
                  //             style: TextStyle(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w400
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Container(
                  //         height: 60,
                  //         width: 60,
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: Color(0xFF00A368),
                  //         ),
                  //         child: Icon(
                  //           Icons.money,
                  //           size: 30,
                  //         ),
                  //       )
                  //     ],
                  //   )
                  // ),
                   

            

            //products widgets
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Color(0xFF00A368),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
                },
                child: Card(
                child: ListTile(
                  leading: Icon(Icons.check_box,color: Color(0xFF00A368),),
                  title: Text('21 Mei 2024', style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text('Sukses Tukar Sampah'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
              ),
                  // CategoriesWidget(),
                  // PopularItemsWidget(),
                   //ItemsWidget()
                  
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}