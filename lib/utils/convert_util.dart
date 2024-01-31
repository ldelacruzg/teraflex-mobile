import 'dart:math';

class ConvertUtil {
  static round(double value, int precision) =>
      (value * pow(10, precision)).round() / pow(10, precision);
}
