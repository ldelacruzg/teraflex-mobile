import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/shared/local_storage/shared_preferences_service.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

enum ThemeState { light, dark }

// AppThemeState
class AppThemeState extends Equatable {
  final ThemeState themeState;
  final StatusUtil status;

  const AppThemeState({
    this.themeState = ThemeState.light,
    this.status = StatusUtil.initial,
  });

  ThemeState get currentThemeState => themeState;

  ThemeData get currentTheme =>
      themeState == ThemeState.light ? _getThemeLight() : _getThemeDark();

  ThemeData _getThemeLight() {
    // retornar el tema light en base al siguiente color #007bbd
    return ThemeData(
      colorSchemeSeed: const Color(0xFF007bbd),
      brightness: Brightness.light,
    );
  }

  ThemeData _getThemeDark() {
    // retornar el tema dark en base al siguiente color #007bbd
    return ThemeData(
      colorSchemeSeed: const Color(0xFF007bbd),
      brightness: Brightness.dark,
    );
  }

  AppThemeState copyWith({
    ThemeState? themeState,
    StatusUtil? status,
  }) {
    return AppThemeState(
      themeState: themeState ?? this.themeState,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [themeState, status];
}

// AppThemeCubit
class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(const AppThemeState());

  Future<void> init() async {
    emit(state.copyWith(status: StatusUtil.loading));
    final theme = await SharedPreferencesService.getTheme();
    emit(state.copyWith(themeState: theme, status: StatusUtil.success));
  }

  void toggleTheme() {
    final newTheme = state.themeState == ThemeState.light
        ? ThemeState.dark
        : ThemeState.light;
    SharedPreferencesService.setTheme(newTheme);
    emit(state.copyWith(themeState: newTheme));
  }
}
