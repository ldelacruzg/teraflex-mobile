class ProfileForm {
  final String name;
  final String lastName;
  final String dni;
  final String phone;
  final String descripcion;

  const ProfileForm({
    this.name = '',
    this.lastName = '',
    this.dni = '',
    this.phone = '',
    this.descripcion = '',
  });

  ProfileForm copyWith({
    String? name,
    String? lastName,
    String? dni,
    String? phone,
    String? descripcion,
  }) {
    return ProfileForm(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      dni: dni ?? this.dni,
      phone: phone ?? this.phone,
      descripcion: descripcion ?? this.descripcion,
    );
  }
}
