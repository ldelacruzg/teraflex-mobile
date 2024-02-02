part of 'profile_form_cubit.dart';

class ProfileFormState extends Equatable {
  final String name;
  final String lastName;
  final String dni;
  final String phone;
  final String description;
  final String birthDate;

  const ProfileFormState({
    this.name = '',
    this.lastName = '',
    this.dni = '',
    this.phone = '',
    this.description = '',
    this.birthDate = '',
  });

  ProfileFormState copyWith({
    String? name,
    String? lastName,
    String? dni,
    String? phone,
    String? description,
    String? birthDate,
  }) {
    return ProfileFormState(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      dni: dni ?? this.dni,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  @override
  List<Object> get props =>
      [name, lastName, dni, phone, description, birthDate];
}
