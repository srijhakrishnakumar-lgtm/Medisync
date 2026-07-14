import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
class QrPassportScreen extends StatelessWidget {
  const QrPassportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency QR Passport'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Digital Health Passport',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.qr_code_2,
                          size: 150,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Divider(),

                    const SizedBox(height: 16),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Blood Group',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          'O+',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Allergies',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          'Peanuts',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Emergency Contact',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '+91 9876543210',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'In an emergency, medical staff can scan your QR code to securely access your essential health information.',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Share feature coming soon.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Download feature coming soon.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}