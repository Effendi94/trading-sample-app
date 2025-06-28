import 'package:intl/intl.dart';

String usdCurrency(double? value) {
  if (value == null) return '\$ 0';
  String formattedValue;
  final String stringValue = value.toString();
  final int actualDigits = stringValue.contains('.') ? stringValue.split('.').last.length : 0;
  final int decimalDigits = actualDigits < 2 ? 2 : actualDigits;
  formattedValue = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: decimalDigits,
  ).format(value);
  return formattedValue;
}
