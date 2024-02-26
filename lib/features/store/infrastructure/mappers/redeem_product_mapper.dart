import 'package:teraflex_mobile/features/store/domain/entities/redeem_product.dart';
import 'package:teraflex_mobile/features/store/infrastructure/models/tfx/tfx_redeem_product_model.dart';

class RedeemProductMapper {
  static RedeemProduct fromTfxRedeemProductData(
      TfxRedeemProductDataModel data) {
    return RedeemProduct(
      code: data.code,
    );
  }
}
