import 'package:flutter/material.dart';
import 'package:vision_erp/main.dart';
import 'package:vision_erp/screens/app/theme_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildLogoSection(theme),
                    const SizedBox(height: 40),
                    _buildLoginForm(theme),
                    const SizedBox(height: 30),
                    _buildAdditionalOptions(theme),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(ThemeData theme) {
    var _screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: AppTheme.oxfordBlue,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person,
            color: AppTheme.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Login',
          style: theme.textTheme.displayLarge,
        ),
        const SizedBox(height: 10),
        Text(
          'Login into your account',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppTheme.oxfordBlue.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(ThemeData theme) {
    var _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Email Field
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: theme.textTheme.bodyLarge,
                prefixIcon: Icon(Icons.email, color: AppTheme.iconColor),
                border: theme.inputDecorationTheme.border,
                focusedBorder: theme.inputDecorationTheme.focusedBorder,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Password Field
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: theme.textTheme.bodyLarge,
                prefixIcon: Icon(Icons.lock, color: AppTheme.iconColor),
                border: theme.inputDecorationTheme.border,
                focusedBorder: theme.inputDecorationTheme.focusedBorder,
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 15),
            
            // Remember me & Forgot Password
            Row(
              children: [
                Transform.scale(
                  scale: 0.9,
                  child: Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                ),
                Text(
                  'Remember me',
                  style: theme.textTheme.bodyMedium,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _showForgotPasswordDialog,
                  child: Text(
                    'Forgot Password?',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            
            // Login Button
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalOptions(ThemeData theme) {
    var _screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        // Don't have an account
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.oxfordBlue.withOpacity(0.7),
              ),
            ),
            GestureDetector(
              onTap: _showRegistrationDialog,
              child: Text(
                'Register',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        
        // OR Divider
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppTheme.oxfordBlue.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'OR',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.oxfordBlue.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: AppTheme.oxfordBlue.withOpacity(0.3),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        
        // Social Login Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(Icons.g_mobiledata, 'Google', theme, isGoogle: true),
            const SizedBox(width: 20),
            _buildSocialButton(Icons.facebook, 'Facebook', theme),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label, ThemeData theme, {bool isGoogle = false}) {
    var _screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => print('$label login tapped'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.oxfordBlue.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isGoogle)
              SizedBox(
                width: 24,
                height: 24,
                child: CustomPaint(
                  painter: _GoogleLogoPainter(),
                ),
              )
            else
              Icon(icon, color: AppTheme.oxfordBlue),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Simulate login process
      Future.delayed(const Duration(seconds: 2), () {
        // Close loading dialog
        Navigator.of(context).pop();

        // Navigate to main page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Vision ERP Dashboard'),
          ),
        );
      });
    }
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Forgot Password',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        content: Text(
          'Please contact your administrator to reset your password.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.oxfordBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRegistrationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Registration',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        content: Text(
          'Please contact your administrator to create a new account.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.oxfordBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint redPaint = Paint()..color = const Color(0xFFEA4335);
    final Paint greenPaint = Paint()..color = const Color(0xFF34A853);
    final Paint bluePaint = Paint()..color = const Color(0xFF4285F4);
    final Paint yellowPaint = Paint()..color = const Color(0xFFFBBC05);
    
    final double center = size.width / 2;
    final double radius = size.width / 4;

    canvas.drawCircle(Offset(center - radius, center - radius), radius, redPaint);
    canvas.drawCircle(Offset(center + radius, center - radius), radius, greenPaint);
    canvas.drawCircle(Offset(center - radius, center + radius), radius, bluePaint);
    canvas.drawCircle(Offset(center + radius, center + radius), radius, yellowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}