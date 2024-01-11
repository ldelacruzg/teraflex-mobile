part of 'simple_treatment_list_cubit.dart';

enum Status {
  loading,
  error,
  success,
  unauthorized,
  notLogged,
}

class SimpleTreatmentListState extends Equatable {
  final List<SimpleTreatment> treatments;
  final Status status;
  final String? statusMessage;

  const SimpleTreatmentListState({
    this.treatments = const [],
    this.status = Status.success,
    this.statusMessage,
  });

  SimpleTreatmentListState copyWith({
    List<SimpleTreatment>? treatments,
    Status? status,
    String? statusMessage,
  }) {
    return SimpleTreatmentListState(
      treatments: treatments ?? this.treatments,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [treatments, status];
}
