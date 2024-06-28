// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

/// DateTime tool library
class SPDateUtils {
  /// Common date format
  static const String FORMAT_YYYY_MM_DD = "yyyy-MM-dd";
  static const String FORMAT_EEEE = "EEEE";
  static const String FORMAT_DD_MMM_YY = "dd MMM /yy";
  static const String FORMAT_DD_MM_YYYY = 'dd/MM/yyyy';
  static const String FORMAT_DD_MMM_YY_HH_A = "dd MMM yy : HHa";
  static const String FORMAT_DD_MMM_YYYY = "dd MMM yyyy";
  static const String FORMAT_DD_MMMM_YYYY = "dd MMMM, yyyy";
  static const String FORMAT_DD_MMM_YY_HH_MM = "dd MMM /yy HH:mm";
  static const String FORMAT_DD_MM = "dMMM";
  static const String FORMAT_HH_MM_A = "hh:mm a";

  ///
  static const String FORMAT_YYYYMMDD_HHMMSS = "yyyy-MM-dd HH:mm:ss";
  static const String FORMAT_YYYYMMDD_HHMMSS1 = "yyyy-MM-dd hh:mm:ss";
  static const String FORMAT_MMDD_HHMM = "MM-dd HH:mm";
  static const String FORMAT_HHMM = "HH:mm";
  static const String FORMAT_HHMM_AMPM = "hh:mm a";

  ///
  static const String FORMAT_T_YYYYMMDD = "yyyy-MM-ddTHH:mm:ss";
  static const String FORMAT_T_YYYYMMDD_SSSSSS = "yyyy-MM-ddTHH:mm:ss.SSSSSS";

  static String getTimeDifferenceString(DateTime targetDateTime) {
    DateTime currentDateTime = DateTime.now();

    Duration timeDifference = targetDateTime.difference(currentDateTime);

    if (timeDifference.isNegative) {
      return ''; // Empty string if the target date is in the future
    } else {
      if (timeDifference.inSeconds <= 60) {
        return 'Less than a minute to go';
      } else if (timeDifference.inMinutes < 60) {
        return '${timeDifference.inMinutes} minute${timeDifference.inMinutes == 1 ? '' : 's'} to go';
      } else if (timeDifference.inHours < 24) {
        return '${timeDifference.inHours} hour${timeDifference.inHours == 1 ? '' : 's'} to go';
      } else if (timeDifference.inDays < 7) {
        return '${timeDifference.inDays} day${timeDifference.inDays == 1 ? '' : 's'} to go';
      } else {
        return DateFormat.yMMMMd().format(targetDateTime);
      }
    }
  }

  static DateTime stringFormat(String? dt,
      [String formatString = FORMAT_DD_MMM_YY]) {
    if (dt == null) return DateTime.now();
    final format = DateFormat(formatString);

    return format.parse(dt);
  }

  /// Format date and time
  ///
  /// The default format is yyyy-MM-dd HH:mm:ss
  static String? format(DateTime? dt,
      [String formatString = FORMAT_DD_MMM_YY]) {
    if (dt == null) return null;

    return DateFormat(formatString).format(dt);
  }

  static String? formatLocal(DateTime? dt,
      [String formatString = FORMAT_HHMM_AMPM]) {
    if (dt == null) return null;

    return format(
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(dt.toString(), true).toLocal(),
        formatString);
  }

  /// Get the formatted string through the string
  ///
  /// If the string is invalid, return null
  static String? formatFromString(String? formattedString,
      [String formatString = FORMAT_DD_MMM_YY]) {
    final dt = DateTime.tryParse(formattedString!);
    if (dt == null) return null;

    return DateFormat(formatString).format(dt);
  }

  static String? timeFromString(String? formattedString,
      [String formatString = FORMAT_DD_MM]) {
    final dt = DateTime.tryParse(formattedString!);

    if (dt == null) return null;

    return DateFormat("dMMM").format(dt);
  }

  static int? toTimeStamp(String? formattedString,
      [String formatString = FORMAT_YYYYMMDD_HHMMSS]) {
    final dt = DateTime.tryParse(formattedString!);

    if (dt == null) return null;

    return dt.millisecondsSinceEpoch;
  }

  // ************************ Nowadays*********************** * //

