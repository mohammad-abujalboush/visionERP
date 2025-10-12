import 'package:flutter/material.dart';
import 'package:vision_website/screens/app/login_page.dart';
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
  
  // Animation controllers
  late AnimationController _sidebarAnimationController;
  late Animation<double> _sidebarWidthAnimation;
  late Animation<double> _sidebarOpacityAnimation;
  
  bool _isSidebarVisible = true;
  
  // Remove the getters and use methods instead
  bool isSmallScreen(BuildContext context) => MediaQuery.of(context).size.width < 768;
  bool isVerySmallScreen(BuildContext context) => MediaQuery.of(context).size.width < 480;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _sidebarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // We'll set up the animations in didChangeDependencies instead
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Setup animations here after dependencies are available
    final screenWidth = MediaQuery.of(context).size.width;
    final targetWidth = screenWidth < 768 ? 220.0 : 280.0;
    
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
    
    // Start with sidebar visible
    _sidebarAnimationController.forward();
  }

  @override
  void dispose() {
    _sidebarAnimationController.dispose();
    super.dispose();
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
      if (_isSidebarVisible) {
        _sidebarAnimationController.forward();
      } else {
        _sidebarAnimationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Row(
        children: [
          // Animated Sidebar - only show if not very small screen
          if (!isVerySmallScreen(context)) _buildAnimatedSidebar(context),
          Expanded(child: _buildMainContent(context)),
        ],
      ),
      // Floating action button to toggle sidebar on small screens
      floatingActionButton: isSmallScreen(context) && !isVerySmallScreen(context) 
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
            child: child,
          ),
        );
      },
      child: _buildSidebarContent(context),
    );
  }

  Widget _buildSidebarContent(BuildContext context) {
    final sidebarWidth = isSmallScreen(context) ? 220.0 : 280.0;

    return Container(
      width: sidebarWidth,
      child: Column(
        children: [
          // Header with close button
          Container(
            height: isSmallScreen(context) ? 70 : 80,
            padding: EdgeInsets.all(isSmallScreen(context) ? 12 : 16),
            decoration: BoxDecoration(
              color: AppTheme.matisse.withOpacity(0.9),
              border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: isSmallScreen(context) ? 32 : 40,
                  height: isSmallScreen(context) ? 32 : 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.athensGray,
                  ),
                  child: Icon(
                    Icons.business,
                    color: AppTheme.matisse,
                    size: isSmallScreen(context) ? 18 : 24,
                  ),
                ),
                SizedBox(width: isSmallScreen(context) ? 8 : 12),
                Expanded(
                  child: Text(
                    'Vision ERP',
                    style: TextStyle(
                      color: AppTheme.athensGray,
                      fontFamily: 'Cairo',
                      fontSize: isSmallScreen(context) ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Close button for sidebar
                if (isSmallScreen(context))
                  IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: AppTheme.athensGray,
                      size: isSmallScreen(context) ? 20 : 24,
                    ),
                    onPressed: _toggleSidebar,
                  ),
              ],
            ),
          ),
          
          // Main sidebar content with scroll
          Expanded(
            child: Column(
              children: [
                // Top section - Dashboard and Notifications
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(isSmallScreen(context) ? 6 : 8),
                    children: [
                      // Dashboard
                      _buildSidebarItemWidget(
                        context,
                        SidebarItem(title: 'Dashboard', icon: Icons.dashboard),
                        0,
                        isSelected: _currentPage == 'dashboard',
                        onTap: () {
                          setState(() {
                            _currentPage = 'dashboard';
                            _selectedIndex = 0;
                          });
                          // Auto-close sidebar on small screens when item is selected
                          if (isSmallScreen(context)) {
                            _toggleSidebar();
                          }
                        },
                      ),
                      
                      // Notifications
                      _buildSidebarItemWidget(
                        context,
                        SidebarItem(title: 'Notifications', icon: Icons.notifications),
                        0,
                        isSelected: _currentPage == 'notifications',
                        onTap: () {
                          setState(() {
                            _currentPage = 'notifications';
                            _selectedIndex = 1;
                          });
                          if (isSmallScreen(context)) {
                            _toggleSidebar();
                          }
                        },
                      ),
                      
                      // Divider line
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        height: 1,
                        color: AppTheme.athensGray.withOpacity(0.3),
                      ),
                      
                      // Main menu items
                      ..._buildSidebarItems(context, SidebarProvider.getSidebarItems().sublist(2)),
                    ],
                  ),
                ),
                
                // Bottom section - Profile and Logout
                Container(
                  padding: EdgeInsets.all(isSmallScreen(context) ? 8 : 12),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppTheme.athensGray.withOpacity(0.3)),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Profile
                      _buildSidebarItemWidget(
                        context,
                        SidebarItem(title: 'Profile', icon: Icons.person),
                        0,
                        isSelected: _currentPage == 'profile',
                        onTap: () {
                          _navigateToProfile();
                          if (isSmallScreen(context)) {
                            _toggleSidebar();
                          }
                        },
                      ),
                      
                      // Logout
                      _buildSidebarItemWidget(
                        context,
                        SidebarItem(title: 'Logout', icon: Icons.logout),
                        0,
                        isSelected: false,
                        onTap: () {
                          _navigateToLogin();
                          if (isSmallScreen(context)) {
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
        ],
      ),
    );
  }

  Widget _buildSidebarItemWidget(BuildContext context, SidebarItem item, int level, {bool isSelected = false, required VoidCallback onTap}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(left: level * (isSmallScreen(context) ? 12.0 : 16.0)),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.matisse.withOpacity(0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          item.icon,
          color: isSelected ? AppTheme.athensGray : AppTheme.athensGray.withOpacity(0.7),
          size: isSmallScreen(context) ? 18 : 20,
        ),
        title: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 200),
          style: TextStyle(
            color: isSelected ? AppTheme.athensGray : AppTheme.athensGray.withOpacity(0.8),
            fontFamily: 'Cairo',
            fontSize: isSmallScreen(context) ? 13 : 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          child: Text(item.title),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: isSmallScreen(context) ? 8 : 12),
        minLeadingWidth: 0,
        dense: isSmallScreen(context),
      ),
    );
  }

  List<Widget> _buildSidebarItems(BuildContext context, List<SidebarItem> items, {int level = 0}) {
    List<Widget> widgets = [];

    for (var item in items) {
      widgets.add(
        _SidebarItemWidget(
          item: item,
          level: level,
          isSelected: _selectedIndex == items.indexOf(item) + 2,
          onTap: () {
            setState(() {
              _selectedIndex = items.indexOf(item) + 2;
              _currentPage = 'menu';
            });
            // Auto-close sidebar on small screens
            if (isSmallScreen(context)) {
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
        Container(
          height: isVerySmallScreen(context) ? 60 : 80,
          padding: EdgeInsets.symmetric(horizontal: isVerySmallScreen(context) ? 16 : 24),
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
              // Menu button to toggle sidebar
              if (!isVerySmallScreen(context))
                IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _sidebarAnimationController,
                    size: isSmallScreen(context) ? 20 : 24,
                    color: AppTheme.matisse,
                  ),
                  onPressed: _toggleSidebar,
                ),
              
              Expanded(
                child: Text(
                  _getPageTitle(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontFamily: 'Cairo',
                        fontSize: isVerySmallScreen(context) ? 18 : 20,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      size: isVerySmallScreen(context) ? 20 : 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentPage = 'notifications';
                        _selectedIndex = 1;
                      });
                    },
                  ),
                  SizedBox(width: isVerySmallScreen(context) ? 4 : 8),
                  // Profile Icon with dropdown menu
                  _buildProfileMenu(context),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(isVerySmallScreen(context) ? 16 : 24),
            color: AppTheme.athensGray,
            child: _getCurrentPageContent(),
          ),
        ),
      ],
    );
  }

  // Fixed Profile Menu Widget
  Widget _buildProfileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      offset: Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person, color: AppTheme.matisse, size: 20),
              SizedBox(width: 8),
              Text(
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
              SizedBox(width: 8),
              Text(
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
        width: isVerySmallScreen(context) ? 32 : 40,
        height: isVerySmallScreen(context) ? 32 : 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.matisse,
        ),
        child: Icon(
          Icons.person,
          color: AppTheme.athensGray,
          size: isVerySmallScreen(context) ? 16 : 20,
        ),
      ),
    );
  }

  // ... Rest of the methods remain the same (getPageTitle, getCurrentPageContent, etc.)
  // Just make sure to pass context to any method that uses isSmallScreen or isVerySmallScreen

  String _getPageTitle() {
    switch (_currentPage) {
      case 'profile':
        return 'Profile';
      case 'dashboard':
        return 'Dashboard';
      case 'notifications':
        return 'Notifications';
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

  Widget _getCurrentPageContent() {
    switch (_currentPage) {
      case 'profile':
        return ProfilePage();
      case 'dashboard':
        return _buildDashboardContent(context);
      case 'notifications':
        return _buildNotificationsPage();
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
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  Widget _buildNotificationsPage() {
    return Center(
      child: Text(
        'Notifications Page',
        style: TextStyle(fontSize: 24, fontFamily: 'Cairo'),
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isVerySmallScreen(context) ? 16 : 24),
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
                    fontSize: isVerySmallScreen(context) ? 20 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'نظام إدارة المؤسسات المتكامل لإدارة جميع عملياتك التجارية',
                  style: TextStyle(
                    color: AppTheme.athensGray.withOpacity(0.9),
                    fontFamily: 'Cairo',
                    fontSize: isVerySmallScreen(context) ? 14 : 16,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: isVerySmallScreen(context) ? 16 : 24),

          // Statistics Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isVerySmallScreen(context) ? 2 : (isSmallScreen(context) ? 3 : 4);
              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: isVerySmallScreen(context) ? 12 : 16,
                mainAxisSpacing: isVerySmallScreen(context) ? 12 : 16,
                childAspectRatio: isVerySmallScreen(context) ? 1.2 : 1.1,
                children: [
                  _buildStatCard(context, 'إجمالي المبيعات', '١٢٥,٠٠٠ ر.س', Icons.shopping_cart, AppTheme.diSerria),
                  _buildStatCard(context, 'إجمالي العملاء', '٤٨٥', Icons.people, AppTheme.matisse),
                  _buildStatCard(context, 'الطلبات الجديدة', '٣٤', Icons.inventory, AppTheme.hippieBlue),
                  _buildStatCard(context, 'الموردين', '٨٩', Icons.handshake, Colors.purple),
                ],
              );
            },
          ),

          SizedBox(height: isVerySmallScreen(context) ? 16 : 24),

          _buildChartsSection(context),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(isVerySmallScreen(context) ? 12 : 16),
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
            padding: EdgeInsets.all(isVerySmallScreen(context) ? 6 : 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: isVerySmallScreen(context) ? 18 : 24,
            ),
          ),
          SizedBox(height: isVerySmallScreen(context) ? 12 : 16),
          Text(
            value,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: isVerySmallScreen(context) ? 16 : 18,
                ),
          ),
          SizedBox(height: isVerySmallScreen(context) ? 2 : 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Cairo',
                  color: Colors.grey[600],
                  fontSize: isVerySmallScreen(context) ? 12 : 14,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التقارير والإحصائيات',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontFamily: 'Cairo',
                fontSize: isVerySmallScreen(context) ? 18 : 20,
              ),
        ),
        SizedBox(height: isVerySmallScreen(context) ? 12 : 16),
        if (isVerySmallScreen(context)) ..._buildVerticalCharts(context),
        if (!isVerySmallScreen(context)) ..._buildHorizontalCharts(context),
      ],
    );
  }

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

  List<Widget> _buildHorizontalCharts(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(child: _buildChartContainer(context, 'مبيعات الشهر', AppTheme.diSerria)),
          SizedBox(width: isSmallScreen(context) ? 12 : 16),
          Expanded(child: _buildChartContainer(context, 'توزيع العملاء', AppTheme.matisse)),
        ],
      ),
      SizedBox(height: isSmallScreen(context) ? 12 : 16),
      Row(
        children: [
          Expanded(child: _buildChartContainer(context, 'المشتريات', AppTheme.hippieBlue)),
          SizedBox(width: isSmallScreen(context) ? 12 : 16),
          Expanded(child: _buildChartContainer(context, 'المخزون', Colors.purple)),
        ],
      ),
    ];
  }

  Widget _buildChartContainer(BuildContext context, String title, Color color) {
    return Container(
      height: isVerySmallScreen(context) ? 160 : 200,
      padding: EdgeInsets.all(isVerySmallScreen(context) ? 12 : 16),
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
                  fontSize: isVerySmallScreen(context) ? 14 : 16,
                ),
          ),
          SizedBox(height: isVerySmallScreen(context) ? 12 : 16),
          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                height: isVerySmallScreen(context) ? 80 : 120,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Center(
                  child: Icon(
                    Icons.bar_chart,
                    color: color,
                    size: isVerySmallScreen(context) ? 30 : 40,
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

// _SidebarItemWidget class remains the same as previous version
class _SidebarItemWidget extends StatefulWidget {
  final SidebarItem item;
  final int level;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItemWidget({
    required this.item,
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_SidebarItemWidget> createState() => __SidebarItemWidgetState();
}

class __SidebarItemWidgetState extends State<_SidebarItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 768;

    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.only(left: widget.level * (isSmallScreen ? 12.0 : 16.0)),
          decoration: BoxDecoration(
            color: widget.isSelected ? AppTheme.matisse.withOpacity(0.3) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Icon(
              widget.item.icon,
              color: widget.isSelected ? AppTheme.athensGray : AppTheme.athensGray.withOpacity(0.7),
              size: isSmallScreen ? 18 : 20,
            ),
            title: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: TextStyle(
                color: widget.isSelected ? AppTheme.athensGray : AppTheme.athensGray.withOpacity(0.8),
                fontFamily: 'Cairo',
                fontSize: isSmallScreen ? 13 : 14,
                fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(widget.item.title),
            ),
            trailing: widget.item.children != null
                ? Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppTheme.athensGray.withOpacity(0.6),
                    size: isSmallScreen ? 16 : 18,
                  )
                : null,
            onTap: () {
              if (widget.item.children != null) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
              widget.onTap();
            },
            contentPadding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 12),
            minLeadingWidth: 0,
            dense: isSmallScreen,
          ),
        ),
        if (widget.item.children != null && _isExpanded)
          ...widget.item.children!.map(
            (child) => _SidebarItemWidget(
              item: child,
              level: widget.level + 1,
              isSelected: false,
              onTap: () {},
            ),
          ),
      ],
    );
  }
}