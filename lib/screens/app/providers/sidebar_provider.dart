import 'package:flutter/material.dart';

class SidebarItem {
  final String title;
  final IconData icon;
  final List<SidebarItem>? children;

  SidebarItem({
    required this.title,
    required this.icon,
    this.children,
  });
}

class SidebarProvider {
  static List<SidebarItem> getSidebarItems() {
    return [
      // Dashboard - New first item
      SidebarItem(
        title: 'Dashboard',
        icon: Icons.dashboard,
      ),
      
      SidebarItem(
        title: 'Notifications',
        icon: Icons.notifications,
      ),
      
      SidebarItem(
        title: 'المؤسسة',
        icon: Icons.business,
        children: [
          SidebarItem(title: 'المعلومات العامة', icon: Icons.work),
        ],
      ),

      SidebarItem(
        title: 'الإعدادات العامة',
        icon: Icons.settings,
        children: [
          SidebarItem(title: 'إعدادات المنشأة', icon: Icons.business),
          SidebarItem(title: 'الهيكل التنظيمي', icon: Icons.account_tree),
          SidebarItem(title: 'الموظفين', icon: Icons.people),
          SidebarItem(title: 'رموز إعدادات الأنظمة', icon: Icons.code),
          SidebarItem(title: 'موظفي المشتريات', icon: Icons.shopping_bag),
          SidebarItem(title: 'موظفي عرض الأسعار', icon: Icons.price_check),
          SidebarItem(title: 'موظفي المشاريع', icon: Icons.work),
          SidebarItem(title: 'منطق العمل', icon: Icons.psychology),
        ],
      ),
      SidebarItem(
        title: 'المالية',
        icon: Icons.account_balance,
        children: [
          SidebarItem(title: 'الإعدادات', icon: Icons.settings),
          SidebarItem(title: 'الإجراءات', icon: Icons.play_arrow),
          SidebarItem(title: 'التقارير', icon: Icons.assessment),
        ],
      ),
      SidebarItem(
        title: 'الموارد البشرية',
        icon: Icons.people_alt,
        children: [
          SidebarItem(title: 'الإعدادات', icon: Icons.settings),
          SidebarItem(title: 'الإجراءات', icon: Icons.play_arrow),
          SidebarItem(title: 'التقارير', icon: Icons.assessment),
          SidebarItem(title: 'الرواتب', icon: Icons.payments),
        ],
      ),
      SidebarItem(
        title: 'المواد والمستودعات',
        icon: Icons.inventory,
        children: [
          SidebarItem(title: 'الإعدادات', icon: Icons.settings),
          SidebarItem(title: 'الإجراءات', icon: Icons.play_arrow),
          SidebarItem(title: 'التقارير', icon: Icons.assessment),
        ],
      ),
      SidebarItem(
        title: 'المشتريات',
        icon: Icons.shopping_cart,
        children: [
          SidebarItem(title: 'طلب شراء', icon: Icons.shopping_basket),
          SidebarItem(title: 'أمر شراء', icon: Icons.receipt),
          SidebarItem(title: 'مشتريات', icon: Icons.add_shopping_cart),
          SidebarItem(title: 'مردودات المشتريات', icon: Icons.assignment_return),
          SidebarItem(title: 'المصاريف الإضافية', icon: Icons.attach_money),
          SidebarItem(title: 'تقارير المشتريات', icon: Icons.analytics),
        ],
      ),
      SidebarItem(
        title: 'المبيعات',
        icon: Icons.sell,
        children: [
          SidebarItem(title: 'الإعدادات', icon: Icons.settings),
          SidebarItem(title: 'الإجراءات', icon: Icons.play_arrow),
          SidebarItem(title: 'نقاط البيع', icon: Icons.point_of_sale),
          SidebarItem(title: 'التقارير', icon: Icons.assessment),
        ],
      ),
      SidebarItem(
        title: 'الأصول الثابتة',
        icon: Icons.business_center,
        children: [
          SidebarItem(title: 'فئة الأصول الثابتة', icon: Icons.category),
          SidebarItem(title: 'الأصل الثابت', icon: Icons.architecture),
          SidebarItem(title: 'بطاقة الأصل الثابت', icon: Icons.badge),
          SidebarItem(title: 'توزيع الأصول الثابتة', icon: Icons.share),
        ],
      ),
      SidebarItem(
        title: 'علاقة العملاء',
        icon: Icons.contact_support,
        children: [
          SidebarItem(title: 'الإعدادات', icon: Icons.settings),
          SidebarItem(title: 'الإجراءات', icon: Icons.play_arrow),
          SidebarItem(title: 'التقارير', icon: Icons.assessment),
        ],
      ),
      SidebarItem(
        title: 'التحليل والتقارير',
        icon: Icons.analytics,
        children: [
          SidebarItem(title: 'لائحة بيانات إجماليات', icon: Icons.list),
          SidebarItem(title: 'التقارير المالية والمبيعات', icon: Icons.bar_chart),
          SidebarItem(title: 'طلبات المبيعات', icon: Icons.request_quote),
          SidebarItem(title: 'بيانات الحجوزات', icon: Icons.book_online),
          SidebarItem(title: 'المبيعات حسب المندوب ومدير المبيعات', icon: Icons.leaderboard),
          SidebarItem(title: 'الموارد البشرية', icon: Icons.people),
          SidebarItem(title: 'المشتريات', icon: Icons.shopping_cart),
          SidebarItem(title: 'عروض الأسعار', icon: Icons.local_offer),
        ],
      ),
      SidebarItem(
        title: 'قيمة الضريبة المضافة',
        icon: Icons.receipt_long,
        children: [
          SidebarItem(title: 'الإقرار الضريبي', icon: Icons.description),
          SidebarItem(title: 'الضريبة المرحلة الثانية', icon: Icons.money),
          SidebarItem(title: 'تقارير المشتريات الضريبية', icon: Icons.assessment),
          SidebarItem(title: 'تقارير المبيعات الضريبية', icon: Icons.analytics),
        ],
      ),
      SidebarItem(
        title: 'التصنيع',
        icon: Icons.factory,
        children: [
          SidebarItem(title: 'الإعدادات', icon: Icons.settings),
          SidebarItem(title: 'التخطيط', icon: Icons.schedule),
          SidebarItem(title: 'الإجراءات', icon: Icons.play_arrow),
          SidebarItem(title: 'تقارير', icon: Icons.assessment),
        ],
      ),
      SidebarItem(
        title: 'المشاريع',
        icon: Icons.work,
        children: [
          SidebarItem(title: 'المشاريع', icon: Icons.assignment),
          SidebarItem(title: 'طلبات إضافية للمشروع', icon: Icons.add_task),
          SidebarItem(title: 'مستندات المخزون', icon: Icons.inventory_2),
        ],
      ),
      SidebarItem(
        title: 'الموقع الإلكتروني',
        icon: Icons.language,
        children: [
          SidebarItem(title: 'عارض الصور', icon: Icons.photo_library),
          SidebarItem(title: 'قسيمة - الخصم', icon: Icons.discount),
        ],
      ),
      SidebarItem(
        title: 'المستخدمين',
        icon: Icons.supervised_user_circle,
        children: [
          SidebarItem(title: 'المستخدمين', icon: Icons.people_outline),
        ],
      ),
      
      // Profile and Logout will be added in the UI separately
    ];  
  }
}