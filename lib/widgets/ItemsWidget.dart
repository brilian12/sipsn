import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sipsn/pages/Category.dart';
import 'package:sipsn/pages/ItemPage.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text("Top",
            // style: TextStyle(
            //   fontSize: 25,
            //   fontWeight: FontWeight.bold,
            //   color: Color(0xFF00A368),
            // ), 
            // ),
            // Text(
            //   "See All",
            //   style: TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black54,
            //   ),
            // )
          ],
        ),
        ),

        GridView.count(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        shrinkWrap: true,
        children: [
          // for  (int i =1; i < 8; i++)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TrashCategory(),
                  ),
                );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset("assets/images/sampah.png",
                    height: 100,
                    width: 100,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Setor Sampah",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),        
                ),
              //   Padding(padding: EdgeInsets.only(bottom: 8),
              //   child: Container(alignment: Alignment.centerLeft,
              //   child: Text(
              // "Fresh Fruit 2kg",
              // style: TextStyle(
              //   fontSize: 14,
              //   fontWeight: FontWeight.bold,
              //   color: Color(0xFF555555),
              // ),
              //   ),
              //   ),
              //   ),
                // Padding(padding: EdgeInsets.symmetric(vertical: 5),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("\$20",
                //     style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Color(0xFF00A368),
                //     ),
                //     ),
                //     InkWell(
                //       onTap: () {
                        
                //       },
                //       child: Container(
                //         padding: EdgeInsets.all(8),
                //         decoration: BoxDecoration(
                //           color: Color(0xFF00A368),
                //           borderRadius: BorderRadius.circular(10)
                //         ),
                //         child: Icon(
                //           Icons.add_shopping_cart,
                //           color: Colors.white,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ItemPage(),
                  ),
                );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset("assets/images/truck.jpg",
                    height: 100,
                    width: 100,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Tracking Pickup",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),        
                ),
              //   Padding(padding: EdgeInsets.only(bottom: 8),
              //   child: Container(alignment: Alignment.centerLeft,
              //   child: Text(
              // "Fresh Fruit 2kg",
              // style: TextStyle(
              //   fontSize: 14,
              //   fontWeight: FontWeight.bold,
              //   color: Color(0xFF555555),
              // ),
              //   ),
              //   ),
              //   ),
                // Padding(padding: EdgeInsets.symmetric(vertical: 5),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("\$20",
                //     style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Color(0xFF00A368),
                //     ),
                //     ),
                //     InkWell(
                //       onTap: () {
                        
                //       },
                //       child: Container(
                //         padding: EdgeInsets.all(8),
                //         decoration: BoxDecoration(
                //           color: Color(0xFF00A368),
                //           borderRadius: BorderRadius.circular(10)
                //         ),
                //         child: Icon(
                //           Icons.add_shopping_cart,
                //           color: Colors.white,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ItemPage(),
                  ),
                );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset("assets/images/truck.jpg",
                    height: 100,
                    width: 100,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Setor Sampah",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),        
                ),
              //   Padding(padding: EdgeInsets.only(bottom: 8),
              //   child: Container(alignment: Alignment.centerLeft,
              //   child: Text(
              // "Fresh Fruit 2kg",
              // style: TextStyle(
              //   fontSize: 14,
              //   fontWeight: FontWeight.bold,
              //   color: Color(0xFF555555),
              // ),
              //   ),
              //   ),
              //   ),
                // Padding(padding: EdgeInsets.symmetric(vertical: 5),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("\$20",
                //     style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Color(0xFF00A368),
                //     ),
                //     ),
                //     InkWell(
                //       onTap: () {
                        
                //       },
                //       child: Container(
                //         padding: EdgeInsets.all(8),
                //         decoration: BoxDecoration(
                //           color: Color(0xFF00A368),
                //           borderRadius: BorderRadius.circular(10)
                //         ),
                //         child: Icon(
                //           Icons.add_shopping_cart,
                //           color: Colors.white,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ItemPage(),
                  ),
                );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset("assets/images/truck.jpg",
                    height: 100,
                    width: 100,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Setor Sampah",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),        
                ),
              //   Padding(padding: EdgeInsets.only(bottom: 8),
              //   child: Container(alignment: Alignment.centerLeft,
              //   child: Text(
              // "Fresh Fruit 2kg",
              // style: TextStyle(
              //   fontSize: 14,
              //   fontWeight: FontWeight.bold,
              //   color: Color(0xFF555555),
              // ),
              //   ),
              //   ),
              //   ),
                // Padding(padding: EdgeInsets.symmetric(vertical: 5),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("\$20",
                //     style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Color(0xFF00A368),
                //     ),
                //     ),
                //     InkWell(
                //       onTap: () {
                        
                //       },
                //       child: Container(
                //         padding: EdgeInsets.all(8),
                //         decoration: BoxDecoration(
                //           color: Color(0xFF00A368),
                //           borderRadius: BorderRadius.circular(10)
                //         ),
                //         child: Icon(
                //           Icons.add_shopping_cart,
                //           color: Colors.white,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // )
              ],
            ),
          ),
        ],
        )
      ],
    );
  }
}