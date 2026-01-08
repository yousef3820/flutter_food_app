import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/core/constants/colors.dart';
import 'package:flutter_food_app/core/localization/local_cubit.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/register/register_request_model.dart';
import 'package:flutter_food_app/features/auth/presentation/cubits/register/cubit/register_cubit.dart';
import 'package:flutter_food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_food_app/root_screen.dart';
import 'package:flutter_food_app/shared/custom_text.dart';
import 'package:flutter_food_app/shared/custom_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.isAuthunticated});
  final bool isAuthunticated;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String enteredUserame = "";

  String enteredEmail = "";

  String enteredPhone = "";

  String enteredPassword = "";

  String enteredConfirmPassword = "";

  bool submittedOnce = false;

  final validatorKey = GlobalKey<FormState>();

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
                    validatorKey.currentState?.validate();

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
                    validatorKey.currentState?.validate();

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
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
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
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              MainColors.mainColor.withValues(alpha: 0.2),
                              MainColors.mainColor.withValues(alpha: 0.6),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Lottie.asset(
                            'assets/splash/Register.json',
                            width: 70,
                            height: 70,
                            repeat: true,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Text(
                        "sign up Loading".tr(),
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
          if (state is RegisterFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is RegisterSuccess) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => RootScreen()),
              (route) => false,
            );
            print("//////////////////////////");
            print(state.response.data.email);
            print(state.response.data.name);
            print(state.response.data.token);
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
                          const SizedBox(height: 100),
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
                          const SizedBox(height: 20),
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
                                      prefixIcon: Icons.person,
                                      hintText: "Username".tr(),
                                      inputType: TextInputType.emailAddress,
                                      isPassword: false,
                                      valdatorFunction: (value) {
                                        if (!submittedOnce) return null;
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length < 4) {
                                          return "user name validation".tr();
                                        }
                                        return null;
                                      },
                                      onsavedFunction: (newValue) {
                                        enteredUserame = newValue!;
                                      },
                                      onchangedFunction: (value) {
                                        setState(() {
                                          enteredUserame = value!;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    CustomTextField(
                                      prefixIcon: Icons.email,
                                      hintText: "Email Address".tr(),
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
                                    const SizedBox(height: 20),
                                    CustomTextField(
                                      prefixIcon: Icons.phone,
                                      hintText: "phone number".tr(),
                                      inputType: TextInputType.phone,
                                      isPassword: false,
                                      valdatorFunction: (value) {
                                        if (!submittedOnce) return null;
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "phone valiadtion empty".tr();
                                        }

                                        if (!RegExp(
                                          r'^[0-9]+$',
                                        ).hasMatch(value)) {
                                          return "phone validation numbers"
                                              .tr();
                                        }

                                        if (value.length < 10) {
                                          return "phone validation length".tr();
                                        }

                                        return null;
                                      },
                                      onsavedFunction: (newValue) {
                                        enteredPhone = newValue!;
                                      },
                                      onchangedFunction: (value) {
                                        setState(() {
                                          enteredPhone = value!;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 20),
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
                                      onchangedFunction: (newValue) {
                                        setState(() {
                                          enteredPassword = newValue!;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    CustomTextField(
                                      prefixIcon: Icons.lock,
                                      hintText: "confirmation password".tr(),
                                      inputType: TextInputType.visiblePassword,
                                      isPassword: true,
                                      valdatorFunction: (value) {
                                        if (!submittedOnce) return null;
                                        if (value == null || value.isEmpty) {
                                          return "confirmation password validation empty"
                                              .tr();
                                        }
                                        if (value != enteredPassword) {
                                          return "confirmation password validation not match"
                                              .tr();
                                        }
                                        return null;
                                      },
                                      onchangedFunction: (value) {
                                        setState(() {
                                          enteredConfirmPassword = value!;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 60),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              submittedOnce = true;
                                              bool isValid = validatorKey
                                                  .currentState!
                                                  .validate();
                                              if (!isValid) {
                                                return;
                                              }
                                              validatorKey.currentState!.save();
                                              final registerRequest =
                                                  RegisterRequestModel(
                                                    name: enteredUserame,
                                                    email: enteredEmail,
                                                    phone: enteredPhone,
                                                    password: enteredPassword,
                                                  );
                                              context
                                                  .read<RegisterCubit>()
                                                  .register(registerRequest);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                            ),
                                            child: Text(
                                              "sign up".tr(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
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
                                  builder: (context) => LoginScreen(
                                    isAuthunticated: widget.isAuthunticated,
                                  ),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "sign up page choice".tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "sign in choice".tr(),
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
