part of 'treatment_repository_cubit.dart';

class TreatmentRepositoryState extends Equatable {
  final TreatmentRepository repository = TreatmentRepositoryImpl(
    datasource: TfxTreatmentDatasource(),
  );

  TreatmentRepositoryState();

  @override
  List<Object> get props => [repository];
}
