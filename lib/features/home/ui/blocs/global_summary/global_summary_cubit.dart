import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/features/auth/domain/repositories/login_local_storage_repository.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/isardb_login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_local_storage_repository_impl.dart';
import 'package:teraflex_mobile/features/home/domain/entities/global_summary.dart';
import 'package:teraflex_mobile/features/home/domain/repositories/dashboard_repository.dart';
import 'package:teraflex_mobile/utils/rank.enum.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

part 'global_summary_state.dart';

class GlobalSummaryCubit extends Cubit<GlobalSummaryState> {
  final DashboardRepository dashboardRepository;
  final LoginLocalStorageRepository loginLocalStorageRepository;

  GlobalSummaryCubit({
    required this.dashboardRepository,
    LoginLocalStorageRepository? loginLSRepository,
  })  : loginLocalStorageRepository = loginLSRepository ??
            LoginLocalStorageRepositoryImpl(
              datasource: IsarDBLoginLocalStorageDatasource(),
            ),
        super(const GlobalSummaryState());

  void getGlobalSummary() async {
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

      final globalSummary = await dashboardRepository.getGlobalSummary(
        patientId: user.id,
      );

      emit(state.copyWith(
        globalSummary: globalSummary,
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
