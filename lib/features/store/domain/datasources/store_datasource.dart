import 'package:teraflex_mobile/features/store/domain/entities/redeem_product.dart';

abstract class StoreDatasource {
  Future<RedeemProduct> redeemProduct(int patientId);
}
