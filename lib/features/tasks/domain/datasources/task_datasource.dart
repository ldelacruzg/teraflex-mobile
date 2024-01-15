import 'package:teraflex_mobile/features/tasks/domain/entities/multimedia.dart';

abstract class TaskDatasource {
  Future<List<Multimedia>> getVideos({required int assignmentId});
}
