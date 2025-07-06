import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  bool isBooked = false;

  void updateIsBooked(bool value) {
    isBooked = value;
    notifyListeners();
  }
}
