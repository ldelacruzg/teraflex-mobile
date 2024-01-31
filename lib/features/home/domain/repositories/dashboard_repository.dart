import 'package:teraflex_mobile/features/home/domain/entities/global_summary.dart';

abstract class DashboardRepository {
  Future<GlobalSummary> getGlobalSummary({required int patientId});
}
