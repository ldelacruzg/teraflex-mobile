import 'package:teraflex_mobile/features/welcome_messages/domain/entities/welcome_message.dart';

class WelcomeMessageMapper {
  static WelcomeMessage toEntityFromJson(Map<String, dynamic> json) {
    return WelcomeMessage(
      message: json['message'],
      image: json['image'],
    );
  }
}
