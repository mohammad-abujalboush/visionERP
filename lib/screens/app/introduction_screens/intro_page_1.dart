import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/introduction_screens/intro_page_2.dart';
import 'package:vision_website/screens/app/providers/theme_provider.dart';
import 'package:vision_website/screens/app/page_flip_builder.dart';
import 'package:vision_website/screens/app/page_indicator.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isVerySmallScreen = screenSize.width < 400;
    
    return Scaffold(
      body: GestureDetector(
        onTap: () => _nextPage(context),
        child: Container(
          color: AppTheme.athensGray,
          child: SafeArea(
            child: Column(
              children: [
                // Upper half with matisse background - Only for image
                Container(
                  height: screenSize.height * 0.5,
                  width: double.infinity,
                  color: AppTheme.matisse,
                  child: Center(
                    child: Container(
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Image.asset(
                        'lib/assets/images/intro1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                
                // Lower half with athensGray background - For text and button
                Expanded(
                  child: Container(
                    color: AppTheme.athensGray,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Title
                          Text(
                            'Welcome to Vision ERP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.mako,
                              fontFamily: 'Cairo',
                              fontSize: isVerySmallScreen ? 24 : isSmallScreen ? 28 : 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Description
                          Text(
                            'Optimize your business operations with our complete Enterprise Resource Planning solution. \n'
                            'Manage all your business processes within a singular unified platform.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.jumbo,
                              fontFamily: 'Cairo',
                              fontSize: isVerySmallScreen ? 14 : isSmallScreen ? 15 : 16,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 40),
                          
                          // Page Indicator - First circle active
                          PageIndicator(
                            currentPage: 0, // First page
                            pageCount: 3,   // Total 3 intro pages
                          ),
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
        pageBuilder: (context, animation, secondaryAnimation) => const IntroPage2(),
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