part of 'treatment_detail_cubit.dart';

class TreatmentDetailState extends Equatable {
  final Treatment? treatment;
  final StatusUtil status;
  final String? statusMessage;

  const TreatmentDetailState({
    this.treatment,
    this.status = StatusUtil.initial,
    this.statusMessage,
  });

  TreatmentDetailState copyWith({
    Treatment? treatment,
    StatusUtil? status,
    String? statusMessage,
  }) {
    return TreatmentDetailState(
      treatment: treatment ?? this.treatment,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [status];
}
