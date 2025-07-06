import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'indicator.dart';

class AppPie extends StatefulWidget {
  const AppPie({
    super.key,
    required this.label,
    required this.data,
    this.size,
    this.showInfo = true,
    this.isLarge = false,
  });

  final String label;
  final List data;
  final double? size;
  final bool showInfo;
  final bool isLarge;

  @override
  State<AppPie> createState() => _AppPieState();
}

class _AppPieState extends State<AppPie> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    double size = widget.size ?? (widget.isLarge ? 200 : 50);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // title
        if (widget.showInfo)
          Align(
            alignment: Alignment.topLeft,
            child: Planet(
              noStyling: true,
              margin: padM('t'),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(Icons.circle, size: small, faded: true),
                  spw(),
                  AppText(widget.label, faded: true),
                ],
              ),
            ),
          ),
        if (widget.showInfo) sph(),
        // pie
        SizedBox(
          width: size,
          height: size,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: size / (widget.isLarge ? 4 : 2),
              sections: List.generate(widget.data.length, (index) {
                Map pieObject = widget.data[index];

                final isTouched = index == touchedIndex;
                final radius = isTouched ? 60.0 : 50.0;

                return PieChartSectionData(color: pieObject['color'], value: pieObject['value'], radius: radius, showTitle: false);
              }),
            ),
          ),
        ),
        // info
        if (widget.showInfo) mph(),
        if (widget.showInfo)
          for (var pieObject in widget.data) Indicator(color: pieObject['color'], text: pieObject['title']),
        //
      ],
    );
  }
}
