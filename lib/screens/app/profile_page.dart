import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/providers/theme_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isVerySmallScreen = MediaQuery.of(context).size.width < 480;
    final isSmallScreen = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16 : 32,
          vertical: isSmallScreen ? 16 : 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileHeader(context, isVerySmallScreen),
            const SizedBox(height: 80),
            _buildInfoCard(context),
            const SizedBox(height: 20),
            _buildStatsRow(context),
            const SizedBox(height: 20),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  /// -------------------- Profile Header --------------------
  Widget _buildProfileHeader(BuildContext context, bool isVerySmallScreen) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: isVerySmallScreen ? 150 : 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.matisse, AppTheme.diSerria],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppTheme.matisse.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            'My Profile',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: isVerySmallScreen ? 22 : 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: isVerySmallScreen ? -45 : -55,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.matisse.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: isVerySmallScreen ? 45 : 55,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: isVerySmallScreen ? 42 : 52,
                  backgroundColor: AppTheme.matisse,
                  child: Icon(
                    Icons.person,
                    size: isVerySmallScreen ? 42 : 52,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// -------------------- Info Card --------------------
  Widget _buildInfoCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: AppTheme.matisse.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            _buildInfoRow(Icons.person_outline, 'Name', 'Nourah Abdullah'),
            const Divider(height: 20),
            _buildInfoRow(Icons.email_outlined, 'Email', 'nourah@visionerp.com'),
            const Divider(height: 20),
            _buildInfoRow(Icons.work_outline, 'Role', 'Programmer'),
            const Divider(height: 20),
            _buildInfoRow(Icons.location_on_outlined, 'Location', 'Riyadh, Saudi Arabia'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.matisse, size: 22),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.matisse,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// -------------------- Stats Row --------------------
  Widget _buildStatsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard('Projects', '24', Icons.folder_open),
        _buildStatCard('Tasks', '134', Icons.check_circle_outline),
        _buildStatCard('Teams', '5', Icons.group_outlined),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.matisse.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.diSerria, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.matisse,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// -------------------- Action Buttons --------------------
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit_outlined),
          label: const Text(
            'Edit Profile',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.matisse,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        
      ],
    );
  }
}
