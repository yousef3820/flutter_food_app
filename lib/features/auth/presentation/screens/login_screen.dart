import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/core/biometric_helper/boimetric_helper.dart';
import 'package:flutter_food_app/core/constants/colors.dart';
import 'package:flutter_food_app/core/localization/local_cubit.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/login/login_request_model.dart';
import 'package:flutter_food_app/features/auth/presentation/cubits/login/cubit/login_cubit.dart';
import 'package:flutter_food_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter_food_app/root_screen.dart';
import 'package:flutter_food_app/shared/custom_text.dart';
import 'package:flutter_food_app/shared/custom_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.isAuthunticated});
  final bool isAuthunticated;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String enteredEmail = "";
  String enteredPassword = "";
  final validatorKey = GlobalKey<FormState>();

  bool get canPressSignIn {
    if (widget.isAuthunticated) {
      return true;
    }
    return enteredEmail.isNotEmpty && enteredPassword.isNotEmpty;
  }

  bool submittedOnce = false;
  @override
  Widget build(BuildContext context) {
    void showLanguageSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('English'),
                  onTap: () {
                    context.read<LocaleCubit>().changeToEnglish(context);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 10),
                Divider(),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('العربية'),
                  onTap: () {
                    context.read<LocaleCubit>().changeToArabic(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              MainColors.mainColor.withValues(alpha: 0.2),
                              MainColors.mainColor.withValues(alpha: 0.6),
                            ],
                          ),
                        ),
                        child: Lottie.asset(
                          'assets/splash/Login.json',
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                          repeat: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Sign in Loading'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is LoginFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoginSucces) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => RootScreen()),
            );
            print("/////////////////////////////////////");
            print(state.loginedUser.data!.email);
            print("/////////////////////////////////////");
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xff08431D),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 150),
                          SvgPicture.asset(
                            "assets/logo/Logo.svg",
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomText(
                            text: "Sign in Main Title".tr(),
                            color: Colors.white,
                            weight: FontWeight.w500,
                            size: 16,
                          ),
                          const SizedBox(height: 30),
                          Form(
                            key: validatorKey,
                            child: Builder(
                              builder: (context) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  if (submittedOnce) {
                                    validatorKey.currentState?.validate();
                                  }
                                });
                                return Column(
                                  children: [
                                    CustomTextField(
                                      prefixIcon: Icons.email,
                                      hintText: 'Email Address'.tr(),
                                      inputType: TextInputType.emailAddress,
                                      isPassword: false,
                                      valdatorFunction: (value) {
                                        if (!submittedOnce) return null;
                                        if (value == null ||
                                            value.isEmpty ||
                                            !value.contains("@")) {
                                          return "Email Address Validation"
                                              .tr();
                                        }
                                        return null;
                                      },
                                      onsavedFunction: (newValue) {
                                        enteredEmail = newValue!;
                                      },
                                      onchangedFunction: (value) {
                                        setState(() {
                                          enteredEmail = value!;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                    CustomTextField(
                                      prefixIcon: Icons.lock,
                                      hintText: "Password".tr(),
                                      inputType: TextInputType.visiblePassword,
                                      isPassword: true,
                                      valdatorFunction: (value) {
                                        if (!submittedOnce) return null;
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length < 8) {
                                          return "Passwrod Validation".tr();
                                        }
                                        return null;
                                      },
                                      onsavedFunction: (newValue) {
                                        enteredPassword = newValue!;
                                      },
                                      onchangedFunction: (value) {
                                        setState(() {
                                          enteredPassword = value!;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 60),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: canPressSignIn
                                                ? () {
                                                    submittedOnce = true;
                                                    bool isValid = validatorKey
                                                        .currentState!
                                                        .validate();
                                                    if (!isValid) {
                                                      return;
                                                    }
                                                    validatorKey.currentState!
                                                        .save();
                                                    final loginRequest =
                                                        LoginRequestModel(
                                                          email: enteredEmail,
                                                          password:
                                                              enteredPassword,
                                                        );
                                                    context
                                                        .read<LoginCubit>()
                                                        .login(loginRequest);
                                                  }
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                              backgroundColor: Colors.white,
                                            ),
                                            child: Text(
                                              "sign in".tr(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (!widget.isAuthunticated)
                                          SizedBox(width: 10),
                                        if (!widget.isAuthunticated)
                                          GestureDetector(
                                            onTap: () async {
                                              bool authenticated =
                                                  await BoimetricHelper.authunticate();
                                              if (authenticated) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        RootScreen(),
                                                  ),
                                                );
                                              }
                                            },

                                            child: Container(
                                              height: 60,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withValues(alpha: 0.3),
                                                  width: 1.5,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withValues(alpha: 0.1),
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  onTap: () async {
                                                    bool authenticated =
                                                        await BoimetricHelper.authunticate();
                                                    if (authenticated) {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              const RootScreen(),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.fingerprint,
                                                      size: 40,
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              validatorKey.currentState!.reset();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(
                                    isAuthunticated: widget.isAuthunticated,
                                  ),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "sign in page choice".tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "create one".tr(),
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        63,
                                        214,
                                        146,
                                      ),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => showLanguageSheet(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.language, color: Colors.black),
                          const SizedBox(width: 6),
                          Text(
                            context.locale.languageCode.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
