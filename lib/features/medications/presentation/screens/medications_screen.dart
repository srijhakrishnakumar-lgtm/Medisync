import 'package:flutter/material.dart';


class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final medications = [
      {
        'name': 'Paracetamol',
        'dosage': '500 mg',
        'schedule': 'Twice a day',
        'duration': '10 Jul - 15 Jul',
        'status': 'Active',
      },
      {
        'name': 'Vitamin D3',
        'dosage': '1000 IU',
        'schedule': 'Once daily',
        'duration': '01 Jul - 30 Jul',
        'status': 'Active',
      },
      {
        'name': 'Amoxicillin',
        'dosage': '250 mg',
        'schedule': 'Three times a day',
        'duration': '15 Jun - 22 Jun',
        'status': 'Completed',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medications'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Add Medication feature coming soon.',
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: medications.length,
        itemBuilder: (context, index) {
          final medication = medications[index];

          final bool active = medication['status'] == 'Active';

          return Card(
            margin: const EdgeInsets.only(bottom: 18),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: active
                            ? Colors.blue.shade100
                            : Colors.grey.shade300,
                        child: Icon(
                          Icons.medication,
                          color: active ? Colors.blue : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          medication['name']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Chip(
                        label: Text(medication['status']!),
                        backgroundColor: active
                            ? Colors.green.shade100
                            : Colors.grey.shade300,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Icon(Icons.medical_services_outlined, size: 18),
                      const SizedBox(width: 8),
                      Text('Dosage: ${medication['dosage']}'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 18),
                      const SizedBox(width: 8),
                      Text('Schedule: ${medication['schedule']}'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 18),
                      const SizedBox(width: 8),
                      Text('Duration: ${medication['duration']}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}