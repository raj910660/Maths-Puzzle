import 'dart:io';

import 'package:flutter/material.dart';
import 'package:math_puzzle/clearing_page.dart';
import 'package:math_puzzle/puzzle_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Data.dart';

class MathsPuzzle extends StatefulWidget {
  int? index;

  MathsPuzzle([this.index]);

  static SharedPreferences? prefs;

  State<MathsPuzzle> createState() => _MathsPuzzleState();
}

class _MathsPuzzleState extends State<MathsPuzzle> {
  bool temp = false, temp1 = false, temp2 = false;
  static List skip = [];
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    skip = List.filled(Data.puzzle_img.length, "No");
    get();
  }

  get() async {
    MathsPuzzle.prefs = await SharedPreferences.getInstance();
    index = MathsPuzzle.prefs!.getInt("lvl") ?? 0;
    for (int i = 0; i <= index; i++) {
      skip[i] = MathsPuzzle.prefs!.getString("lvl$i");
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Exit Game",),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No")),
                TextButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: Text("Yes")),
              ],
            );
          },
        );
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.grey,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/Images/background.jpg"),
                              fit: BoxFit.fill)),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Math Puzzles",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.deepPurple),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/Images/blackboard_main_menu.png"),
                                    fit: BoxFit.fill)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return puzzle(index);
                                                  },
                                                ));
                                          },
                                          child: Text(
                                            "CONTINUE",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontFamily: "chalk"),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return Clearing_Puzzle(
                                                        index, skip);
                                                  },
                                                ));
                                          },
                                          child: Text(
                                            "PUZZLES",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontFamily: "chalk"),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    "AD",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                        fontSize: 15),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/Images/ltlicon.png"))),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 0.5),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomLeft,
                                                  end: Alignment.topRight,
                                                  colors: [
                                                    Colors.grey,
                                                    Colors.white,
                                                    Colors.grey
                                                  ])),
                                          child: IconButton(
                                              onPressed: () {
                                              },
                                              icon: Icon(Icons.share)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 0.5),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                    begin: Alignment.bottomLeft,
                                                    end: Alignment.topRight,
                                                    colors: [
                                                      Colors.grey,
                                                      Colors.white,
                                                      Colors.grey
                                                    ])),
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.email_outlined)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ]),
                    ))
              ],
            ),
          )),
    );
  }
}