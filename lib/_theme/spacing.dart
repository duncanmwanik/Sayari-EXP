import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../_helpers/common/global.dart';
import '../_variables/constants.dart';

// padding
EdgeInsets padSL([String sides = 'ltrb']) => pad(s: sides, p: 48);
EdgeInsets padEL([String sides = 'ltrb']) => pad(s: sides, p: 32);
EdgeInsets padLL([String sides = 'ltrb']) => pad(s: sides, p: 24);
EdgeInsets padL([String sides = 'ltrb']) => pad(s: sides, p: 16);
EdgeInsets padNL([String sides = 'ltrb']) => pad(s: sides, p: 14);
EdgeInsets padN([String sides = 'ltrb']) => pad(s: sides, p: 12);
EdgeInsets padMN([String sides = 'ltrb']) => pad(s: sides, p: 10);
EdgeInsets padM([String sides = 'ltrb']) => pad(s: sides, p: 8);
EdgeInsets padMS([String sides = 'ltrb']) => pad(s: sides, p: 6);
EdgeInsets padS([String sides = 'ltrb']) => pad(s: sides, p: 4);
EdgeInsets padT([String sides = 'ltrb']) => pad(s: sides, p: 2);

EdgeInsets padC(String custom) {
  List pads = splitList(custom);
  double check(String side) {
    return double.tryParse(pads.firstWhere((pad) => pad.startsWith(side), orElse: () => '00').substring(1)) ?? 0;
  }

  return EdgeInsets.only(left: check('l'), top: check(itemTitle), right: check('r'), bottom: check('b'));
}

EdgeInsets pad({String s = 'ltrb', double p = 12, double? l, double? t, double? r, double? b}) {
  return EdgeInsets.only(
    left: l ?? (s.contains('l') ? p : 0),
    top: t ?? (s.contains(itemTitle) ? p : 0),
    right: r ?? (s.contains('r') ? p : 0),
    bottom: b ?? (s.contains('b') ? p : 0),
  );
}

// ---------- width
double lw() => 32;
double mw() => 16;
double msw() => 12;
double sw() => 8;
double tsw() => 6;
double tw() => 4;

// ---------- height
double h15() => 15.h;
double h10() => 10.h;
double elh() => 48;
double lh() => 32;
double mlh() => 24;
double mh() => 16;
double msh() => 12;
double sh() => 8;
double tsh() => 6;
double th() => 4;

// sized boxes
// height
Widget ph(double height) => SizedBox(height: height);
Widget tph() => ph(th());
Widget sph() => ph(sh());
Widget tsph() => ph(tsh());
Widget msph() => ph(msh());
Widget mph() => ph(mh());
Widget mlph() => ph(mlh());
Widget lph() => ph(lh());
Widget elph() => ph(elh());
Widget spph() => ph(h10());
Widget lpph() => ph(h15());
// width
Widget pw(double width) => SizedBox(width: width);
Widget tpw() => pw(tw());
Widget tspw() => pw(tsw());
Widget spw() => pw(sw());
Widget mspw() => pw(msw());
Widget mpw() => pw(mw());
Widget lpw() => pw(lw());
