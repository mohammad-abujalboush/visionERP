import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/introduction_screens/intro_page_2.dart';
import 'package:vision_website/screens/app/theme_provider.dart';
import 'package:vision_website/screens/app/page_flip_builder.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => _nextPage(context),
        child: Container(
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
                          'Welcome to Vision ERP',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                color: AppTheme.white,
                                fontFamily: 'Cairo',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Optimize your business operations with our complete Enterprise Resource Planning solution. Manage all your business processes within a singular unified platform.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppTheme.white.withOpacity(0.9),
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                height: 1.6,
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
    );
  }

  void _nextPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const IntroPage2(),
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