  /// Today at 0 o'clock
  static DateTime get todayStart {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 0, 0, 0);
  }

  // ************************ Month ************************ * //

  /// The beginning of this month, at 0:00 on the 1st of this month, which is also the end of the previous month
  static DateTime get thisMonthStart {
    final now = DateTime.now();

    // 0 o'clock today is the end time of yesterday
    return DateTime(now.year, now.month, 1, 0, 0, 0);
  }

  /// The end of last month is the beginning of this month
  static DateTime get lastMonthEnd => thisMonthStart;

  /// Starting time of last month, 0:00 on the 1st of last month
  static DateTime get lastMonthStart {
    final now = DateTime.now();
    var year = now.year;
    var month = now.month;
    if (month == 1) {
      // If the current month is January, the previous month is December last year
      year = year - 1;
      month = 12;
    } else {
      // Otherwise, the previous month is equal to this month -1
      month = month - 1;
    }

    return DateTime(year, month, 1, 0, 0, 0);
  }

  /// The end of the month is also the beginning of the next month
  static DateTime get thisMonthEnd {
    // Because we are not sure how many days there are in this month, we calculate the start time of the next month
    final now = DateTime.now();
    var year = now.year;
    var month = now.month;
    if (month == 12) {
      // If the current month is December, the next month is January next year
      year = year + 1;
      month = 1;
    } else {
      // Otherwise the next month is equal to this month + 1
      month = month + 1;
    }

    return DateTime(year, month, 1, 0, 0, 0);
  }

  /// Get the time interval of this month (time of this month)
  static DateTimeRange get thisMonth =>
      DateTimeRange(start: thisMonthStart, end: thisMonthEnd);

  /// Get the time interval of the previous month
  static DateTimeRange get lastMonth =>
      DateTimeRange(start: lastMonthStart, end: thisMonthStart);

  // ************************ Year ************************* * //

  ///January 1st this year
  static DateTime get thisYearStart {
    final now = DateTime.now();
    return DateTime(now.year, 1, 1, 0, 0, 0);
  }

  /// Format time: date, week, hour, minute, second
  static String formatWithWeek(String? time) {
    return DateFormat('yyyy-MM-dd EEEE HH:mm:ss', "zh_CN")
        .format(DateTime.parse(time ?? '').toLocal());
  }

  /// Format time: date, hour, minute and second
  static String defaultFormatDate(String? time) {
    if (time == null || time.isEmpty) return '';
    return DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(DateTime.parse(time).toLocal());
  }

  static String dateTimeNowIso() => DateTime.now().toIso8601String();

  static int dateTimeNowMilli() => DateTime.now().millisecondsSinceEpoch;

  ///yyyy-MM-ddTHH:mm:ss.SSSSSS
  static String dateFormatTDate(String outFormatStr, String? value) {
    String formatted = "";
    try {
      DateTime tempDate =
          DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS").parse('$value');
      final DateFormat formatter = DateFormat(outFormatStr);
      formatted = formatter.format(tempDate);
      // ignore: empty_catches
    } catch (e) {}

    return formatted;
  }

  ///date format
  ///@param value input date
  ///@param inFormatStr input date format
  ///@param outFormatStr Output date format
  static String dateFormat(
      String value, String inFormatStr, String outFormatStr) {
    String formatted = "";
    try {
      DateTime tempDate = DateFormat(inFormatStr).parse(value);
      final DateFormat formatter = DateFormat(outFormatStr);
      formatted = formatter.format(tempDate);
      // ignore: empty_catches
    } catch (e) {}

    return formatted;
  }

  static DateTime addTime(DateTime dateTime1, DateTime dateTime2) {
    // Extract time components from dateTime2
    int hoursToAdd = dateTime2.hour;
    int minutesToAdd = dateTime2.minute;
    int secondsToAdd = dateTime2.second;

    // Add time components to dateTime1
    DateTime result = dateTime1.add(Duration(
      hours: hoursToAdd,
      minutes: minutesToAdd,
      seconds: secondsToAdd,
    ));

    return result;
  }

  static String formatDateTimeToTimeOffset(DateTime dateTime) {
    // Get the local timezone offset
    String timeZoneOffset = dateTime.timeZoneOffset.isNegative ? '-' : '+';
    timeZoneOffset +=
        '${dateTime.timeZoneOffset.inHours.abs() < 10 ? '0' : ''}${dateTime.timeZoneOffset.inHours.abs()}:${dateTime.timeZoneOffset.inMinutes.abs() % 60 < 10 ? '0' : ''}${dateTime.timeZoneOffset.inMinutes.abs() % 60}';

    String formattedDateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS").format(dateTime);
    return formattedDateTime + timeZoneOffset;
  }
}
