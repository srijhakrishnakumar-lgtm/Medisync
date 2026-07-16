import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  Widget emergencyTile(
      IconData icon,
      String title,
      String value,
      ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red.shade100,
          child: Icon(
            icon,
            color: Colors.red,
          ),
        ),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Emergency Information"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [

                  Icon(
                    Icons.emergency,
                    size: 70,
                    color: Colors.white,
                  ),

                  SizedBox(height: 12),

                  Text(
                    "Emergency Health Card",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Show this information to healthcare professionals during emergencies.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            emergencyTile(
              Icons.bloodtype,
              "Blood Group",
              "O+",
            ),

            emergencyTile(
              Icons.warning,
              "Allergies",
              "Penicillin",
            ),

            emergencyTile(
              Icons.favorite,
              "Medical Condition",
              "Diabetes",
            ),

            emergencyTile(
              Icons.phone,
              "Emergency Contact",
              "+91 9876543210",
            ),

            emergencyTile(
              Icons.person,
              "Contact Person",
              "Jane Doe (Mother)",
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Emergency SOS feature coming soon!",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.sos),
                label: const Text("Emergency SOS"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}