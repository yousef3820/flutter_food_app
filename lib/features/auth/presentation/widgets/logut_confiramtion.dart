import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/auth/presentation/cubits/profile/cubit/profile_cubit.dart';
import 'package:flutter_food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:lottie/lottie.dart';

class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(isAuthunticated: true),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/splash/logout.json',
                  height: 160,
                  repeat: true,
                ),
                const SizedBox(height: 16),
                Text(
                  "Logout Confirmation".tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: state is LogoutLoading
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: Text(
                          "No".tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: state is LogoutLoading
                            ? null
                            : () {
                                context.read<ProfileCubit>().logout();
                              },
                        child: state is LogoutLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "Yes".tr(),
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
