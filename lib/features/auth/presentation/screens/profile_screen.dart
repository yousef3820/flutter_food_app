import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/core/localization/local_cubit.dart';
import 'package:flutter_food_app/core/theme/theme_cubit.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/profile/update_profile_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/get_profile_data/profile_response_model.dart';
import 'package:flutter_food_app/features/auth/presentation/cubits/profile/cubit/profile_cubit.dart';
import 'package:flutter_food_app/features/auth/presentation/widgets/logut_confiramtion.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? pickedImage;
  var enteredName = "";
  var enteredEmail = "";
  var enteredAddress = "";
  final ImagePicker _picker = ImagePicker();
  final validatorKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

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

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/splash/add_user.json',
                width: 150,
                height: 150,
                repeat: true,
              ),
              const SizedBox(height: 10),
              Text(
                "Success".tr(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Continue".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile details".tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 10),
          centerTitle: true,
          actions: [
            SizedBox(width: 10),
            IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              icon: Icon(
                context.watch<ThemeCubit>().state == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: context.watch<ThemeCubit>().state == ThemeMode.light
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                size: 30,
              ),
            ),
            GestureDetector(
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
          ],
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileSuccess) {
              showSuccessDialog(context, "Update Profile Result".tr());
              if (pickedImage != null) {
                setState(() {
                  pickedImage = null;
                });
              }
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }

            if (state is ProfileFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileCubit>().getProfileData();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        "Retry".tr(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }

            ProfileResponseModel? currentProfile;
            if (state is ProfileSuccess) {
              currentProfile = state.profileData;
            }

            if (currentProfile == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }

            return LiquidPullToRefresh(
              onRefresh: () async {
                context.read<ProfileCubit>().getProfileData();
              },
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Colors.white,
              height: 180,
              animSpeedFactor: 2,
              showChildOpacityTransition: true,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: const Color.fromARGB(
                                255,
                                210,
                                206,
                                206,
                              ),
                              child: ClipOval(
                                child: SizedBox(
                                  width: 140,
                                  height: 140,
                                  child: pickedImage != null
                                      ? Image.file(
                                          pickedImage!,
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: currentProfile.data.image,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                                Icons.person,
                                                size: 60,
                                                color: Colors.white,
                                              ),
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: _pickImage,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),

                      // FORM
                      Form(
                        key: validatorKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Name".tr(),
                              ),
                              initialValue: currentProfile.data.name,
                              onSaved: (v) => enteredName = v ?? "",
                            ),
                            SizedBox(height: 30),

                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Email".tr(),
                              ),
                              initialValue: currentProfile.data.email,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (v) => enteredEmail = v ?? "",
                            ),
                            SizedBox(height: 30),

                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Delivery address".tr(),
                              ),
                              initialValue: currentProfile.data.address,
                              onSaved: (v) => enteredAddress = v ?? "",
                            ),

                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: state is UpdateProfileLoading
                                        ? null
                                        : () {
                                            if (validatorKey.currentState!
                                                .validate()) {
                                              validatorKey.currentState!.save();

                                              final req =
                                                  UpdateProfileRequestModel(
                                                    email: enteredEmail,
                                                    name: enteredName,
                                                    address: enteredAddress,
                                                    image: pickedImage,
                                                  );

                                              context
                                                  .read<ProfileCubit>()
                                                  .updateProfileData(req);
                                            }
                                          },
                                    child: state is UpdateProfileLoading
                                        ? SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Edit profile".tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                              SizedBox(width: 10),
                                              Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                                SizedBox(width: 10),

                                // Logout Button
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (_) =>
                                            const LogoutConfirmDialog(),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Log out".tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(Icons.logout, size: 25),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
