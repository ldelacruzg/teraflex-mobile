import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String tfxApi =
      dotenv.env['TFX_API_BASE_URL'] ?? 'http://127.0.0.1:3000/api';

  static double accuracyRankDown = dotenv.env['ACCURACY_RANK_DOWN'] != null
      ? double.parse(dotenv.env['ACCURACY_RANK_DOWN']!)
      : 0.3;

  static double accuracyRankUp = dotenv.env['ACCURACY_RANK_UP'] != null
      ? double.parse(dotenv.env['ACCURACY_RANK_UP']!)
      : 1;

  static double accuracyRankSame = dotenv.env['ACCURACY_RANK_SAME'] != null
      ? double.parse(dotenv.env['ACCURACY_RANK_SAME']!)
      : 0.7;

  // ignore: non_constant_identifier_names
  static int STORE_FREE_APPOINTMENT_FXC =
      dotenv.env['STORE_FREE_APPOINTMENT_FXC'] != null
          ? int.parse(dotenv.env['STORE_FREE_APPOINTMENT_FXC']!)
          : 100;
}
