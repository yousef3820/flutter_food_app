import 'package:flutter/material.dart';
import 'package:flutter_food_app/core/biometric_helper/boimetric_helper.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/features/auth/data/datasources/local_datasource.dart';
import 'package:flutter_food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_food_app/root_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  void _checkTokenAndNavigate() async {
    final localDatasource = locator<LocalDatasource>();

    // Retrieve token from secure storage
    final token = await localDatasource.retrieveSecureData('token');

    // Wait for the splash animation (optional)
    await Future.delayed(const Duration(seconds: 3));

    // Navigate based on token existence
    if (token != null && token.isNotEmpty) {
      print("///////////////////////////////////////");
      print(token);
      print("//////////////////////////////////////////");
      if (!await BoimetricHelper.isDeviceSupported()) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("failure")));
      }
      final availableBiometrics = await BoimetricHelper.getAvailableBiometric();
      if (availableBiometrics.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("failure")));
      }

      bool isAuthunticated = false;
      try {
        isAuthunticated = await BoimetricHelper.authunticate();
      } on Exception catch (e) {
        print("Biometric auth failed or canceled: $e");
        isAuthunticated = false;
      }
      if (isAuthunticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => RootScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LoginScreen(isAuthunticated: isAuthunticated),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen(isAuthunticated: true)),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    // Navigate after delay
    _checkTokenAndNavigate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff08431D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 250),

            // --- Animated logo ---
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SvgPicture.asset(
                  "assets/logo/Logo.svg",
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  height: 60,
                ),
              ),
            ),

            const Spacer(),

            // Bottom Image
            Image.asset("assets/splash/splash.png"),
          ],
        ),
      ),
    );
  }
}
