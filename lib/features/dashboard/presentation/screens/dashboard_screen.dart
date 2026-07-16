import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../routes/app_routes.dart';
import '../widgets/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("MediSync"),
        centerTitle: true,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primaryLight,
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primary,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 16),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning 👋",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "Welcome back!",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Health Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Digital Health Passport",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Profile Completion",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 10),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const LinearProgressIndicator(
                      value: 0.75,
                      minHeight: 8,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "75% Complete",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Healthy",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                children: [
                  DashboardCard(
                    title: "Profile",
                    icon: Icons.person,
                    color: AppColors.profile,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.profile),
                  ),

                  DashboardCard(
                    title: "Documents",
                    icon: Icons.folder,
                    color: AppColors.documents,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.documents),
                  ),

                  DashboardCard(
                    title: "QR Passport",
                    icon: Icons.qr_code,
                    color: AppColors.qrPassport,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.qrPassport),
                  ),

                  DashboardCard(
                    title: "Appointments",
                    icon: Icons.calendar_today,
                    color: AppColors.appointments,
                    onTap: () => Navigator.pushNamed(
                        context, AppRoutes.appointments),
                  ),

                  DashboardCard(
                    title: "Vaccinations",
                    icon: Icons.vaccines,
                    color: AppColors.vaccinations,
                    onTap: () => Navigator.pushNamed(
                        context, AppRoutes.vaccinations),
                  ),

                  DashboardCard(
                    title: "Medications",
                    icon: Icons.medication,
                    color: AppColors.medications,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.medications),
                  ),

                  DashboardCard(
                    title: "Emergency",
                    icon: Icons.emergency,
                    color: AppColors.emergency,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.emergency),
                  ),

                  DashboardCard(
                    title: "Settings",
                    icon: Icons.settings,
                    color: AppColors.settings,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.settings),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;

            case 1:
              Navigator.pushNamed(context, AppRoutes.profile);
              break;

            case 2:
              Navigator.pushNamed(context, AppRoutes.qrPassport);
              break;

            case 3:
              Navigator.pushNamed(context, AppRoutes.settings);
              break;
          }
        },
      ),
    );
  }
}