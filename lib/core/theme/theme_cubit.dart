import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/features/auth/data/datasources/local_datasource.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _themeKey = 'theme_mode';
  final LocalDatasource localDatasource = locator<LocalDatasource>();

  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = await localDatasource.retrieveSecureData(_themeKey);

    if (savedTheme == 'dark') {
      emit(ThemeMode.dark);
    } else if (savedTheme == 'light') {
      emit(ThemeMode.light);
    }
  }

  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    await localDatasource.storeSecureData(
      _themeKey,
      newTheme == ThemeMode.dark ? 'dark' : 'light',
    );

    emit(newTheme);
  }
}
