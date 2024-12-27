import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_puzzle/Data.dart';
import 'package:math_puzzle/first_page.dart';
import 'package:math_puzzle/main.dart';
import 'package:math_puzzle/winning_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class puzzle extends StatefulWidget {
  int index;
  int? index1;

  puzzle(this.index, [this.index1]);

  State<puzzle> createState() => _puzzleState();
}

class _puzzleState extends State<puzzle> {
  TextEditingController t1 = TextEditingController();
  bool temp = false;

  get() async {
    MathsPuzzle.prefs = await SharedPreferences.getInstance();
    if (widget.index1 != null) {
      widget.index = widget.index1!;
    } else {
      widget.index = MathsPuzzle.prefs!.getInt("lvl") ?? 0;
    }
    setState(() {});
  }

  fun(String s) {
    t1.text = t1.text + s;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Are You Sure To Exit"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No")),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return MathsPuzzle();
                        },
                      ));
                    },
                    child: Text("Yes"))
              ],
            );
          },
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.brown.shade400,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Images/gameplaybackground.jpg"),
                    fit: BoxFit.fill)),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/Images/skip.png"))),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 200,
                      child: Text(
                        "Puzzle ${widget.index + 1}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            fontFamily: "chalk",
                            color: Colors.black87),
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/Images/level_board.png"),
                      )),
                    ),
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/Images/hint.png"))),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              AssetImage("${Data.puzzle_img[widget.index]}"))),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                          height: 190,
                          color: Colors.black,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white,
                                        ),
                                        child: TextField(
                                            controller: t1,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)))),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        if (t1.text.length != 0) {
                                          t1.text = t1.text
                                              .substring(0, t1.text.length - 1);
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/Images/delete.png"))),
                                      ),
                                    ),
                                  ),
                                  OutlinedButton(

                                      onPressed: () {
                                        if (t1.text ==
                                            Data.Ans[widget.index]) {
                                          if (widget.index1 == null) {
                                            MathsPuzzle.prefs!.setString(
                                                "lvl${widget.index}", "yes");
                                            widget.index++;
                                            MathsPuzzle.prefs!
                                                .setInt("lvl", widget.index);
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return winpage(widget.index);
                                              },
                                            ));
                                          } else {
                                            if (MathsPuzzle.prefs!.getString(
                                                    "lvl${widget.index}") ==
                                                "skip") {
                                              MathsPuzzle.prefs!.setString(
                                                  "lvl${widget.index}",
                                                  "yes");
                                              widget.index++;
                                            } else if (MathsPuzzle.prefs!
                                                    .getString(
                                                        "lvl${widget.index}") ==
                                                "No") {
                                              MathsPuzzle.prefs!.setString(
                                                  "lvl${widget.index}",
                                                  "yes");
                                              widget.index++;
                                              MathsPuzzle.prefs!.setInt(
                                                  "lvl", widget.index);
                                            } else {
                                              widget.index++;
                                            }
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return winpage(widget.index);
                                              },
                                            ));
                                          }
                                          if (widget.index1 == null) {
                                            widget.index = MathsPuzzle.prefs!
                                                    .getInt("lvl") ??
                                                0;
                                            MathsPuzzle.prefs!
                                                .setInt("lvl", widget.index);
                                          }
                                          t1.text = "";
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(backgroundColor: Colors.white,
                                                  content:
                                                      Text("Wrong Ans!!",style: TextStyle(color: Colors.black),)));
                                        }
                                        widget.index1 = null;
                                        setState(() {});
                                      },
                                      child: Text(
                                        "SUBMIT",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white)
                                          ),
                                          child: InkWell(
                                            onTap: () => fun("1"),
                                            child: Center(child: Text("1",style: TextStyle(color: Colors.white,fontFamily: "chalk",fontSize: 20))),

                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white)
                                          ),
                                          child: InkWell(
                                            onTap: () => fun("2"),
                                            child: Center(child: Text("2",style: TextStyle(color: Colors.white,fontFamily: "chalk",fontSize: 20))),

                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white)
                                          ),
                                          child: InkWell(
                                            onTap: () => fun("3"),
                                            child: Center(child: Text("3",style: TextStyle(color: Colors.white,fontFamily: "chalk",fontSize: 20))),

                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white)
                                          ),
                                          child: InkWell(
                                            onTap: () => fun("4"),
                                            child: Center(child: Text("4",style: TextStyle(color: Colors.white,fontFamily: "chalk",fontSize: 20))),

                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white)
                                          ),
                                          child: InkWell(
                                            onTap: () => fun("5"),
                                            child: Center(child: Text("5",style: TextStyle(color: Colors.white,fontFamily: "chalk",fontSize: 20))),

                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white)
                                          ),
                                          child: InkWell(
                                            onTap: () => fun("6"),
                                            child: Center(child: Text("6",style: TextStyle(color: Colors.white,fontFamily: "chalk",fontSize: 20))),

                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white)
                                          ),
                                          child: InkWell(
                                            onTap: () => fun("7"),
                                            child: Center(child: Text("7",style: TextStyle(color: Colors.white,fontFamily: "chalk",fontSize: 20))),

                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white)
                                          ),
                                          child: InkWell(
                                            onTap: () => fun("8"),
                                            child: Center(child: Text("8",style: TextStyle(color: Colors.white,fontFamily: "chalk",fontSize: 20))),

                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white)
                                          ),
                                          child: InkWell(
                                            onTap: () => fun("9"),
                                            child: Center(child: Text("9",style: TextStyle(color: Colors.white,fontFamily: "chalk",fontSize: 20))),

                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.white)
                                          ),
                                          child: InkWell(
                                            onTap: () => fun("0"),
                                            child: Center(child: Text("0",style: TextStyle(color: Colors.white,fontFamily: "chalk",fontSize: 20))),

                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              )

            ]),
          ),
        ),
      ),
    );
  }
}
