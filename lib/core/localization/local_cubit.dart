import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/features/auth/data/datasources/local_datasource.dart';

class LocaleCubit extends Cubit<Locale> {
  final LocalDatasource localDatasource;

  LocaleCubit(this.localDatasource, Locale initialLocale)
    : super(initialLocale);

  Future<void> changeToEnglish(BuildContext context) async {
    await context.setLocale(const Locale('en'));
    emit(const Locale('en'));
    await localDatasource.storeSecureData('locale', 'en');
  }

  Future<void> changeToArabic(BuildContext context) async {
    await context.setLocale(const Locale('ar'));
    emit(const Locale('ar'));
    await localDatasource.storeSecureData('locale', 'ar');
  }

  Future<void> toggleLanguage(BuildContext context) async {
    if (state.languageCode == 'ar') {
      await changeToEnglish(context);
    } else {
      await changeToArabic(context);
    }
  }
}
