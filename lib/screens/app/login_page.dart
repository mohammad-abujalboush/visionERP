import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/home_page.dart';
import 'package:vision_website/screens/app/providers/theme_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppTheme.athensGray, // Changed background to athensGray
      body: SafeArea(
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
    );
  }

  Widget _buildLogoSection(ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.matisse, // Changed to matisse color
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            color: AppTheme.athensGray, // White icon on blue background
            size: 40,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Login',
          style: TextStyle(
            color: AppTheme.matisse, // Changed to matisse color
            fontFamily: 'Cairo',
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Login into your account',
          style: TextStyle(
            color: AppTheme.matisse.withOpacity(0.7), // Changed to matisse color
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.athensGray, // Changed to athensGray
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
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: 'User Name',
                labelStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.mako, // Dark text color
                ),
                prefixIcon: Icon(Icons.person, color: AppTheme.matisse), // matisse icon
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppTheme.silverSand),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppTheme.silverSand),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppTheme.matisse, width: 2), // matisse border
                ),
                filled: true,
                fillColor: AppTheme.athensGray,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your user name';
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
                labelStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.mako, // Dark text color
                ),
                prefixIcon: Icon(Icons.lock, color: AppTheme.matisse), // matisse icon
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppTheme.silverSand),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppTheme.silverSand),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppTheme.matisse, width: 2), // matisse border
                ),
                filled: true,
                fillColor: AppTheme.athensGray,
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
                    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppTheme.diSerria; // diSerria when checked
                      }
                      return AppTheme.silverSand;
                    }),
                  ),
                ),
                Text(
                  'Remember me',
                  style: TextStyle(
                    color: AppTheme.mako, // Dark text color
                    fontFamily: 'Cairo',
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _showForgotPasswordDialog,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.matisse, // matisse color
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            
            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.diSerria, // diSerria button color
                  foregroundColor: AppTheme.athensGray,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                  minimumSize: const Size(double.infinity, 50),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: _login,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: AppTheme.athensGray,
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalOptions(ThemeData theme) {
    return Column(
      children: [
        // Don't have an account
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.mako.withOpacity(0.7), // Dark text color
              ),
            ),
            GestureDetector(
              onTap: _showRegistrationDialog,
              child: Text(
                'Register',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.matisse, // matisse color
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(title: 'Vision ERP Dashboard'),
            ),
          );
        }
      });
    }
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Forgot Password',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.mako,
          ),
        ),
        content: Text(
          'This will be a link to reset your password.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.jumbo,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.matisse,
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
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.mako,
          ),
        ),
        content: Text(
          'Please fill in the required fields to register a new account.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.jumbo,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.matisse,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}