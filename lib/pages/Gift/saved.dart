import 'package:flutter/material.dart';

class SavedReward extends StatefulWidget {
  const SavedReward({Key? key}) : super(key: key);

  @override
  _SavedRewardState createState() => _SavedRewardState();
}

class _SavedRewardState extends State<SavedReward> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: width * 0.05),
      child: Column(
        children: [
          header(),
        ],
      ),
    );
  }

  Widget header() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.all(width * 0.032),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1.5,
          color: Colors.grey.shade400,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/gem.png',
            height: width * 0.132,
            width: width * 0.16,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.02, right: width * 0.025),
            height: width * 0.17,
            width: 1,
            color: Colors.grey.shade400,
          ),
          SizedBox(
            width: width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total saved amount',
                  style: TextStyle(
                    fontSize: width * 0.047,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Amount saved in Dine-in through Foodla.',
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
