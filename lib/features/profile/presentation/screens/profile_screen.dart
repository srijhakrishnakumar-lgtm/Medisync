import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget buildProfileTile(
      IconData icon,
      String title,
      String value,
      ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(value),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor: AppColors.primaryLight,
              child: Icon(
                Icons.person,
                size: 60,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "John Doe",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "john@example.com",
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 30),

            buildProfileTile(
              Icons.badge,
              "Full Name",
              "John Doe",
            ),

            buildProfileTile(
              Icons.cake,
              "Date of Birth",
              "12 May 2004",
            ),

            buildProfileTile(
              Icons.bloodtype,
              "Blood Group",
              "O+",
            ),

            buildProfileTile(
              Icons.phone,
              "Phone Number",
              "+91 9876543210",
            ),

            buildProfileTile(
              Icons.location_on,
              "Address",
              "Hyderabad, India",
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Edit Profile coming soon!",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}