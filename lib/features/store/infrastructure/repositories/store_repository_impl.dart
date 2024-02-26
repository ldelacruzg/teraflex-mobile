import 'package:teraflex_mobile/features/store/domain/datasources/store_datasource.dart';
import 'package:teraflex_mobile/features/store/domain/entities/redeem_product.dart';
import 'package:teraflex_mobile/features/store/domain/repositories/store_repository.dart';

class StoreRepositoryImpl extends StoreRepository {
  final StoreDatasource datasource;

  StoreRepositoryImpl({required this.datasource});

  @override
  Future<RedeemProduct> redeemProduct(int patiendId) {
    return datasource.redeemProduct(patiendId);
  }
}
