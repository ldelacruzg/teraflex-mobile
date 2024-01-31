import 'package:teraflex_mobile/features/home/domain/datasources/dashboard_datasource.dart';
import 'package:teraflex_mobile/features/home/domain/entities/global_summary.dart';
import 'package:teraflex_mobile/features/home/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final DashboardDatasource datasource;

  DashboardRepositoryImpl({required this.datasource});

  @override
  Future<GlobalSummary> getGlobalSummary({required int patientId}) {
    return datasource.getGlobalSummary(patientId: patientId);
  }
}
