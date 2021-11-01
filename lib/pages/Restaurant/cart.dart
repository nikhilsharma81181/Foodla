import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodla/Utils/colors.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appbar(width),
      body: Container(
        width: width,
        color: Colors.grey.shade200,
        child: ListView(
          children: [
            SizedBox(height: width * 0.005),
            restaurantDetail(width),
            SizedBox(height: width * 0.025),
            dishes(width),
            dishes(width),
            dishes(width),
            dishes(width),
            SizedBox(height: width * 0.025),
            coupons(width),
            SizedBox(height: width * 0.025),
            billDetails(),
          ],
        ),
      ),
    );
  }

  Widget billDetails() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.04,
        horizontal: width * 0.027,
      ),
      width: width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bill Details',
            style: TextStyle(
              fontSize: width * 0.048,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: width * 0.025),
          eachBill('Item total', '₹499'),
          eachBill('Taxes and Charges', '₹30'),
          Divider(color: Colors.grey.shade300, thickness: 2),
          totalBill('Total Price', '₹429'),
          SizedBox(height: width * 0.05),
          orderPlaceButton(),
        ],
      ),
    );
  }

  Widget orderPlaceButton() {
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width * 0.472,
            height: width * 0.15,
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: Text(
              '₹429',
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: width * 0.472,
            height: width * 0.15,
            color: Palate.secondary,
            alignment: Alignment.center,
            child: Text(
              'Place order',
              style: TextStyle(
                fontSize: width * 0.05,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget totalBill(String text, price) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: width * 0.046,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget eachBill(String text, price) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: width * 0.041,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: width * 0.042,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget coupons(double width) => Container(
        padding: EdgeInsets.symmetric(
          vertical: width * 0.04,
          horizontal: width * 0.027,
        ),
        width: width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Offers',
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: width * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/GiftN.svg'),
                    SizedBox(width: width * 0.025),
                    Text(
                      'Selecte a promo code',
                      style: TextStyle(
                        fontSize: width * 0.037,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Text(
                  'View offers',
                  style: TextStyle(
                    fontSize: width * 0.039,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      );

  Widget dishes(double width) => Container(
        padding: EdgeInsets.symmetric(
          vertical: width * 0.04,
          horizontal: width * 0.027,
        ),
        width: width,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  height: width * 0.058,
                  width: width * 0.058,
                  image:
                      //  items[item]['veg']
                      //     ? const AssetImage('assets/veg-img.png')
                      //     :
                      const AssetImage('assets/images/non-veg-icon.png'),
                ),
                SizedBox(width: width * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chicken Chilli',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: width * 0.008),
                    Text(
                      '₹399',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: width * 0.008),
                    Text(
                      'CUSTOMIZED',
                      style: TextStyle(
                        fontSize: width * 0.032,
                        color: Palate.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(width * 0.02),
                  width: width * 0.27,
                  height: width * 0.095,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    border: Border.all(
                      width: 1,
                      color: Palate.primary,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.remove,
                          size: width * 0.06,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        2.toString(),
                        style: TextStyle(
                          fontSize: width * 0.044,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: width * 0.06,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: width * 0.012),
                Text(
                  '₹400',
                  style: TextStyle(
                    fontSize: width * 0.036,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget restaurantDetail(width) => Container(
        padding: EdgeInsets.all(width * 0.027),
        width: width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chef Food',
              style: TextStyle(
                fontSize: width * 0.072,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'North Indian, Mughlai, Chinese',
              style: TextStyle(
                  fontSize: width * 0.037,
                  fontWeight: FontWeight.w400,
                  height: width * 0.004),
            ),
            Text(
              '34 steet, vas vegas, 4328',
              style: TextStyle(
                  fontSize: width * 0.037,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w400,
                  height: width * 0.0034),
            ),
          ],
        ),
      );

  AppBar appbar(double width) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: width * 0.065,
        ),
      ),
    );
  }
}