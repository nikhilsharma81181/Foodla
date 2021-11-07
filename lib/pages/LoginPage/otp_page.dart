import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodla/Utils/utils.dart';
import 'package:foodla/pages/Homepage/homepage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final String name;
  const OtpPage({Key? key, required this.phoneNumber, required this.name})
      : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otp = TextEditingController();
  final _otpKey = GlobalKey<FormState>();
  Timer timer = Timer.periodic(const Duration(milliseconds: 0), (_) {});

  int start = 30;
  bool wait = false;
  final _firestore = FirebaseFirestore.instance;

  var verificationCode = '';

  @override
  void initState() {
    super.initState();
    signUp();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future signUp() async {
    startTimer();
    var _phoneNumber = '+91' + widget.phoneNumber.trim();
    var verifyPhoneNumber = auth.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
        verificationCompleted: (PhoneAuthCredential) {
          auth.signInWithCredential(PhoneAuthCredential).then((users) async => {
                await _firestore
                    .collection('users')
                    .doc(auth.currentUser!.uid)
                    .set({
                  'phoneNumber': widget.phoneNumber.trim(),
                  'useruid': auth.currentUser!.uid,
                  'name': widget.name,
                }, SetOptions(merge: true)).then(
                  (value) => {
                    setState(
                      () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Homepage()),
                          (route) => false,
                        );
                      },
                    ),
                  },
                ),
              });
        },
        verificationFailed: (FirebaseAuthException error) {
          setState(() {
            // ignore: avoid_print
            print(error);
          });
        },
        codeSent: (verificationId, [forceResendingToken]) {
          setState(() {
            verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            verificationCode = verificationId;
          });
        },
        timeout: const Duration(seconds: 60));
    await verifyPhoneNumber;
  }

  Future otp() async {
    try {
      await auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode, smsCode: _otp.text))
          .then((user) async => {
                //sign in was success

                await _firestore
                    .collection('users')
                    .doc(auth.currentUser!.uid)
                    .set({
                  'phonenumber': widget.phoneNumber.trim(),
                  'useruid': auth.currentUser!.uid,
                  'name': widget.name,
                  'admin': false,
                }, SetOptions(merge: true)).then((value) => {
                          //then move to authorised area
                        }),
                setState(() {}),
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Homepage(),
                  ),
                  (route) => false,
                )
              });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    // ignore: unused_local_variable
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          start = 30;

          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.032),
          child: Form(
            key: _otpKey,
            child: Column(
              children: [
                SizedBox(height: height * 0.032),
                Text(
                  'Verify Phone',
                  style: TextStyle(
                    fontSize: width * 0.055,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: height * 0.015),
                Text(
                  'code sent to +91-${widget.phoneNumber}',
                  style: TextStyle(
                    fontSize: width * 0.041,
                  ),
                ),
                SizedBox(height: height * 0.22),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: PinCodeTextField(
                    appContext: (context),
                    autoFocus: true,
                    length: 6,
                    animationType: AnimationType.fade,
                    onChanged: (_) {},
                    cursorColor: Palate.primary,
                    controller: _otp,
                    autoDisposeControllers: true,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      activeFillColor: Colors.white,
                      activeColor: Palate.primary,
                      selectedColor: Palate.primary,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.07),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t recieve code?  ',
                      style: TextStyle(
                        fontSize: width * 0.04,
                      ),
                    ),
                    Text(
                      'Resend now',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Palate.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.017),
                sendButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sendButton() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: width * 0.14,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Palate.primary,
      ),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: () {
          otp();
        },
        child: Text(
          'Verify & Proceed',
          style: TextStyle(
            fontSize: width * 0.048,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
