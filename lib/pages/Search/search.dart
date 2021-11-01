import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Center(
        child: Text(
          'Nahi milega hai hi nahi ',
          style: TextStyle(
            fontSize: width * 0.078,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
