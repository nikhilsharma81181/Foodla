import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodla/pages/Homepage/homepage.dart';
import 'package:foodla/pages/LoginPage/start_pg.dart';
import 'package:provider/provider.dart';

import 'models/restaurant_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantModel()),
        ChangeNotifierProvider(create: (_) => CartItems()),
      ],
      child: MaterialApp(
        title: 'FoodLa',
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser == null
            ? const StartPage()
            : const Homepage(),
      ),
    );
  }
}
