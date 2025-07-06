// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// import '../../../../_models/date.dart';
// import '../../../../_theme/spacing.dart';
// import '../../../../_theme/variables.dart';
// import '../../../../_variables/features.dart';
// import '../../../../_widgets/others/scroll.dart' show NoScrollBars;
// import '../../../../_widgets/others/swipe_detector.dart';
// import '../../_helpers/swipe.dart';
// import '../../_state/date.dart';
// import '../yearly/month.dart';

// class MonthBuilder extends StatelessWidget {
//   const MonthBuilder({
//     super.key,
//     this.maxWidth,
//     this.spacing = 0.0,
//     required this.widget,
//     this.isInitials = false,
//   });

//   final double? maxWidth;
//   final double spacing;
//   final Widget Function(DateItem, double, double) widget;
//   final bool isInitials;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DateProvider>(builder: (context, dates, child) {
//       return SwipeDetector(
//         onSwipeRight: () => swipeToNew(isNext: false),
//         onSwipeLeft: () => swipeToNew(isNext: true),
//         child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             double height = constraints.maxHeight;
//             double width = maxWidth ?? constraints.maxWidth;

//             return SwipeDetector(
//               onSwipeRight: () => swipeToNew(isNext: false),
//               onSwipeLeft: () => swipeToNew(isNext: true),
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: NoScrollBars(
//                   child: SingleChildScrollView(
//                     padding: pad(
//                       t: medium,
//                       b: dates.calendarId.isCalendar() ? h10() : null,
//                     ),
//                     child: Wrap(
//                       spacing: 1.w,
//                       runSpacing: 1.w,
//                       children: List.generate(12, (index) {
//                         return YearMonth(indexMonth: index + 1, widget: widget());
//                       }),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     });
//   }
// }
