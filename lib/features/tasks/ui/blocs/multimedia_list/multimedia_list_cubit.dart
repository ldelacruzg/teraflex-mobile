import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/features/tasks/domain/entities/multimedia.dart';
import 'package:teraflex_mobile/features/tasks/domain/repositories/task_repository.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

part 'multimedia_list_state.dart';

class MultimediaListCubit extends Cubit<MultimediaListState> {
  final TaskRepository taskRepository;

  MultimediaListCubit({required this.taskRepository})
      : super(const MultimediaListState());

  Future<void> getVideos({required int assignmentId}) async {
    emit(const MultimediaListState().copyWith(
      status: StatusUtil.loading,
    ));

    try {
      final videos = await taskRepository.getVideos(assignmentId: assignmentId);
      int currentVideoIndex = 0;

      if (videos.isNotEmpty) {
        currentVideoIndex = videos.indexWhere((element) => element.status);
      }

      emit(state.copyWith(
        videos: videos,
        status: StatusUtil.success,
        currentVideoIndex: currentVideoIndex,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StatusUtil.error,
        statusMessage: e.toString(),
      ));
    }
  }

  void onChangeCurrentVideo({required int index}) {
    emit(state.copyWith(currentVideoIndex: index));
  }
}
