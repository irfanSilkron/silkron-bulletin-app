import 'package:intl/intl.dart';

final today = DateTime.now();

String formatDate(String dateString) {
  final DateTime date = DateTime.parse(dateString);
  if (date.year == today.year &&
      date.month == today.month &&
      date.day == today.day) {
    return 'Today';
  }
  return DateFormat('dd/MM/yyyy').format(date);
}
