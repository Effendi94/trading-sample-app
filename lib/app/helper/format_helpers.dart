import 'package:intl/intl.dart';

String currencyIDR(String value) {
  if (value == '') value = '0';
  String formattedValue;
  formattedValue = NumberFormat.currency(
    locale: 'id',
    symbol: 'IDR ',
    decimalDigits: 0,
  ).format(int.parse(value));
  return formattedValue;
}
