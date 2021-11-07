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
            ? StartPage()
            : Homepage(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return const Homepage();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        } else {
          return const StartPage();
        }
      },
    );
  }
}
