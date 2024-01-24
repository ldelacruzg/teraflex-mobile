import 'package:teraflex_mobile/features/tasks/domain/datasources/task_datasource.dart';
import 'package:teraflex_mobile/features/tasks/domain/entities/multimedia.dart';
import 'package:teraflex_mobile/features/tasks/domain/entities/weekly_summary.dart';
import 'package:teraflex_mobile/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskDatasource datasource;

  TaskRepositoryImpl({required this.datasource});

  @override
  Future<List<Multimedia>> getVideos({required int assignmentId}) {
    return datasource.getVideos(assignmentId: assignmentId);
  }

  @override
  Future<WeeklySummary> finishAssignedTask({required int assignmentId}) {
    return datasource.finishAssignedTask(assignmentId: assignmentId);
  }
}
