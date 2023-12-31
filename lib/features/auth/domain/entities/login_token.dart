class LoginToken {
  final String token;
  final String role;
  final bool firstTime;

  LoginToken({
    required this.token,
    required this.role,
    required this.firstTime,
  });

  getString() {
    return {
      'token': token,
      'role': role,
      'firstTime': firstTime,
    };
  }
}
