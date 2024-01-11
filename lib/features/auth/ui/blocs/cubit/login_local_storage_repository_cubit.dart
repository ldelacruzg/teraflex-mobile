import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teraflex_mobile/features/auth/domain/repositories/login_local_storage_repository.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/isardb_login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_local_storage_repository_impl.dart';

part 'login_local_storage_repository_state.dart';

class LoginLocalStorageRepositoryCubit
    extends Cubit<LoginLocalStorageRepositoryState> {
  LoginLocalStorageRepositoryCubit()
      : super(
          LoginLocalStorageRepositoryState(
            repository: LoginLocalStorageRepositoryImpl(
              datasource: IsarDBLoginLocalStorageDatasource(),
            ),
          ),
        );
}
