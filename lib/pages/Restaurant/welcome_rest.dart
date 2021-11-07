import 'package:flutter/material.dart';
import 'package:foodla/Utils/utils.dart';

class WelcomeRestaurant extends StatelessWidget {
  const WelcomeRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
      width: width,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Welcome to xyz ',
              style: TextStyle(
                fontSize: width * 0.055,
                color: Palate.primary,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
