import 'package:flutter/material.dart';
import 'package:flutter_bloc_app_template/index.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

enum ThemeState { light, dark, system }

final Map<ThemeState, ThemeData> _themeData = {
  ThemeState.light: Style.light,
  ThemeState.dark: Style.dark,
};

/// Saves and loads information regarding the theme setting.
@injectable
class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(defaultTheme);

  static const defaultTheme = ThemeState.system;

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    return ThemeState.values[json['value'] as int];
  }

  @override
  Map<String, int> toJson(ThemeState state) {
    return {
      'value': state.index,
    };
  }

  ThemeState get theme => state;

  set theme(ThemeState themeState) => emit(themeState);

  /// Returns appropriate theme mode
  ThemeMode get themeMode {
    switch (state) {
      case ThemeState.light:
        return ThemeMode.light;
      case ThemeState.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// Default light theme
  ThemeData get lightTheme => _themeData[ThemeState.light] ?? Style.light;

  /// Default dark theme
  ThemeData get darkTheme => _themeData[ThemeState.dark] ?? Style.dark;
}