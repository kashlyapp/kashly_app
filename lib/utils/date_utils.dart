bool isLeapYear(int year) =>
    (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

DateTime parseYMD(String ymd) {
  final parts = ymd.split('-');
  if (parts.length != 3) throw FormatException('bad ymd');
  return DateTime(
    int.parse(parts[0]),
    int.parse(parts[1]),
    int.parse(parts[2]),
  );
}
