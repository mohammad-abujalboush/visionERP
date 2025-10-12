import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/introduction_screens/intro_page_1.dart';
import 'package:vision_website/screens/app/providers/theme_provider.dart';

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
        MaterialPageRoute(builder: (context) => const IntroPage1()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isVerySmallScreen = screenSize.width < 400;

    return Scaffold(
      backgroundColor: AppTheme.athensGray,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Responsive logo container
            Container(
              width: isVerySmallScreen 
                  ? screenSize.width * 0.4
                  : isSmallScreen 
                      ? screenSize.width * 0.3
                      : 200,
              height: isVerySmallScreen 
                  ? screenSize.width * 0.4
                  : isSmallScreen 
                      ? screenSize.width * 0.3
                      : 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Image.asset(
                'lib/assets/images/vision_logo1.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: isVerySmallScreen ? 20 : 30),
            
            // Responsive progress indicator
            SizedBox(
              width: isVerySmallScreen ? 30 : 40,
              height: isVerySmallScreen ? 30 : 40,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.matisse),
              ),
            ),
          ],
        ),
      ),
    );
  }
}