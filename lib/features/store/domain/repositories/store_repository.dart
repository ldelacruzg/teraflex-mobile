import 'package:teraflex_mobile/features/store/domain/entities/redeem_product.dart';

abstract class StoreRepository {
  Future<RedeemProduct> redeemProduct(int patiendId);
}
