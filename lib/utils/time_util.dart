class TimeUtil {
  static String getTime(double time) {
    final minutes = time.toInt();
    final seconds = ((time - minutes) * 60).toInt();

    if (minutes > 0 && seconds > 0) {
      return '$minutes min $seconds seg';
    }

    if (minutes > 0) {
      return '$minutes min';
    }

    if (seconds > 0) {
      return '$seconds seg';
    }

    return 'NO';
  }

  static Duration getDuration(double time) {
    final minutes = time.toInt();
    final seconds = ((time - minutes) * 60).toInt();

    return Duration(minutes: minutes, seconds: seconds);
  }
}
