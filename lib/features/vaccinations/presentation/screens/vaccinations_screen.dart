import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class VaccinationsScreen extends StatelessWidget {
  const VaccinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Vaccinations"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [

          VaccineCard(
            vaccine: "COVID-19 Booster",
            hospital: "Apollo Hospital",
            date: "12 Jan 2026",
            completed: true,
          ),

          SizedBox(height: 15),

          VaccineCard(
            vaccine: "Hepatitis B",
            hospital: "City Hospital",
            date: "25 Mar 2026",
            completed: true,
          ),

          SizedBox(height: 15),

          VaccineCard(
            vaccine: "Influenza",
            hospital: "Pending",
            date: "15 Aug 2026",
            completed: false,
          ),
        ],
      ),
    );
  }
}

class VaccineCard extends StatelessWidget {
  final String vaccine;
  final String hospital;
  final String date;
  final bool completed;

  const VaccineCard({
    super.key,
    required this.vaccine,
    required this.hospital,
    required this.date,
    required this.completed,
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

        leading: CircleAvatar(
          backgroundColor: completed
              ? Colors.green.shade100
              : Colors.orange.shade100,
          child: Icon(
            completed
                ? Icons.check
                : Icons.schedule,
            color: completed
                ? Colors.green
                : Colors.orange,
          ),
        ),

        title: Text(
          vaccine,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            "$hospital\n$date",
          ),
        ),

        trailing: Chip(
          backgroundColor: completed
              ? Colors.green.shade100
              : Colors.orange.shade100,
          label: Text(
            completed ? "Done" : "Upcoming",
          ),
        ),
      ),
    );
  }
}