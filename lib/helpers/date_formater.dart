String dateFormater(DateTime date) {
  const months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];
  final day = date.day.toString().length == 1 ? '0${date.day}' : date.day;
  final month = months[date.month - 1];
  final year = date.year;
  return '$day $month\n$year';
}
