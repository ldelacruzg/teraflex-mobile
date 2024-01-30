import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/features/auth/domain/repositories/login_local_storage_repository.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/isardb_login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_local_storage_repository_impl.dart';
import 'package:teraflex_mobile/features/leaderboard/domain/entities/leaderboard_row.dart';
import 'package:teraflex_mobile/features/leaderboard/domain/repositories/leaderboard_repository.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

part 'current_week_leaderboard_state.dart';

class CurrentWeekLeaderboardCubit extends Cubit<CurrentWeekLeaderboardState> {
  final LeaderboardRepository leaderboardRepository;
  final LoginLocalStorageRepository loginLocalStorageRepository;

  CurrentWeekLeaderboardCubit({
    required this.leaderboardRepository,
    LoginLocalStorageRepository? loginLSRepository,
  })  : loginLocalStorageRepository = loginLSRepository ??
            LoginLocalStorageRepositoryImpl(
              datasource: IsarDBLoginLocalStorageDatasource(),
            ),
        super(const CurrentWeekLeaderboardState());

  Future<void> getCurrentWeekLeaderboard() async {
    emit(state.copyWith(status: StatusUtil.loading));

    try {
      // obtener el id del paciente
      final user = await loginLocalStorageRepository.getUser();

      if (user == null) {
        return emit(state.copyWith(
          status: StatusUtil.none,
          statusMessage: 'No hay usuario logueado',
        ));
      }

      final leaderboard = await leaderboardRepository.getCurrentWeekLeaderboard(
        patientId: user.id,
      );

      emit(state.copyWith(
        leaderboard: leaderboard,
        status: StatusUtil.success,
      ));
    } on DioException {
      emit(state.copyWith(
        status: StatusUtil.empty,
        statusMessage:
            'Completa una tarea para unirte a la compentencia de esta semana',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StatusUtil.error,
        statusMessage: e.toString(),
      ));
    }
  }
}
