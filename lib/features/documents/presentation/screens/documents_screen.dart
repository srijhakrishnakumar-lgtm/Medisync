import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Medical Documents"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Upload feature coming soon!"),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [

          DocumentCard(
            icon: Icons.description,
            color: Colors.blue,
            title: "Blood Test Report",
            subtitle: "Uploaded on 10 July 2026",
          ),

          SizedBox(height: 16),

          DocumentCard(
            icon: Icons.medical_services,
            color: Colors.green,
            title: "Prescription",
            subtitle: "Uploaded on 04 July 2026",
          ),

          SizedBox(height: 16),

          DocumentCard(
            icon: Icons.vaccines,
            color: Colors.orange,
            title: "Vaccination Certificate",
            subtitle: "Uploaded on 20 June 2026",
          ),

          SizedBox(height: 16),

          DocumentCard(
            icon: Icons.local_hospital,
            color: Colors.red,
            title: "MRI Scan",
            subtitle: "Uploaded on 12 May 2026",
          ),
        ],
      ),
    );
  }
}

class DocumentCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const DocumentCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),

        leading: CircleAvatar(
          radius: 28,
          backgroundColor: color.withOpacity(.15),
          child: Icon(
            icon,
            color: color,
            size: 30,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(subtitle),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
      ),
    );
  }
}