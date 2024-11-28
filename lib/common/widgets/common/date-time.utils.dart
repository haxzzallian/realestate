import 'package:intl/intl.dart';

class DateTimeUtil {
  // Format date string to dd/MM/yyyy
  static String getFormattedDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    return "$year-$month-$day";
  }

  static String getEventDate(String dateString) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateString);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  // format date string to Jan, 26
  static String getMonthDayDate(String dateString) {
    var inputDate = DateTime.parse(dateString);
    String formattedDate = DateFormat.MMMd().format(inputDate);
    return formattedDate;
  }

  // format date string to Jan, 26 2021
  static String getMonthDayYearDate(String dateString) {
    var inputDate = DateTime.parse(dateString);
    String formattedDate = DateFormat.yMMMd().format(inputDate);
    return formattedDate;
  }
}
