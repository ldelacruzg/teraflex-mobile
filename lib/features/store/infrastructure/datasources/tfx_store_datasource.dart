import 'package:dio/dio.dart';
import 'package:teraflex_mobile/config/constants/dio_teraflex_api.dart';
import 'package:teraflex_mobile/features/store/domain/datasources/store_datasource.dart';
import 'package:teraflex_mobile/features/store/domain/entities/redeem_product.dart';
import 'package:teraflex_mobile/features/store/infrastructure/mappers/redeem_product_mapper.dart';
import 'package:teraflex_mobile/features/store/infrastructure/models/tfx/tfx_redeem_product_model.dart';

class TfxStoreDatasource extends StoreDatasource {
  @override
  Future<RedeemProduct> redeemProduct(int patientId) async {
    final Response<dynamic> response;
    final dio = await DioTeraflexAPI.dio;

    try {
      response = await dio.post('/patients/$patientId/redeem');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception("Error desconcido");
    }

    final data = TfxRedeemProductModel.fromJson(response.data);
    final redeemProduct =
        RedeemProductMapper.fromTfxRedeemProductData(data.data);

    return redeemProduct;
  }
}
