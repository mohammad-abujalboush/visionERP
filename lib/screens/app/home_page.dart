import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/login_page.dart';
import 'package:vision_website/screens/app/organization.dart';
import 'package:vision_website/screens/app/providers/sidebar_provider.dart';
import 'package:vision_website/screens/app/providers/theme_provider.dart';
import 'package:vision_website/screens/app/profile_page.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  String _currentPage = 'dashboard';
  
  late AnimationController _sidebarAnimationController;
  late Animation<double> _sidebarWidthAnimation;
  late Animation<double> _sidebarOpacityAnimation;
  
  bool _isSidebarVisible = true;
  bool _isOrganizationExpanded = false;

  @override
  void initState() {
    super.initState();
    
    _sidebarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    final screenWidth = MediaQuery.of(context).size.width;
    final targetWidth = _isSmallScreen(context) ? 220.0 : 280.0;
    
    _sidebarWidthAnimation = Tween<double>(
      begin: 0.0,
      end: targetWidth,
    ).animate(CurvedAnimation(
      parent: _sidebarAnimationController,
      curve: Curves.easeInOut,
    ));
    
    _sidebarOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _sidebarAnimationController,
      curve: Curves.easeInOut,
    ));
    
    _sidebarAnimationController.forward();
  }

  @override
  void dispose() {
    _sidebarAnimationController.dispose();
    super.dispose();
  }

  bool _isSmallScreen(BuildContext context) => MediaQuery.of(context).size.width < 768;
  bool _isVerySmallScreen(BuildContext context) => MediaQuery.of(context).size.width < 480;

  void _toggleSidebar() {
    if (_isSidebarVisible) {
      _sidebarAnimationController.reverse().then((_) {
        if (mounted) {
          setState(() {
            _isSidebarVisible = false;
          });
        }
      });
    } else {
      setState(() {
        _isSidebarVisible = true;
      });
      _sidebarAnimationController.forward();
    }
  }

  void _toggleOrganizationExpansion() {
    setState(() {
      _isOrganizationExpanded = !_isOrganizationExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Row(
        children: [
          if (!_isVerySmallScreen(context)) 
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: _isSmallScreen(context) ? 220.0 : 280.0,
              ),
              child: _buildAnimatedSidebar(context),
            ),
          Expanded(
            child: _buildMainContent(context),
          ),
        ],
      ),
      floatingActionButton: _isSmallScreen(context) && !_isVerySmallScreen(context) 
          ? FloatingActionButton(
              mini: true,
              backgroundColor: AppTheme.matisse,
              onPressed: _toggleSidebar,
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _sidebarAnimationController,
                color: AppTheme.athensGray,
              ),
            )
          : null,
    );
  }

  Widget _buildAnimatedSidebar(BuildContext context) {
    return AnimatedBuilder(
      animation: _sidebarAnimationController,
      builder: (context, child) {
        return Container(
          width: _sidebarWidthAnimation.value,
          decoration: BoxDecoration(
            color: AppTheme.matisse,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(2, 0),
              ),
            ],
          ),
          child: Opacity(
            opacity: _sidebarOpacityAnimation.value,
            child: _isSidebarVisible ? _buildSidebarContent(context) : const SizedBox(),
          ),
        );
      },
    );
  }

  Widget _buildSidebarContent(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          height: _isSmallScreen(context) ? 70 : 80,
          padding: EdgeInsets.all(_isSmallScreen(context) ? 12 : 16),
          decoration: BoxDecoration(
            color: AppTheme.matisse.withOpacity(0.9),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: _isSmallScreen(context) ? 32 : 40,
                height: _isSmallScreen(context) ? 32 : 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.athensGray,
                ),
                child: Icon(
                  Icons.business,
                  color: AppTheme.matisse,
                  size: _isSmallScreen(context) ? 18 : 24,
                ),
              ),
              SizedBox(width: _isSmallScreen(context) ? 8 : 12),
              Expanded(
                child: Text(
                  'Vision ERP',
                  style: TextStyle(
                    color: AppTheme.athensGray,
                    fontFamily: 'Cairo',
                    fontSize: _isSmallScreen(context) ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (_isSmallScreen(context))
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: AppTheme.athensGray,
                    size: _isSmallScreen(context) ? 20 : 24,
                  ),
                  onPressed: _toggleSidebar,
                ),
            ],
          ),
        ),
        
        // Main sidebar content
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top section
                Column(
                  children: [
                    _buildSidebarItem(
                      context,
                      SidebarItem(title: 'Dashboard', icon: Icons.dashboard),
                      0,
                      isSelected: _currentPage == 'dashboard',
                      onTap: () {
                        setState(() {
                          _currentPage = 'dashboard';
                          _selectedIndex = 0;
                        });
                        if (_isSmallScreen(context)) {
                          _toggleSidebar();
                        }
                      },
                    ),
                    
                    _buildSidebarItem(
                      context,
                      SidebarItem(title: 'Notifications', icon: Icons.notifications),
                      0,
                      isSelected: _currentPage == 'notifications',
                      onTap: () {
                        setState(() {
                          _currentPage = 'notifications';
                          _selectedIndex = 1;
                        });
                        if (_isSmallScreen(context)) {
                          _toggleSidebar();
                        }
                      },
                    ),
                    
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 1,
                      color: AppTheme.athensGray.withOpacity(0.3),
                    ),
                    
                    // المؤسسة section as dropdown
                    _buildOrganizationDropdown(context),
                    
                    ..._buildSidebarItems(SidebarProvider.getSidebarItems().sublist(3)),
                  ],
                ),
                
                // Bottom section
                Container(
                  padding: EdgeInsets.all(_isSmallScreen(context) ? 8 : 12),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppTheme.athensGray.withOpacity(0.3)),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildSidebarItem(
                        context,
                        SidebarItem(title: 'Profile', icon: Icons.person),
                        0,
                        isSelected: _currentPage == 'profile',
                        onTap: () {
                          _navigateToProfile();
                          if (_isSmallScreen(context)) {
                            _toggleSidebar();
                          }
                        },
                      ),
                      
                      _buildSidebarItem(
                        context,
                        SidebarItem(title: 'Logout', icon: Icons.logout),
                        0,
                        isSelected: false,
                        onTap: () {
                          _navigateToLogin();
                          if (_isSmallScreen(context)) {
                            _toggleSidebar();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrganizationDropdown(BuildContext context) {
    return Column(
      children: [
        // Parent dropdown item
        Container(
          margin: EdgeInsets.only(left: 0),
          decoration: BoxDecoration(
            color: (_currentPage == 'organization' || _currentPage == 'general_info') 
                ? AppTheme.matisse.withOpacity(0.3) 
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: _toggleOrganizationExpansion,
              child: ListTile(
                leading: Icon(
                  Icons.business,
                  color: (_currentPage == 'organization' || _currentPage == 'general_info') 
                      ? AppTheme.athensGray 
                      : AppTheme.athensGray.withOpacity(0.7),
                  size: _isSmallScreen(context) ? 18 : 20,
                ),
                title: Text(
                  'المؤسسة',
                  style: TextStyle(
                    color: (_currentPage == 'organization' || _currentPage == 'general_info') 
                        ? AppTheme.athensGray 
                        : AppTheme.athensGray.withOpacity(0.8),
                    fontFamily: 'Cairo',
                    fontSize: _isSmallScreen(context) ? 13 : 14,
                    fontWeight: (_currentPage == 'organization' || _currentPage == 'general_info') 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                  ),
                ),
                trailing: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _isOrganizationExpanded
                      ? const Icon(Icons.expand_less, key: ValueKey('up'))
                      : const Icon(Icons.expand_more, key: ValueKey('down')),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: _isSmallScreen(context) ? 8 : 12),
                minLeadingWidth: 0,
                dense: _isSmallScreen(context),
              ),
            ),
          ),
        ),
        
        // Children items with animation
        if (_isOrganizationExpanded)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Column(
              children: [
                _buildSidebarItem(
                  context,
                  SidebarItem(title: 'المعلومات العامة', icon: Icons.work),
                  1,
                  isSelected: _currentPage == 'general_info',
                  onTap: () {
                    setState(() {
                      _currentPage = 'general_info';
                      _selectedIndex = 2;
                    });
                    if (_isSmallScreen(context)) {
                      _toggleSidebar();
                    }
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSidebarItem(BuildContext context, SidebarItem item, int level, {bool isSelected = false, required VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.only(left: level * (_isSmallScreen(context) ? 12.0 : 16.0)),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.matisse.withOpacity(0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          item.icon,
          color: isSelected ? AppTheme.athensGray : AppTheme.athensGray.withOpacity(0.7),
          size: _isSmallScreen(context) ? 18 : 20,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            color: isSelected ? AppTheme.athensGray : AppTheme.athensGray.withOpacity(0.8),
            fontFamily: 'Cairo',
            fontSize: _isSmallScreen(context) ? 13 : 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: _isSmallScreen(context) ? 8 : 12),
        minLeadingWidth: 0,
        dense: _isSmallScreen(context),
      ),
    );
  }

  List<Widget> _buildSidebarItems(List<SidebarItem> items, {int level = 0}) {
    List<Widget> widgets = [];

    for (var item in items) {
      widgets.add(
        _AnimatedSidebarItemWidget(
          item: item,
          level: level,
          isSelected: _selectedIndex == items.indexOf(item) + 3,
          onTap: () {
            setState(() {
              _selectedIndex = items.indexOf(item) + 3;
              _currentPage = 'menu';
            });
            if (_isSmallScreen(context)) {
              _toggleSidebar();
            }
          },
        ),
      );
    }

    return widgets;
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        // App Bar
        Container(
          height: _isVerySmallScreen(context) ? 60 : 80,
          padding: EdgeInsets.symmetric(horizontal: _isVerySmallScreen(context) ? 16 : 24),
          decoration: BoxDecoration(
            color: AppTheme.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!_isVerySmallScreen(context))
                IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _sidebarAnimationController,
                    size: _isSmallScreen(context) ? 20 : 24,
                    color: AppTheme.matisse,
                  ),
                  onPressed: _toggleSidebar,
                ),
              
              Expanded(
                child: Text(
                  _getPageTitle(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontFamily: 'Cairo',
                        fontSize: _isVerySmallScreen(context) ? 18 : 20,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      size: _isVerySmallScreen(context) ? 20 : 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentPage = 'notifications';
                        _selectedIndex = 1;
                      });
                    },
                  ),
                  SizedBox(width: _isVerySmallScreen(context) ? 4 : 8),
                  _buildProfileMenu(context),
                ],
              ),
            ],
          ),
        ),
        
        // Main Content
        Expanded(
          child: Container(
            padding: EdgeInsets.all(_isVerySmallScreen(context) ? 16 : 24),
            color: AppTheme.athensGray,
            child: _getCurrentPageContent(context),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person, color: AppTheme.matisse, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
      onSelected: (String value) {
        if (value == 'profile') {
          _navigateToProfile();
        } else if (value == 'logout') {
          _navigateToLogin();
        }
      },
      child: Container(
        width: _isVerySmallScreen(context) ? 32 : 40,
        height: _isVerySmallScreen(context) ? 32 : 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.matisse,
        ),
        child: Icon(
          Icons.person,
          color: AppTheme.athensGray,
          size: _isVerySmallScreen(context) ? 16 : 20,
        ),
      ),
    );
  }

  String _getPageTitle() {
    switch (_currentPage) {
      case 'profile':
        return 'Profile';
      case 'dashboard':
        return 'Dashboard';
      case 'notifications':
        return 'Notifications';
      case 'general_info':
        return 'المعلومات العامة';
      case 'menu':
        final items = SidebarProvider.getSidebarItems();
        if (_selectedIndex >= 0 && _selectedIndex < items.length) {
          return items[_selectedIndex].title;
        }
        return 'Dashboard';
      default:
        return 'Dashboard';
    }
  }

  Widget _getCurrentPageContent(BuildContext context) {
    switch (_currentPage) {
      case 'profile':
        return const ProfilePage();
      case 'dashboard':
        return _buildDashboardContent(context);
      case 'notifications':
        return _buildNotificationsPage();
      case 'general_info':
        return const OrganizationPage();
      case 'menu':
        return _buildDashboardContent(context);
      default:
        return _buildDashboardContent(context);
    }
  }

  void _navigateToProfile() {
    setState(() {
      _currentPage = 'profile';
    });
  }

  void _navigateToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  Widget _buildNotificationsPage() {
    return const Center(
      child: Text(
        'Notifications Page',
        style: TextStyle(fontSize: 24, fontFamily: 'Cairo'),
      ),
    );
  }

  // Complete Dashboard Content
  Widget _buildDashboardContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(_isVerySmallScreen(context) ? 16 : 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.diSerria, AppTheme.diSerria.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحباً بك في Vision ERP',
                  style: TextStyle(
                    color: AppTheme.athensGray,
                    fontFamily: 'Cairo',
                    fontSize: _isVerySmallScreen(context) ? 20 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'نظام إدارة المؤسسات المتكامل لإدارة جميع عملياتك التجارية',
                  style: TextStyle(
                    color: AppTheme.athensGray.withOpacity(0.9),
                    fontFamily: 'Cairo',
                    fontSize: _isVerySmallScreen(context) ? 14 : 16,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: _isVerySmallScreen(context) ? 16 : 24),

          // Statistics Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = _isVerySmallScreen(context) ? 2 : (_isSmallScreen(context) ? 3 : 4);
              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: _isVerySmallScreen(context) ? 12 : 16,
                mainAxisSpacing: _isVerySmallScreen(context) ? 12 : 16,
                childAspectRatio: _isVerySmallScreen(context) ? 1.2 : 1.1,
                children: [
                  _buildStatCard(context, 'إجمالي المبيعات', '١٢٥,٠٠٠ ر.س', Icons.shopping_cart, AppTheme.diSerria),
                  _buildStatCard(context, 'إجمالي العملاء', '٤٨٥', Icons.people, AppTheme.matisse),
                  _buildStatCard(context, 'الطلبات الجديدة', '٣٤', Icons.inventory, AppTheme.hippieBlue),
                  _buildStatCard(context, 'الموردين', '٨٩', Icons.handshake, Colors.purple),
                ],
              );
            },
          ),

          SizedBox(height: _isVerySmallScreen(context) ? 16 : 24),

          // Charts Section
          _buildChartsSection(context),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(_isVerySmallScreen(context) ? 12 : 16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(_isVerySmallScreen(context) ? 6 : 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: _isVerySmallScreen(context) ? 18 : 24,
            ),
          ),
          SizedBox(height: _isVerySmallScreen(context) ? 12 : 16),
          Text(
            value,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: _isVerySmallScreen(context) ? 16 : 18,
                ),
          ),
          SizedBox(height: _isVerySmallScreen(context) ? 2 : 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Cairo',
                  color: Colors.grey[600],
                  fontSize: _isVerySmallScreen(context) ? 12 : 14,
                ),
          ),
        ],
      ),
    );
  }

  // Charts Section
  Widget _buildChartsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التقارير والإحصائيات',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontFamily: 'Cairo',
                fontSize: _isVerySmallScreen(context) ? 18 : 20,
              ),
        ),
        SizedBox(height: _isVerySmallScreen(context) ? 12 : 16),
        if (_isVerySmallScreen(context)) ..._buildVerticalCharts(context),
        if (!_isVerySmallScreen(context)) ..._buildHorizontalCharts(context),
      ],
    );
  }

  // Vertical Charts for small screens
  List<Widget> _buildVerticalCharts(BuildContext context) {
    return [
      _buildChartContainer(context, 'مبيعات الشهر', AppTheme.diSerria),
      SizedBox(height: 12),
      _buildChartContainer(context, 'توزيع العملاء', AppTheme.matisse),
      SizedBox(height: 12),
      _buildChartContainer(context, 'المشتريات', AppTheme.hippieBlue),
      SizedBox(height: 12),
      _buildChartContainer(context, 'المخزون', Colors.purple),
    ];
  }

  // Horizontal Charts for larger screens
  List<Widget> _buildHorizontalCharts(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(child: _buildChartContainer(context, 'مبيعات الشهر', AppTheme.diSerria)),
          SizedBox(width: _isSmallScreen(context) ? 12 : 16),
          Expanded(child: _buildChartContainer(context, 'توزيع العملاء', AppTheme.matisse)),
        ],
      ),
      SizedBox(height: _isSmallScreen(context) ? 12 : 16),
      Row(
        children: [
          Expanded(child: _buildChartContainer(context, 'المشتريات', AppTheme.hippieBlue)),
          SizedBox(width: _isSmallScreen(context) ? 12 : 16),
          Expanded(child: _buildChartContainer(context, 'المخزون', Colors.purple)),
        ],
      ),
    ];
  }

  // Chart Container Widget
  Widget _buildChartContainer(BuildContext context, String title, Color color) {
    return Container(
      height: _isVerySmallScreen(context) ? 160 : 200,
      padding: EdgeInsets.all(_isVerySmallScreen(context) ? 12 : 16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: _isVerySmallScreen(context) ? 14 : 16,
                ),
          ),
          SizedBox(height: _isVerySmallScreen(context) ? 12 : 16),
          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                height: _isVerySmallScreen(context) ? 80 : 120,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Center(
                  child: Icon(
                    Icons.bar_chart,
                    color: color,
                    size: _isVerySmallScreen(context) ? 30 : 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Enhanced Sidebar Item Widget with FAST STAGGERED Individual Dropdown Animation
class _AnimatedSidebarItemWidget extends StatefulWidget {
  final SidebarItem item;
  final int level;
  final bool isSelected;
  final VoidCallback onTap;

  const _AnimatedSidebarItemWidget({
    required this.item,
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_AnimatedSidebarItemWidget> createState() => __AnimatedSidebarItemWidgetState();
}

class __AnimatedSidebarItemWidgetState extends State<_AnimatedSidebarItemWidget> 
    with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityAnimation;
  
  bool _isExpanded = false;
  late List<double> _childOpacities;

  @override
  void initState() {
    super.initState();
    
    // Initialize child opacities FIRST
    _childOpacities = widget.item.children?.map((_) => 0.0).toList() ?? [];
    
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _heightAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    ));
    
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _expandController.forward();
        _animateChildrenIn();
      } else {
        _animateChildrenOut();
        _expandController.reverse();
      }
    });
  }

  void _animateChildrenIn() {
    if (widget.item.children == null) return;

    for (int i = 0; i < widget.item.children!.length; i++) {
      Future.delayed(Duration(milliseconds: i * 300), () {
        if (mounted && _isExpanded && i < _childOpacities.length) {
          setState(() {
            _childOpacities[i] = 1.0;
          });
        }
      });
    }
  }

  void _animateChildrenOut() {
    if (widget.item.children == null) return;

    for (int i = widget.item.children!.length - 1; i >= 0; i--) {
      final delay = (widget.item.children!.length - 1 - i) * 150;
      
      Future.delayed(Duration(milliseconds: delay), () {
        if (mounted && i < _childOpacities.length) {
          setState(() {
            _childOpacities[i] = 0.0;
          });
        }
      });
    }
  }

  Widget _buildChildItem(int index, SidebarItem childItem) {
    if (index >= _childOpacities.length) {
      return const SizedBox.shrink();
    }
    
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: _childOpacities[index],
      child: _AnimatedSidebarItemWidget(
        item: childItem,
        level: widget.level + 1,
        isSelected: false,
        onTap: widget.onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 768;

    return Column(
      children: [
        // Parent item
        Container(
          margin: EdgeInsets.only(left: widget.level * (isSmallScreen ? 12.0 : 16.0)),
          decoration: BoxDecoration(
            color: widget.isSelected ? AppTheme.matisse.withOpacity(0.3) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                if (widget.item.children != null) {
                  _toggleExpanded();
                } else {
                  widget.onTap();
                }
              },
              child: ListTile(
                leading: Icon(
                  widget.item.icon,
                  color: widget.isSelected ? AppTheme.athensGray : AppTheme.athensGray.withOpacity(0.7),
                  size: isSmallScreen ? 18 : 20,
                ),
                title: Text(
                  widget.item.title,
                  style: TextStyle(
                    color: widget.isSelected ? AppTheme.athensGray : AppTheme.athensGray.withOpacity(0.8),
                    fontFamily: 'Cairo',
                    fontSize: isSmallScreen ? 13 : 14,
                    fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: widget.item.children != null
                    ? AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: _isExpanded
                            ? const Icon(Icons.expand_less, key: ValueKey('up'))
                            : const Icon(Icons.expand_more, key: ValueKey('down')),
                      )
                    : null,
                contentPadding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 12),
                minLeadingWidth: 0,
                dense: isSmallScreen,
              ),
            ),
          ),
        ),
        
        // Children items with fast staggered animation
        if (widget.item.children != null && _childOpacities.isNotEmpty)
          AnimatedBuilder(
            animation: _expandController,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.topLeft,
                  heightFactor: _heightAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: child,
                  ),
                ),
              );
            },
            child: Column(
              children: widget.item.children!.asMap().entries.map((entry) {
                final index = entry.key;
                final childItem = entry.value;
                return _buildChildItem(index, childItem);
              }).toList(),
            ),
          ),
      ],
    );
  }
}