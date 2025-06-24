extension StringExtensions on String {
  String get maskedPhoneNumber {
    return replaceAll(RegExp(r'.(?=.{3})'), '*');
  }

  String get unformattedPhoneNumber {
    return replaceAll(RegExp(r'^08|^628|^8|^\+628'), '08');
  }

  String get maskedNoRekening {
    return replaceAll(RegExp(r'(?<=.{5}).(?=.*)'), 'x');
  }

  String get toUcWord {
    return replaceFirstMapped(RegExp(r'^[a-z]'), (match) => match.group(0)!.toUpperCase());
  }
}
