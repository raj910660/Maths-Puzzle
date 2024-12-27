import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:math_puzzle/first_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(

        child: Lottie.asset(
          'assets/Lottie/Animation - 1728297884015.json',
          width: 700,
          height: 700,

          onLoaded: (composition) {
            Future.delayed(composition.duration, () {
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MathsPuzzle();
                    },
                  ));
            });
          },
        ),
      ),
    );
  }
}

