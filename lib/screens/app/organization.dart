import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/providers/theme_provider.dart';

class OrganizationPage extends StatelessWidget {
  const OrganizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isVerySmallScreen = MediaQuery.of(context).size.width < 480;
    final isSmallScreen = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 24,
          vertical: isSmallScreen ? 12 : 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildOrganizationHeader(context, isVerySmallScreen),
            const SizedBox(height: 60),
            _buildOrganizationInfoCard(context),
            const SizedBox(height: 16),
            _buildOwnerInfoCard(context),
            const SizedBox(height: 16),
            _buildOrganizationFilesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganizationHeader(BuildContext context, bool isVerySmallScreen) {
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
            'Organization Profile',
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
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrganizationInfoCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: AppTheme.matisse.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            _buildInfoRow(Icons.business, 'Company Name', 'Tech Solutions Co.'),
            const Divider(height: 16),
            _buildInfoRow(Icons.numbers, 'Tax Number', '310456789100003'),
            const Divider(height: 16),
            _buildInfoRow(Icons.badge, 'CR Number', '1010256789'),
            const Divider(height: 16),
            _buildInfoRow(Icons.location_on_outlined, 'Address', 'Riyadh, Saudi Arabia'),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerInfoCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: AppTheme.matisse.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Owner Information',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.matisse,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.person_outline, 'Owner Name', 'Ahmed Al-Saud'),
            const Divider(height: 16),
            _buildInfoRow(Icons.phone_outlined, 'Phone Number', '+966 50 123 4567'),
            const Divider(height: 16),
            _buildInfoRow(Icons.email_outlined, 'Email', 'ahmed@techsolutions.com'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganizationFilesSection(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: AppTheme.matisse.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.folder_open, color: AppTheme.matisse, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Organization Files',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.matisse,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Certificates & Official Documents',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            
            // Files Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                _buildFileItem('Tax Certificate', Icons.picture_as_pdf, Colors.orange),
                _buildFileItem('CR Document', Icons.picture_as_pdf, Colors.blue),
                _buildFileItem('Certificates', Icons.workspace_premium, Colors.purple),
                _buildFileItem('Other Documents', Icons.description, Colors.brown),
              ],
            ),
            
            const SizedBox(height: 20),
            _buildUploadButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFileItem(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Add upload functionality here
      },
      icon: const Icon(Icons.upload_file),
      label: const Text(
        'Upload New File',
        style: TextStyle(fontFamily: 'Cairo'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.diSerria,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  /// -------------------- Common Info Row Widget --------------------
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.matisse, size: 22),
        const SizedBox(width: 12),
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
              const SizedBox(height: 2),
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
}