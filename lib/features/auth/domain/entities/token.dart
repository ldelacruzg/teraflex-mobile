class JwtToken {
  final int id;
  final String docNumber;
  final String role;

  JwtToken({
    required this.id,
    required this.docNumber,
    required this.role,
  });

  Map<String, dynamic> toObject() {
    return {
      'id': id,
      'docNumber': docNumber,
      'role': role,
    };
  }
}
