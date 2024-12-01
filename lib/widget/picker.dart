// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaf_app/src/core/utils/app_colors.dart';
import 'package:kaf_app/src/core/utils/app_theme.dart';
import 'dart:ui' as ui;

class DatePickerExample extends StatefulWidget {
  final context;
  final time;
  final onDateTimeChanged;
  final choosed;
  final List<DateTime>? doctorsDays;

  DatePickerExample(
      {super.key,
      this.context,
      this.time,
      this.onDateTimeChanged,
      this.choosed,
      this.doctorsDays});

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: AspectRatio(
        aspectRatio: 1.h,
        child: CalendarCarousel<Event>(
          // height: MediaQuery.sizeOf(context).height * 0.4,
          //  Platform.isAndroid
          //     ? MediaQuery.sizeOf(context).height * .32
          //     : MediaQuery.sizeOf(context).height * .48,
          weekdayTextStyle: TextStyle(
            color: Colors.black,
          ),
          // headerTextStyle: TextStyle(
          //   color: Colors.black,
          //   fontSize: 14.0,
          //   fontWeight: FontWeight.w500,
          // ),
          onDayPressed: (date, events) {
            widget.onDateTimeChanged(date);
            setState(() {
              _currentDate = date;
            });
          },
          weekendTextStyle: TextStyle(
            color: Colors.black,
          ),
          // headerText: 'التاريخ',
          weekFormat: false,
          markedDatesMap: EventList<Event>(
            events: GenerateEventMap(),
          ),
          selectedDateTime: _currentDate,
          showIconBehindDayText: true,
          customGridViewPhysics: NeverScrollableScrollPhysics(),
          markedDateShowIcon: true,
          markedDateIconMaxShown: 2,
          markedDateIconBuilder: (event) {
            return event.icon;
          },
          minSelectedDate: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          maxSelectedDate: DateTime(DateTime.now().year + 10,
              DateTime.now().month, DateTime.now().day),
          todayButtonColor: Colors.transparent,
          todayBorderColor: Colors.transparent,
          nextMonthDayBorderColor: Colors.transparent,
          prevMonthDayBorderColor: Colors.transparent,
          selectedDayTextStyle: AppTheme.textTheme.displaySmall?.copyWith(
            color: Colors.white,
          ),
          selectedDayBorderColor: AppColors.transparent,
          markedDateIconBorderColor: AppColors.transparent,
          // thisMonthDayBorderColor: Colors.grey,
          selectedDayButtonColor: AppColors.transparent,
          showHeaderButton: false,
          showHeader: false,
          todayTextStyle: AppTheme.textTheme.headlineMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          nextDaysTextStyle: AppTheme.textTheme.headlineMedium?.copyWith(
            color: Color(0xff98A2B3),
            fontWeight: FontWeight.w600,
          ),
          prevDaysTextStyle: AppTheme.textTheme.headlineMedium?.copyWith(
            color: Color(0xff98A2B3),
            fontWeight: FontWeight.w600,
          ),
          inactiveDaysTextStyle: AppTheme.textTheme.headlineMedium?.copyWith(
            color: Color(0xff98A2B3),
            fontWeight: FontWeight.w600,
          ),
          daysHaveCircularBorder: false,
          isScrollable: false,
          weekDayFormat: WeekdayFormat.narrow,
          markedDateMoreShowTotal: true,
          customDayBuilder: (
            /// you can provide your own build function to make custom day containers
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
          ) {
            if (isToday) {
              return Center(
                child: Container(
                  width: 35.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0.r),
                    color: AppColors.primary,
                  ),
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: AppTheme.textTheme.headlineMedium?.copyWith(
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }
            if (isThisMonthDay) {
              return Center(
                child: Container(
                  width: 35.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0.r),
                    color: AppColors.lightGreen,
                  ),
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: AppTheme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Map<DateTime, List<Event>> GenerateEventMap() {
    Map<DateTime, List<Event>> eventsMap = {};
    widget.doctorsDays?.forEach((date) {
      eventsMap[date] = [
        Event(
          date: date,
          title: '',
          icon: Container(
            padding: EdgeInsets.all(10.0),
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
              color: AppColors.secondry,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            // child: Text(''),
          ),
        ),
      ];
    });
    return eventsMap;
  }
}
