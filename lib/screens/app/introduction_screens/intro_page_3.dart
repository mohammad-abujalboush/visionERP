import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/login_page.dart';
import 'package:vision_website/screens/app/theme_provider.dart';
import 'package:vision_website/screens/app/page_flip_builder.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Get Started',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: AppTheme.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Join thousands of businesses that trust Vision ERP for their daily operations. Login to access your personalized dashboard.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.white.withOpacity(0.9),
                              fontSize: 16,
                              height: 1.6,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.white,
                      foregroundColor: AppTheme.oxfordBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () => _goToLogin(context),
                    child: Text(
                      'Get Started',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.oxfordBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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

  void _goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return PageFlipBuilder(
            frontBuilder: (context) => this,
            backBuilder: (context) => child,
            duration: const Duration(milliseconds: 800),
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}