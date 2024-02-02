import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/user/user.dart';
import 'package:teraflex_mobile/features/auth/domain/repositories/login_local_storage_repository.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginLocalStorageRepository localStorageRepository;

  AuthCubit({required this.localStorageRepository}) : super(const AuthState());

  void loadUserFromLocalStorage() async {
    emit(state.copyWith(status: StatusUtil.loading));

    try {
      final user = await localStorageRepository.getUser();
      return emit(state.copyWith(
        user: user,
        status: StatusUtil.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StatusUtil.error,
        statusMessage: e.toString(),
      ));
    }
  }
}
