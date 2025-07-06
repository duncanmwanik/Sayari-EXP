import 'package:flutter/material.dart';

import '../../../_variables/features.dart';
import 'model.dart';

// demo
const String demoEmail = 'sayaridemo@gmail.com';
const String demoPass = '1234567890';

final authFormKey = GlobalKey<FormState>();

List introFeatures = [
  IntroFeature(type: features.docs, message: 'Docs of sorts'),
  IntroFeature(type: features.calendar, message: 'A minimal calendar'),
  IntroFeature(type: features.chat, message: 'A minimal chat'),
  IntroFeature(type: features.timeline, message: "And a good day's start"),
];
