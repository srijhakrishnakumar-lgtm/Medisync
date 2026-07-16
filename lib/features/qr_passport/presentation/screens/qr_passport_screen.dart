import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/constants/app_colors.dart';

class QrPassportScreen extends StatelessWidget {
  const QrPassportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const qrData = "MediSync|John Doe|O+|ID:MS001";

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Health Passport"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: AppColors.primaryLight,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "John Doe",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Digital Health Passport",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 25),

                    QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 220,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Passport ID",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "MS001",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Download feature coming soon!",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text("Download QR"),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Share feature coming soon!",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text("Share QR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}