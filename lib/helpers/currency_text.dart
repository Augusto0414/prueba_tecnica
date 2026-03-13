String formatCop(int amount) {
  final String digits = amount.toString();
  final StringBuffer reversed = StringBuffer();

  for (int i = 0; i < digits.length; i++) {
    if (i > 0 && i % 3 == 0) {
      reversed.write('.');
    }
    reversed.write(digits[digits.length - 1 - i]);
  }

  return 'COP \$${reversed.toString().split('').reversed.join()}';
}
