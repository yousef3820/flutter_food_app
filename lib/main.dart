import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/core/localization/local_cubit.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/core/theme/app_theme.dart';
import 'package:flutter_food_app/core/theme/theme_cubit.dart';
import 'package:flutter_food_app/features/auth/data/datasources/local_datasource.dart';
import 'package:flutter_food_app/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  init(); 

  final localDatasource = locator<LocalDatasource>();
  final storedLocaleCode = await localDatasource.retrieveSecureData('locale');
  final initialLocale = storedLocaleCode != null
      ? Locale(storedLocaleCode)
      : const Locale('en');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/langs',
      startLocale: initialLocale,
      child: MyApp(initialLocale: initialLocale),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    final localDatasource = LocalDatasource();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocaleCubit(localDatasource, initialLocale),
        ),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
