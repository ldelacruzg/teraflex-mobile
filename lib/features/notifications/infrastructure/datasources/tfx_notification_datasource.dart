import 'package:dio/dio.dart';
import 'package:teraflex_mobile/config/constants/dio_teraflex_api.dart';
import 'package:teraflex_mobile/features/notifications/domain/datasources/notification_datasorce.dart';
import 'package:teraflex_mobile/features/notifications/domain/entities/notification.dart';
import 'package:teraflex_mobile/features/notifications/infrastructure/mappers/notification_mapper.dart';
import 'package:teraflex_mobile/features/notifications/infrastructure/models/tfx/tfx_notification_model.dart';

class TfxNotificationDatasource extends NotificationDatasorce {
  @override
  Future<void> registerToken({
    required String token,
    required String device,
  }) async {
    final dio = await DioTeraflexAPI.dio;

    try {
      await dio.post('/notification-token/register-device', data: {
        'token': token,
        'device': device,
      });
    } on DioException catch (e) {
      throw Exception('Error controlado ${e.response?.data.toString()}');
    } catch (e) {
      throw Exception('Error desconocido ${e.toString()}');
    }
  }

  @override
  Future<List<MyNotification>> getNotifications() async {
    late Response<dynamic> response;
    final dio = await DioTeraflexAPI.dio;

    try {
      response = await dio.get('/notification/all');
    } on DioException catch (e) {
      throw Exception('Error controlado ${e.response?.data.toString()}');
    } catch (e) {
      throw Exception('Error desconocido ${e.toString()}');
    }

    final data = TfxNotificationModel.fromJson(response.data);
    final notifications = NotificationMapper.fromTfxNotification(data);

    return notifications;
  }
}
