import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teraflex_mobile/features/auth/domain/repositories/login_local_storage_repository.dart';
import 'package:teraflex_mobile/features/store/domain/entities/redeem_product.dart';
import 'package:teraflex_mobile/features/store/domain/repositories/store_repository.dart';
import 'package:teraflex_mobile/features/store/infrastructure/datasources/tfx_store_datasource.dart';
import 'package:teraflex_mobile/features/store/infrastructure/repositories/store_repository_impl.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

part 'redeem_product_state.dart';

class RedeemProductCubit extends Cubit<RedeemProductState> {
  final StoreRepository storeRepository =
      StoreRepositoryImpl(datasource: TfxStoreDatasource());

  final LoginLocalStorageRepository localStorageRepository;

  RedeemProductCubit({required this.localStorageRepository})
      : super(const RedeemProductState());

  Future<RedeemProduct?> redeemProduct() async {
    emit(state.copyWith(status: StatusUtil.loading));
    try {
      final patient = await localStorageRepository.getUser();
      final patientId = patient?.id;

      if (patientId == null) {
        emit(state.copyWith(
          status: StatusUtil.error,
          statusMessage: 'Posiblemente no has iniciado sesión',
        ));
        return null;
      }

      final redeemProduct = await storeRepository.redeemProduct(patientId);
      emit(state.copyWith(status: StatusUtil.success));
      return redeemProduct;
    } catch (e) {
      emit(state.copyWith(
        status: StatusUtil.error,
        statusMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }

    return null;
  }
}
