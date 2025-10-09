import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/introduction_screens/intro_page_3.dart';
import 'package:vision_website/screens/app/theme_provider.dart';
import 'package:vision_website/screens/app/page_flip_builder.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => _nextPage(context),
        child: Container(
          decoration: AppTheme.gradientBackground,
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Powerful Features',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: AppTheme.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Get up-to-the-minute information, streamline your processes, and choose using our cutting-edge number-crunching and report-generating tools.',
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
          ),
        ),
      ),
    );
  }

  void _nextPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const IntroPage3(),
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