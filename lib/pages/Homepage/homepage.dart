import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodla/Utils/utils.dart';
import 'package:foodla/pages/Gift/gift.dart';
import 'package:foodla/pages/Homepage/home.dart';
import 'package:foodla/pages/Qr_code/scanner.dart';
import 'package:foodla/pages/Restaurant/restaurant_detail.dart';
import 'package:foodla/pages/Search/search.dart';
import 'package:foodla/pages/User/User.dart';
import 'package:provider/src/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  List pages = [
    const Home(),
    const Search(),
    const Gift(),
    const User(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          pages[_selectedIndex],
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: width,
                  height: width * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildIcon(0, width * 0.068, width * 0.068, 'Home'),
                      buildIcon(1, width * 0.065, width * 0.065, 'Search'),
                      qrButton(),
                      buildIcon(2, width * 0.068, width * 0.068, 'Gift'),
                      buildIcon(3, width * 0.068, width * 0.068, 'User'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget qrButton() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.147,
      height: width * 0.147,
      child: RawMaterialButton(
        elevation: 14,
        fillColor: Palate.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => const Scanner()));
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RestaurantDetails()));
        },
        child: Icon(
          Icons.qr_code,
          color: Colors.white,
          size: width * 0.085,
        ),
      ),
    );
  }

  Widget buildIcon(int index, double width, height, svg) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: _selectedIndex == index
          ? SizedBox(
              width: width * 0.085,
              child: SvgPicture.asset(
                'assets/icons/${svg}B.svg',
                height: width * 0.08,
                width: width * 0.08,
                color: Palate.primary,
              ),
            )
          : SizedBox(
              width: width * 0.085,
              child: SvgPicture.asset(
                'assets/icons/${svg}N.svg',
                height: height,
                width: width,
              ),
            ),
    );
  }
}
