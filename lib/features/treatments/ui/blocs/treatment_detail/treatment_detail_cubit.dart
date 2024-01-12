import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment.dart';
import 'package:teraflex_mobile/features/treatments/domain/respositories/treatment_repository.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

part 'treatment_detail_state.dart';

class TreatmentDetailCubit extends Cubit<TreatmentDetailState> {
  final TreatmentRepository treatmentRepository;

  TreatmentDetailCubit({
    required this.treatmentRepository,
  }) : super(const TreatmentDetailState());

  Future<void> getTreatment({required int treatmentId}) async {
    emit(state.copyWith(status: StatusUtil.loading));
    try {
      final treatment =
          await treatmentRepository.getTreatment(treatmentId: treatmentId);
      emit(state.copyWith(
        treatment: treatment,
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
