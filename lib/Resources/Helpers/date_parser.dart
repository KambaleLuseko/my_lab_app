import 'package:date_format/date_format.dart';

String parseDate({required String date}) {
  if (date.isEmpty ||
      DateTime.tryParse(date.substring(0, date.trim().length > 10 ? 19 : 10)) ==
          null) {
    date = '0000-00-00 00:00:00';
  }
  return formatDate(
    DateTime.parse(
      date.toString().trim().substring(0, date.trim().length > 10 ? 19 : 10),
    ),
    [dd, '/', mm, '/', yyyy, ' ', HH, '\\h ', nn, 'min ', ss, '\\s'],
  );
}

String numberFormat({required String number}) {
  return (double.tryParse(number.toString()) ?? 0)
      .toStringAsFixed(2)
      .replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => "${m[1]} ",
      );
}

numberStringFormat({required double number}) {
  return number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 2);
}
