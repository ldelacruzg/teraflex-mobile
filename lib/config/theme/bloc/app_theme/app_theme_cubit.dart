import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeState { light, dark }

class AppThemeCubit extends Cubit<ThemeState> {
  AppThemeCubit() : super(ThemeState.light);

  void toggleTheme() {
    emit(state == ThemeState.light ? ThemeState.dark : ThemeState.light);
  }
}
