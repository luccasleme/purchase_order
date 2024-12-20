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
  final day = date.day;
  final month = months[date.month - 1];
  final year = date.year;
  return '$day $month\n$year';
}
