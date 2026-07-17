import 'package:flutter/material.dart';
import '../appointments/appointment_screen.dart';
import '../profile/profile_screen.dart';
import '../records/records_screen.dart';
import '../qr/qr_screen.dart';
import '../medication/medication_screen.dart';
import 'package:medisync/services/notification_service.dart';
import '../vaccination/vaccination_screen.dart';
import '../medication/medication_screen.dart';
import '../health_passport_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.notifications),
        onPressed: () async {
          await NotificationService.instance.showInstantNotification(
            title: "MediSync Test",
            body: "Notifications are working! 🎉",
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "👋 Welcome Back",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Your Health Dashboard",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),

            DashboardCard(
              icon: Icons.person,
              title: "My Profile",
              subtitle: "View and edit your health profile",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              icon: Icons.medication,
              title: "Medicines",
              subtitle: "Medication reminders",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MedicationScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              icon: Icons.folder,
              title: "Medical Records",
              subtitle: "View prescriptions and reports",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RecordsScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              icon: Icons.qr_code,
              title: "Emergency QR",
              subtitle: "Show your emergency health card",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const QRScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              icon: Icons.calendar_month,
              title: "Appointments",
              subtitle: "Manage your appointments",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AppointmentScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              icon: Icons.health_and_safety,
              title: "Vaccinations",
              subtitle: "Track your vaccines",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const VaccinationScreen(),
                  ),
                );
              },
            ),
            DashboardCard(
              icon: Icons.picture_as_pdf,
              title: "Health Passport",
              subtitle: "Generate, print and share your health report",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HealthPassportScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(18),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.teal.shade100,
          child: Icon(
            icon,
            color: Colors.teal,
            size: 30,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}