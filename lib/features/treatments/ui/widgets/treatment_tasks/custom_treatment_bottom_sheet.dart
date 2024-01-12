import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/treatment_detail/treatment_detail_cubit.dart';
import 'package:teraflex_mobile/features/treatments/ui/widgets/treatment_tasks/info_span.dart';
import 'package:teraflex_mobile/utils/date_util.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

class CustomTreatmentBottomSheet extends StatelessWidget {
  const CustomTreatmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = context.watch<TreatmentDetailCubit>().state;

    if (state.status == StatusUtil.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return Container(
            width: size.width,
            padding:
                const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.blueAccent[50],
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(child: Icon(Icons.keyboard_arrow_up, size: 30)),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      InfoSpan(
                        icon: Icons.calendar_month_outlined,
                        title: 'Inicio',
                        value:
                            DateUtil.getShortDate(state.treatment!.startDate),
                      ),
                      InfoSpan(
                        icon: Icons.calendar_month_rounded,
                        title: 'Terminó',
                        value: !state.treatment!.isActive
                            ? DateUtil.getShortDate(state.treatment!.endDate!)
                            : 'Aún no',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tratamiento',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.treatment!.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.treatment!.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
