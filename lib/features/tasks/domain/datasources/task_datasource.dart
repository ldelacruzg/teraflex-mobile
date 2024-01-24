import 'package:teraflex_mobile/features/tasks/domain/entities/multimedia.dart';
import 'package:teraflex_mobile/features/tasks/domain/entities/weekly_summary.dart';

abstract class TaskDatasource {
  Future<List<Multimedia>> getVideos({required int assignmentId});
  Future<WeeklySummary> finishAssignedTask({required int assignmentId});
}
