import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Palate {
  // static const Color primary = Color(0xFFF17B0D);
  static const Color primary = Color(0xFFFF5C00);
  static const Color secondary = Color(0xFF1B9719);
}

class Ref {
  static CollectionReference ordersRef =
      FirebaseFirestore.instance.collection('orders');
}
