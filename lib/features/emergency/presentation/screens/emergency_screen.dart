import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              color: Colors.red.shade50,
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Colors.red,
                      size: 40,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'This information can help medical professionals during an emergency.',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            _InfoCard(
              icon: Icons.bloodtype,
              title: 'Blood Group',
              value: 'O+',
              iconColor: Colors.red,
            ),

            const SizedBox(height: 16),

            _InfoCard(
              icon: Icons.warning_amber_rounded,
              title: 'Allergies',
              value: 'Peanuts',
              iconColor: Colors.orange,
            ),

            const SizedBox(height: 16),

            _InfoCard(
              icon: Icons.medication,
              title: 'Current Medications',
              value: 'Vitamin D3, Paracetamol',
              iconColor: Colors.blue,
            ),

            const SizedBox(height: 16),

            _InfoCard(
              icon: Icons.local_hospital,
              title: 'Medical Conditions',
              value: 'None',
              iconColor: Colors.green,
            ),

            const SizedBox(height: 16),

            _InfoCard(
              icon: Icons.phone,
              title: 'Emergency Contact',
              value: '+91 9876543210',
              iconColor: Colors.purple,
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Calling emergency contact will be added later.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.call),
              label: const Text('Call Emergency Contact'),
            ),

            const SizedBox(height: 16),

            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Location sharing will be added later.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.location_on),
              label: const Text('Share Current Location'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.15),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}