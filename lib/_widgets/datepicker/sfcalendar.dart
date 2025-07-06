import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_helpers/extentions/strings.dart';
import '../../_theme/variables.dart';
import 'core/datepicker.dart';

class SfCalendar extends StatelessWidget {
  const SfCalendar({
    super.key,
    this.initialDate,
    this.initialDates = const [],
    this.isMultiple = false,
    this.isOverview = false,
    this.isBookingCalendar = false,
    this.noInditial = true,
    this.selectedDates = const [],
    this.onSelect,
    this.color,
    this.width,
    this.margin,
  });

  final String? initialDate;
  final List initialDates;
  final bool isMultiple;
  final bool isOverview;
  final bool isBookingCalendar;
  final bool noInditial;
  final List selectedDates;
  final Function(DateTime date)? onSelect;
  final Color? color;
  final double? width;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    double? fontSize = isOverview ? tiny : null;

    return Container(
      height: width ?? (isOverview ? 240 : 80.w),
      width: width ?? (isOverview ? 240 : 80.w),
      constraints: BoxConstraints(maxHeight: width ?? 280, maxWidth: width ?? 280),
      margin: margin,
      child: SfDateRangePicker(
        backgroundColor: transparent,
        showNavigationArrow: true,
        view: DateRangePickerView.month,
        //header
        headerStyle: DateRangePickerHeaderStyle(
          backgroundColor: transparent,
          textAlign: TextAlign.center,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: small, color: styler.textColor(faded: isOverview)),
        ),
        //month view: weekday title
        monthViewSettings: DateRangePickerMonthViewSettings(
          showTrailingAndLeadingDates: true,
          viewHeaderStyle: DateRangePickerViewHeaderStyle(
            textStyle: GoogleFonts.inter(fontSize: tiny, fontWeight: FontWeight.w500, color: styler.textColor(faded: true)),
          ),
        ),
        //month cells
        monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle: GoogleFonts.inter(fontSize: fontSize, color: styler.textColor()),
          todayTextStyle: GoogleFonts.inter(fontSize: fontSize, color: styler.accent()),
          todayCellDecoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadiusSmall)),
          trailingDatesTextStyle: GoogleFonts.inter(fontSize: fontSize, color: styler.textColor(extraFaded: true)),
          leadingDatesTextStyle: GoogleFonts.inter(fontSize: fontSize, color: styler.textColor(extraFaded: true)),
        ),
        //selected cells
        selectionTextStyle: GoogleFonts.inter(fontSize: fontSize, fontWeight: isOverview ? ft5 : null, color: white),
        selectionShape: DateRangePickerSelectionShape.circle,
        selectionColor: styler.accent(8),
        selectionMode: isMultiple ? DateRangePickerSelectionMode.multiple : DateRangePickerSelectionMode.single,
        //initial selected date
        initialSelectedDate: initialDate != null ? DateTime.tryParse(initialDate!) : null,
        initialDisplayDate: initialDate != null ? DateTime.tryParse(initialDate!) : null,
        initialSelectedDates: initialDates.isNotEmpty
            ? List.generate(
                initialDates.length,
                (index) => DateTime.parse(initialDates[index]),
              )
            : null,
        // on selecting dates
        onSelectionChanged: (DateRangePickerSelectionChangedArgs dates) {
          if (onSelect != null) {
            onSelect!(dates.value);
          } else {
            selectedDates.clear();
            if (isMultiple) {
              for (int d = 0; d < dates.value.length; d++) {
                selectedDates.add(dates.value[d].toString().datePart());
              }
            } else {
              selectedDates.add(dates.value.toString().datePart());
            }
          }
        },
      ),
    );
  }
}
