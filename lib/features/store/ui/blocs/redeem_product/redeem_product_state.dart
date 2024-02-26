part of 'redeem_product_cubit.dart';

class RedeemProductState extends Equatable {
  final StatusUtil status;
  final String? statusMessage;

  const RedeemProductState({
    this.status = StatusUtil.initial,
    this.statusMessage,
  });

  RedeemProductState copyWith({
    StatusUtil? status,
    String? statusMessage,
  }) {
    return RedeemProductState(
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [status];
}
