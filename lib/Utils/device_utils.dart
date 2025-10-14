import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DeviceUtils {
  static toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 12);
  }

  ///10:00 AM
  static formatTime(String time) {
    return DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time));
  }

  ///15 jun, 2023
  static formatDate(String date) {
    date = date;
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('d MMM, yyyy');
    return outputFormat.format(inputDate);
  }

  ///11-11-2022
  static String bookingDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    final DateFormat format = DateFormat('dd-MM-yyyy');
    final String formatted = format.format(dateTime);
    return formatted;
  }

  ///
  static String twentyFourHourFormatWithDate(String date) {
    return DateFormat('hh:mm:a').format(DateTime.parse(date));
  }
}

extension StringExtension on String {
  /// String Extension Method to Convert any case to Title Case
  String toTitleCase() {
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  /// String Extension Method to Convert any case to Sentence Case
  String toSentenceCase() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// String Extension Method to prepend @ to the string
  String displayAsUsername() {
    return '@$this';
  }
}
