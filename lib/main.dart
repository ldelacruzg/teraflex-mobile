import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teraflex_mobile/config/router/app_router.dart';
import 'package:teraflex_mobile/config/theme/bloc/app_theme/app_theme_cubit.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/isardb_login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/tfx_login_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_local_storage_repository_impl.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_repository_impl.dart';
import 'package:teraflex_mobile/features/auth/ui/blocs/auth/auth_cubit.dart';
import 'package:teraflex_mobile/features/home/infrastructure/datasources/tfx_dashboard_datasource.dart';
import 'package:teraflex_mobile/features/home/infrastructure/repositories/dashboard_repository_impl.dart';
import 'package:teraflex_mobile/features/home/ui/blocs/global_summary/global_summary_cubit.dart';
import 'package:teraflex_mobile/features/leaderboard/infrastructure/datasources/tfx_leaderboard_datasource.dart';
import 'package:teraflex_mobile/features/leaderboard/infrastructure/repositories/leaderboard_repository_impl.dart';
import 'package:teraflex_mobile/features/leaderboard/ui/blocs/current_week_leaderboard/current_week_leaderboard_cubit.dart';
import 'package:teraflex_mobile/features/notifications/ui/blocs/notifications/notifications_cubit.dart';
import 'package:teraflex_mobile/features/settings/ui/blocs/profile_form/profile_form_cubit.dart';
import 'package:teraflex_mobile/features/tasks/infrastructure/datasources/tfx_task_datasource.dart';
import 'package:teraflex_mobile/features/tasks/infrastructure/repositories/task_repository_impl.dart';
import 'package:teraflex_mobile/features/tasks/ui/blocs/multimedia_list/multimedia_list_cubit.dart';
import 'package:teraflex_mobile/features/tasks/ui/blocs/task_execution/task_execution_cubit.dart';
import 'package:teraflex_mobile/features/tasks/ui/blocs/weekly_summary/weekly_summary_cubit.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/datasources/tfx_treatment_datasource.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/repositories/treatment_repository_impl.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/assigned_tasks/assigned_tasks_cubit.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/simple_treatment_list/simple_treatment_list_cubit.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/treatment_detail/treatment_detail_cubit.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/treatment_repository/treatment_repository_cubit.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationsCubit.initializeFCM();
  await dotenv.load(fileName: ".env");
  runApp(MultiBlocProvider(
    providers: [BlocProvider(create: (context) => NotificationsCubit())],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tfxTreatmentRepository =
        TreatmentRepositoryImpl(datasource: TfxTreatmentDatasource());

    final tfxTaskRepository =
        TaskRepositoryImpl(datasource: TfxTaskDatasource());

    final tfxLeaderboardRepository =
        LeaderboardRepositoryImpl(datasource: TfxLeaderboardDatasource());

    final tfxDashboardRepository =
        DashboardRepositoryImpl(datasource: TfxDashboardDatasource());

    final localStorageRepository = LoginLocalStorageRepositoryImpl(
      datasource: IsarDBLoginLocalStorageDatasource(),
    );

    final tfxLoginRepository = LoginRepositotyImpl(
      datasource: TfxLoginDatasource(),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TreatmentRepositoryCubit()),
        BlocProvider(
          create: (context) => SimpleTreatmentListCubit(
              treatmentRepository: tfxTreatmentRepository),
        ),
        BlocProvider(
          create: (context) =>
              AssignedTasksCubit(treatmentRepository: tfxTreatmentRepository),
        ),
        BlocProvider(
          create: (context) =>
              TreatmentDetailCubit(treatmentRepository: tfxTreatmentRepository),
        ),
        BlocProvider(
          create: (context) =>
              MultimediaListCubit(taskRepository: tfxTaskRepository),
        ),
        BlocProvider(create: (context) => TaskExecutionCubit()),
        BlocProvider(
          create: (context) => WeeklySummaryCubit(
            taskRepository: tfxTaskRepository,
          ),
        ),
        BlocProvider(
          create: (context) => CurrentWeekLeaderboardCubit(
            leaderboardRepository: tfxLeaderboardRepository,
          ),
        ),
        BlocProvider(
          create: (context) => GlobalSummaryCubit(
            dashboardRepository: tfxDashboardRepository,
          ),
        ),
        BlocProvider(create: (context) => AppThemeCubit()),
        BlocProvider(
          create: (context) => AuthCubit(
            localStorageRepository: localStorageRepository,
            loginRepository: tfxLoginRepository,
          ),
        ),
        BlocProvider(create: (context) => ProfileFormCubit()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    super.initState();
    context.read<AppThemeCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppThemeCubit>().state;

    if (state.status == StatusUtil.loading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: state.currentTheme,
    );
  }
}
