import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teraflex_mobile/features/treatments/domain/respositories/treatment_repository.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/datasources/tfx_treatment_datasource.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/repositories/treatment_repository_impl.dart';

part 'treatment_repository_state.dart';

class TreatmentRepositoryCubit extends Cubit<TreatmentRepositoryState> {
  TreatmentRepositoryCubit() : super(TreatmentRepositoryState());
}
