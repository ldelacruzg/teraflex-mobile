import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/features/tasks/domain/entities/weekly_summary.dart';
import 'package:teraflex_mobile/features/tasks/domain/repositories/task_repository.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

part 'weekly_summary_state.dart';

class WeeklySummaryCubit extends Cubit<WeeklySummaryState> {
  final TaskRepository taskRepository;

  WeeklySummaryCubit({
    required this.taskRepository,
  }) : super(const WeeklySummaryState());

  void finishAssignedTask({required int assignmentId}) async {
    emit(const WeeklySummaryState().copyWith(status: StatusUtil.loading));

    try {
      final weeklySummary =
          await taskRepository.finishAssignedTask(assignmentId: assignmentId);

      emit(state.copyWith(
        status: StatusUtil.success,
        weeklySummary: weeklySummary,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StatusUtil.error,
        statusMessage: e.toString(),
      ));
    }
  }
}
