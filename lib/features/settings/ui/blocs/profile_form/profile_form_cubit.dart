import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/user/user.dart';

part 'profile_form_state.dart';

class ProfileFormCubit extends Cubit<ProfileFormState> {
  ProfileFormCubit() : super(const ProfileFormState());

  void initialize(User user) {
    emit(state.copyWith(
      name: user.firstName,
      lastName: user.lastName,
      dni: user.docNumber,
      phone: user.phone,
      description: user.description,
      birthDate: user.birthDate.isNotEmpty
          ? DateFormat('yyyy-MM-dd').format(DateTime.parse(user.birthDate))
          : '',
    ));
    print('birthDate::: ${state.birthDate.isEmpty}');
  }

  void onSubmit() {
    print('submit::: $state');
  }

  void nameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void lastNameChanged(String value) {
    emit(state.copyWith(lastName: value));
  }

  void phoneChanged(String value) {
    emit(state.copyWith(phone: value));
  }

  void birthDateChanged(String value) {
    emit(state.copyWith(birthDate: value));
  }
}
