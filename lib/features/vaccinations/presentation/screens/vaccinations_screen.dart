import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
class VaccinationsScreen extends StatelessWidget {
  const VaccinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vaccinations = [
      {
        'name': 'COVID-19 Booster',
        'date': '15 Jan 2026',
        'status': 'Completed',
      },
      {
        'name': 'Influenza Vaccine',
        'date': '20 Aug 2026',
        'status': 'Upcoming',
      },
      {
        'name': 'Tetanus',
        'date': '10 Mar 2025',
        'status': 'Completed',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccinations'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Add Vaccination feature coming soon.',
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: vaccinations.length,
        itemBuilder: (context, index) {
          final vaccine = vaccinations[index];

          final bool completed =
              vaccine['status'] == 'Completed';

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor:
                completed ? Colors.green.shade100 : Colors.orange.shade100,
                child: Icon(
                  completed ? Icons.check : Icons.schedule,
                  color: completed ? Colors.green : Colors.orange,
                ),
              ),
              title: Text(
                vaccine['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'Date: ${vaccine['date']}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              trailing: Chip(
                label: Text(vaccine['status']!),
                backgroundColor: completed
                    ? Colors.green.shade100
                    : Colors.orange.shade100,
              ),
            ),
          );
        },
      ),
    );
  }
}