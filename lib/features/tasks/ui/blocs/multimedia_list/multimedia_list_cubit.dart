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

      if (videos.isEmpty) {
        return emit(state.copyWith(
          status: StatusUtil.empty,
          statusMessage:
              'No hay videos asignados a esta tarea, contacté con su terapeuta',
        ));
      }

      int currentVideoIndex = videos.indexWhere((element) => element.status);
      bool disabled = currentVideoIndex == -1;

      emit(state.copyWith(
        videos: videos,
        status: disabled ? StatusUtil.disabled : StatusUtil.success,
        currentVideoIndex: currentVideoIndex,
        statusMessage: disabled ? 'No hay videos disponibles' : null,
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
