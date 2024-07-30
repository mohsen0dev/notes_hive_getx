String convertGregorianToJalali(DateTime gregorianDate) {
  int gYear = gregorianDate.year;
  int gMonth = gregorianDate.month;
  int gDay = gregorianDate.day;

  List<int> gDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  List<int> jDaysInMonth = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];

  if ((gYear % 4 == 0 && gYear % 100 != 0) || gYear % 400 == 0) {
    gDaysInMonth[1] = 29;
  }

  int gy = gYear - 1600;
  int gm = gMonth - 1;
  int gd = gDay - 1;

  int gDayNo = 365 * gy + (gy + 3) ~/ 4 - (gy + 99) ~/ 100 + (gy + 399) ~/ 400;

  for (int i = 0; i < gm; ++i) {
    gDayNo += gDaysInMonth[i];
  }

  gDayNo += gd;

  int jDayNo = gDayNo - 79;

  int jNp = jDayNo ~/ 12053;
  jDayNo %= 12053;

  int jy = 979 + 33 * jNp + 4 * (jDayNo ~/ 1461);
  jDayNo %= 1461;

  if (jDayNo >= 366) {
    jy += (jDayNo - 1) ~/ 365;
    jDayNo = (jDayNo - 1) % 365;
  }

  int jm, jd;
  for (jm = 0; jm < 11 && jDayNo >= jDaysInMonth[jm]; ++jm) {
    jDayNo -= jDaysInMonth[jm];
  }
  jd = jDayNo + 1;
  jm += 1;
  return '$jy/$jm/$jd';
}
