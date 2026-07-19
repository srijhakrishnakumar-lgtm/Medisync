import 'package:flutter/material.dart';
import '../appointments/appointment_screen.dart';
import '../profile/profile_screen.dart';
import '../records/records_screen.dart';
import '../qr/qr_screen.dart';
import '../medication/medication_screen.dart';
import 'package:medisync/services/notification_service.dart';
import '../vaccination/vaccination_screen.dart';
import '../health_passport_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("MediSync"),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: "Search",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SearchScreen(),
                  ),
                );
              },
            ),
          ],
        ),

        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF00897B),
                    Color(0xFF26A69A),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "👋 Welcome Back",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "MediSync",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your complete digital health passport in one secure place.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Overview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),
            FutureBuilder(
              future: Future.wait([
                firestore
                    .collection("users")
                    .doc(user!.uid)
                    .collection("medications")
                    .get(),
                firestore
                    .collection("users")
                    .doc(user!.uid)
                    .collection("appointments")
                    .get(),
                firestore
                    .collection("users")
                    .doc(user!.uid)
                    .collection("vaccinations")
                    .get(),
              ]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data as List<QuerySnapshot>;

                final medicationCount = data[0].docs.length;
                final appointmentCount = data[1].docs.length;
                final vaccinationCount = data[2].docs.length;

                return Card(
                  elevation: 8,
                  shadowColor: Colors.teal.withValues(alpha: 0.20),
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.analytics_outlined,
                              color: Colors.teal,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Health Overview",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatItem(
                              icon: Icons.medication,
                              color: Colors.teal,
                              title: "Medicines",
                              value: medicationCount.toString(),
                            ),
                            Container(
                              height: 50,
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            _StatItem(
                              icon: Icons.calendar_month,
                              color: Colors.orange,
                              title: "Appointments",
                              value: appointmentCount.toString(),
                            ),
                            Container(
                              height: 50,
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            _StatItem(
                              icon: Icons.health_and_safety,
                              color: Colors.green,
                              title: "Vaccines",
                              value: vaccinationCount.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

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
        )
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
      elevation: 6,
      shadowColor: Colors.teal.withValues(alpha: 0.12),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: Colors.teal,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;

  const _StatItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 30,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}