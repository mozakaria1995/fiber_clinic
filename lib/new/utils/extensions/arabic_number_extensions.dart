
extension NumberConverter on String {
  static const Map<String, String> arabicDigits = <String, String>{
    '0': '\u0660',
    '1': '\u0661',
    '2': '\u0662',
    '3': '\u0663',
    '4': '\u0664',
    '5': '\u0665',
    '6': '\u0666',
    '7': '\u0667',
    '8': '\u0668',
    '9': '\u0669',
  };

  String toArabicDigits() {
    final String number = toString();
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < number.length; i++) {
      sb.write(arabicDigits[number[i]] ?? number[i]);
    }
    return sb.toString();
  }
  String toArabicWeekDay() {
    switch (this.toLowerCase()) {
      case "friday": { return "الجمعة";}
      case "saturday": { return "السبت";}
      case "sunday": { return "الآحد";}
      case "monday": { return "الأثنين";}
      case "tuesday": { return "الثلاثاء";}
      case "wednesday": { return "الأربعاء";}
      case "thursday": { return "الخميس";}
    }
    return "" ;
  }

  String toArabicMonth() {
    switch (this.toLowerCase()) {
      case "jan": { return "يناير";}
      case "feb": { return "فبراير";}
      case "mar": { return "مارس";}
      case "apr": { return "إبريل";}
      case "may": { return "مايو";}
      case "jun": { return "يونيو";}
      case "jul": { return "يوليو";}
      case "aug": { return "أغسطس";}
      case "sep": { return "سبتمبر";}
      case "oct": { return "أكتوبر";}
      case "nov": { return "نوفمبر";}
      case "dec": { return "ديسمبر";}
    }
    return "" ;
  }
}
