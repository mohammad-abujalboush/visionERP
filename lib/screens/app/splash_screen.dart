import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/introduction_screens/intro_page_1.dart';
import 'package:vision_website/screens/app/theme_provider.dart';
import 'package:vision_website/screens/app/page_flip_builder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToIntro();
  }

  Future<void> _navigateToIntro() async {
    await Future.delayed(const Duration(seconds: 10));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const IntroPage1(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return PageFlipBuilder(
              frontBuilder: (context) => build(context),
              backBuilder: (context) => child,
              duration: const Duration(milliseconds: 800),
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Image.asset(
                  'lib/assets/images/vision_logo1.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}