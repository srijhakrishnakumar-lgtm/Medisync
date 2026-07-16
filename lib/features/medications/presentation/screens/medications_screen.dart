import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Medications"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Medication reminder coming soon!"),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [

          MedicationCard(
            medicine: "Paracetamol 500mg",
            dosage: "1 Tablet",
            schedule: "Morning & Night",
            remaining: "12 tablets left",
          ),

          SizedBox(height: 16),

          MedicationCard(
            medicine: "Vitamin D3",
            dosage: "1 Capsule",
            schedule: "After Breakfast",
            remaining: "30 capsules left",
          ),

          SizedBox(height: 16),

          MedicationCard(
            medicine: "Insulin",
            dosage: "10 Units",
            schedule: "Before Dinner",
            remaining: "5 doses left",
          ),
        ],
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final String medicine;
  final String dosage;
  final String schedule;
  final String remaining;

  const MedicationCard({
    super.key,
    required this.medicine,
    required this.dosage,
    required this.schedule,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(18),

        leading: const CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: Icon(
            Icons.medication,
            color: AppColors.primary,
          ),
        ),

        title: Text(
          medicine,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            "$dosage\n$schedule\n$remaining",
          ),
        ),

        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}