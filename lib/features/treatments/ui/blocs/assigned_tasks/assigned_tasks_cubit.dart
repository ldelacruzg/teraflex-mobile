import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment_task.dart';
import 'package:teraflex_mobile/features/treatments/domain/respositories/treatment_repository.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

part 'assigned_tasks_state.dart';

class AssignedTasksCubit extends Cubit<AssignedTasksState> {
  final TreatmentRepository treatmentRepository;

  AssignedTasksCubit({
    required this.treatmentRepository,
  }) : super(const AssignedTasksState());

  Future<void> getTasks({
    required int treatmentId,
  }) async {
    emit(state.copyWith(status: StatusUtil.loading));
    try {
      final tasks = await treatmentRepository.getAssignedTasks(
        treatmentId: treatmentId,
        completedTasks: state.completedTasks,
        pendingTasks: state.pendingTasks,
        expiredTasks: state.expiredTasks,
      );

      if (tasks.isEmpty) {
        emit(state.copyWith(
          tasks: [],
          status: StatusUtil.empty,
          statusMessage: 'No hay tareas asignadas en este tratamiento',
        ));
        return;
      }

      emit(state.copyWith(
        tasks: tasks,
        status: StatusUtil.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StatusUtil.error,
        statusMessage: e.toString(),
      ));
    }
  }

  void changePendingTasks() {
    emit(state.copyWith(pendingTasks: !state.pendingTasks));
  }

  void changeCompletedTasks() {
    emit(state.copyWith(completedTasks: !state.completedTasks));
  }

  void changeExpiredTasks() {
    emit(state.copyWith(expiredTasks: !state.expiredTasks));
  }

  TaskConfig getTaskConfig({required int taskId}) {
    final task = state.tasks.firstWhere((element) => element.task.id == taskId);
    return task.setting;
  }

  String getTaskTitle({required int taskId}) {
    final task = state.tasks.firstWhere((element) => element.task.id == taskId);
    return task.task.title;
  }

  TreatmentTask getAssignedTask({required int assigmentId}) {
    return state.tasks.firstWhere((element) => element.id == assigmentId);
  }
}
