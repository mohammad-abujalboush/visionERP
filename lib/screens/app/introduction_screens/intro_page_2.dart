import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/introduction_screens/intro_page_3.dart';
import 'package:vision_website/screens/app/introduction_screens/intro_page_1.dart';
import 'package:vision_website/screens/app/providers/theme_provider.dart';
import 'package:vision_website/screens/app/page_indicator.dart';
import 'package:vision_website/screens/app/wavy_clipper.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isVerySmallScreen = screenSize.width < 400;

    return Scaffold(
      body: GestureDetector(
        onTap: () => _nextPage(context),
        onPanUpdate: (details) {
          // Swipe left to go to next page
          if (details.delta.dx < -10) {
            _nextPage(context);
          }
          // Swipe right to go back to previous page
          else if (details.delta.dx > 10) {
            _previousPage(context);
          }
        },
        child: Container(
          color: AppTheme.athensGray,
          child: SafeArea(
            child: Column(
              children: [
                ClipPath(
                  clipper: MultiCurveClipper(),
                  child: Container(
                    height: screenSize.height * 0.6,
                    width: double.infinity,
                    color: AppTheme.matisse,
                    child: Center(
                      child: SizedBox(
                        width: isVerySmallScreen
                            ? screenSize.width * 0.7
                            : isSmallScreen
                                ? screenSize.width * 0.6
                                : 350,
                        height: isVerySmallScreen
                            ? screenSize.width * 0.7
                            : isSmallScreen
                                ? screenSize.width * 0.6
                                : 350,
                        child: Image.asset(
                          'lib/assets/images/intro2.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppTheme.athensGray,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Powerful Features',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.mako,
                              fontFamily: 'Cairo',
                              fontSize: isVerySmallScreen
                                  ? 24
                                  : isSmallScreen
                                      ? 28
                                      : 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Get up-to-the-minute information and streamline your processes using our powerful tools.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.jumbo,
                              fontFamily: 'Cairo',
                              fontSize: isVerySmallScreen
                                  ? 14
                                  : isSmallScreen
                                      ? 15
                                      : 16,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 40),
                          PageIndicator(currentPage: 1, pageCount: 3),
                        ],
                      ),
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
        pageBuilder: (context, animation, secondaryAnimation) =>
            const IntroPage3(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _previousPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            IntroPage1(), // إزالة const هنا
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}