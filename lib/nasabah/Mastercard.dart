import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MesterCard extends StatelessWidget {
  String satuan;
  String point;
  String saldo;
  String date;
  String cardnumber;
  Color color;

  MesterCard({
    super.key,
    required this.satuan,
    required this.point,
    required this.saldo,
    required this.date,
    required this.cardnumber,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(16)
                    ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        point,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          "${saldo} " + satuan,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24
                          ),
                          softWrap: true,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cardnumber,
                            style: TextStyle(
                          color: Colors.white,
                        ),
                          ),
                          Text(
                            date,
                            style: TextStyle(
                          color: Colors.white,
                        ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
    );
  }

  Positioned cardBackground({
    double size = 40,
    double? pTop,
    double? pBottom,
    double? pLeft,
    double? pRight,
  }) =>
      Positioned(
        left: pLeft,
        top: pTop,
        bottom: pBottom,
        right: pRight,
        child: Transform.rotate(
          angle: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(size / 6),
            ),
            height: size,
            width: size,
          ),
        ),
      );

  SizedBox masterCardLogo() {
    return SizedBox(
      width: 100,
      child: Stack(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          Positioned(
            left: 20,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}