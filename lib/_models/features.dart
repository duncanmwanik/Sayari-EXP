import 'package:flutter/material.dart';

class Feature {
  const Feature({required this.t});
  final String t;
}

class FeatureData {
  const FeatureData({
    this.title = '',
    this.message = '',
    this.intro = '',
    this.icon = Icons.circle,
    this.color = '1',
  });
  final String title;
  final String message;
  final String intro;
  final IconData icon;
  final String color;
}
