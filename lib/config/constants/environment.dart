import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String tfxApi =
      dotenv.env['TFX_API_BASE_URL'] ?? 'http://127.0.0.1:3000/api';
}
