import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/login_page.dart';
import 'package:vision_website/screens/app/providers/theme_provider.dart';
import 'package:vision_website/screens/app/page_flip_builder.dart';
import 'package:vision_website/screens/app/page_indicator.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isVerySmallScreen = screenSize.width < 400;
    
    return Scaffold(
      body: GestureDetector(
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
                        'lib/assets/images/intro3.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                
                // Lower half with athensGray background
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
                            'Ready to Start?',
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
                            'Join thousands of businesses that trust Vision ERP for their daily operations. '
                            'Login to access your personalized dashboard.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.jumbo,
                              fontFamily: 'Cairo',
                              fontSize: isVerySmallScreen ? 14 : isSmallScreen ? 15 : 16,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 40),
                          
                          // Page Indicator - Third circle active
                          PageIndicator(
                            currentPage: 2, // Third page
                            pageCount: 3,   // Total 3 intro pages
                          ),
                          
                          const SizedBox(height: 30),
                          
                          // Get Started button
                          SizedBox(
                            width: isVerySmallScreen 
                                ? screenSize.width * 0.8
                                : isSmallScreen 
                                    ? screenSize.width * 0.6
                                    : 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.diSerria,
                                foregroundColor: AppTheme.athensGray,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 3,
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                              ),
                              onPressed: () => _goToLogin(context),
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  color: AppTheme.athensGray,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isVerySmallScreen ? 16 : 18,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
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