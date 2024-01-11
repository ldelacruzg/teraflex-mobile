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
    required String treatmentId,
    bool? taskDone,
  }) async {
    emit(state.copyWith(status: StatusUtil.loading));
    try {
      final tasks = await treatmentRepository.getAssignedTasks(
        treatmentId: int.parse(treatmentId),
        taskDone: taskDone,
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
}
