import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:math_puzzle/Data.dart';
import 'package:math_puzzle/first_page.dart';

import 'package:math_puzzle/main.dart';
import 'package:math_puzzle/puzzle_page.dart';
import 'package:share_plus/share_plus.dart';

class winpage extends StatefulWidget {
  int index;

  winpage(this.index);

  @override
  State<winpage> createState() => _winpageState();
}

class _winpageState extends State<winpage> {

  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async{showDialog(context: context, builder: (context) {
      return AlertDialog(title: Text("Are You Sure To Exit"),actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text("No")),
        TextButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return puzzle(MathsPuzzle.prefs!.getInt("lvl")??0);
          },));
        },child: Text("Yes"),)
      ],);
    },);
      return true;
    },
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/Images/background.jpg"))),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        "PUZZLE ${widget.index} COMPLETED",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20,
                            fontFamily: "chalk",
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: 350,
                          height: 500,
                          // child: Image.asset("assets/Images/trophy.png"),
                          child: Lottie.asset('assets/Lottie/Animation - 1728293479061.json'),

                        ),
                      ),

                    ],
                  ),
                ),
                Text(
                  'You Are Win.🏆',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontFamily: "chalk",
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(colors: [
                                    Colors.grey,
                                    Colors.white,
                                    Colors.grey
                                  ])),
                              child: Text("CONTINUE",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return MathsPuzzle();
                                },
                              ));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(colors: [
                                    Colors.grey,
                                    Colors.white,
                                    Colors.grey
                                  ])),
                              child: Text("MAIN MENU",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),

                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
