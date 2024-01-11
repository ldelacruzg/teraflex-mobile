import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teraflex_mobile/config/router/app_router.dart';
import 'package:teraflex_mobile/config/theme/app_theme.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/datasources/tfx_treatment_datasource.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/repositories/treatment_repository_impl.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/simple_treatment_list/simple_treatment_list_cubit.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/treatment_repository/treatment_repository_cubit.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TreatmentRepositoryCubit()),
        BlocProvider(
          create: (context) => SimpleTreatmentListCubit(
            treatmentRepository: TreatmentRepositoryImpl(
              datasource: TfxTreatmentDatasource(),
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: AppTheme().themeData,
      ),
    );
  }
}
