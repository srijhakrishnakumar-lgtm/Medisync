import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Appointments"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Appointment booking coming soon!"),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          AppointmentCard(
            doctor: "Dr. Sarah Johnson",
            speciality: "Cardiologist",
            hospital: "City Hospital",
            date: "20 July 2026",
            time: "10:30 AM",
          ),
          SizedBox(height: 16),
          AppointmentCard(
            doctor: "Dr. Michael Brown",
            speciality: "Dentist",
            hospital: "Smile Care Clinic",
            date: "28 July 2026",
            time: "03:00 PM",
          ),
        ],
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String doctor;
  final String speciality;
  final String hospital;
  final String date;
  final String time;

  const AppointmentCard({
    super.key,
    required this.doctor,
    required this.speciality,
    required this.hospital,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctor,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 8),

            Text(speciality),

            const SizedBox(height: 6),

            Text(hospital),

            const Divider(height: 25),

            Row(
              children: [
                const Icon(Icons.calendar_today,
                    color: AppColors.primary),

                const SizedBox(width: 8),

                Text(date),

                const Spacer(),

                const Icon(Icons.access_time,
                    color: AppColors.primary),

                const SizedBox(width: 8),

                Text(time),
              ],
            ),
          ],
        ),
      ),
    );
  }
}