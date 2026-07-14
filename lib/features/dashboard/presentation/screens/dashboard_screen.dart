import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../routes/app_routes.dart';
import '../widgets/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_DashboardItem> quickActions = [
      _DashboardItem(
        title: 'Health Profile',
        icon: Icons.person,
        color: AppColors.profile,
        route: AppRoutes.profile,
      ),
      _DashboardItem(
        title: 'QR Passport',
        icon: Icons.qr_code,
        color: AppColors.qrPassport,
        route: AppRoutes.qrPassport,
      ),
      _DashboardItem(
        title: 'Documents',
        icon: Icons.folder_open,
        color: AppColors.documents,
        route: AppRoutes.documents,
      ),
      _DashboardItem(
        title: 'Appointments',
        icon: Icons.calendar_month,
        color: AppColors.appointments,
        route: AppRoutes.appointments,
      ),
      _DashboardItem(
        title: 'Vaccinations',
        icon: Icons.vaccines,
        color: AppColors.vaccinations,
        route: AppRoutes.vaccinations,
      ),
      _DashboardItem(
        title: 'Medications',
        icon: Icons.medication,
        color: AppColors.medications,
        route: AppRoutes.medications,
      ),
      _DashboardItem(
        title: 'Emergency',
        icon: Icons.emergency,
        color: AppColors.emergency,
        route: AppRoutes.emergency,
      ),
      _DashboardItem(
        title: 'Settings',
        icon: Icons.settings,
        color: AppColors.settings,
        route: AppRoutes.settings,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MediSync'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back 👋',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your Digital Health Passport is ready.',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 20),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: quickActions.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final item = quickActions[index];

                return DashboardCard(
                  title: item.title,
                  icon: item.icon,
                  color: item.color,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      item.route,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const _DashboardItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}