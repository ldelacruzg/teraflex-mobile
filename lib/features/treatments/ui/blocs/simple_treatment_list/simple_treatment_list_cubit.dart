import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teraflex_mobile/features/auth/domain/repositories/login_local_storage_repository.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/isardb_login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_local_storage_repository_impl.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/simple_treatment.dart';
import 'package:teraflex_mobile/features/treatments/domain/respositories/treatment_repository.dart';

part 'simple_treatment_list_state.dart';

class SimpleTreatmentListCubit extends Cubit<SimpleTreatmentListState> {
  final TreatmentRepository _treatmentRepository;
  final LoginLocalStorageRepository _loginLocalStorage;

  SimpleTreatmentListCubit(
      {required TreatmentRepository treatmentRepository,
      LoginLocalStorageRepository? loginLSRepository})
      : _treatmentRepository = treatmentRepository,
        _loginLocalStorage = loginLSRepository ??
            LoginLocalStorageRepositoryImpl(
                datasource: IsarDBLoginLocalStorageDatasource()),
        super(const SimpleTreatmentListState());

  void loadSimpleTreatments({bool treatmentActive = true}) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final user = await _loginLocalStorage.getUser();

      if (user == null) {
        emit(state.copyWith(
          status: Status.notLogged,
          statusMessage: 'No hay usuario logueado',
        ));
        return;
      }

      final treatment = await _treatmentRepository.simpleTreatmentList(
        patientId: user.id,
        treatmentActive: treatmentActive,
      );

      emit(state.copyWith(
        treatments: treatment,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        statusMessage: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }
}
