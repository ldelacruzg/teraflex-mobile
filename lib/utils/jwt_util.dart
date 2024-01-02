import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/token.dart';

class JwtUtil {
  static JwtToken getJwtToken(String token) {
    final data = JwtDecoder.decode(token);
    return JwtToken(
      id: data['id'],
      docNumber: data['docNumber'],
      role: data['role'],
    );
  }
}
