import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../routes/app_routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 42,
              child: Icon(
                Icons.person,
                size: 45,
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Center(
            child: Text(
              'John Doe',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Center(
            child: Text(
              'john.doe@email.com',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ),

          const SizedBox(height: 30),

          _SettingsTile(
            icon: Icons.person_outline,
            title: 'Profile',
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.profile,
              );
            },
          ),

          _SettingsTile(
            icon: Icons.lock_outline,
            title: 'Privacy & Security',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Privacy settings coming soon.',
                  ),
                ),
              );
            },
          ),

          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode'),
            value: false,
            onChanged: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Dark mode will be available soon.',
                  ),
                ),
              );
            },
          ),

          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Notification settings coming soon.',
                  ),
                ),
              );
            },
          ),

          _SettingsTile(
            icon: Icons.description_outlined,
            title: 'Terms & Privacy Policy',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Terms & Privacy Policy coming soon.',
                  ),
                ),
              );
            },
          ),

          _SettingsTile(
            icon: Icons.info_outline,
            title: 'About MediSync',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'MediSync',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2026 MediSync',
              );
            },
          ),

          const Divider(height: 40),

          _SettingsTile(
            icon: Icons.logout,
            iconColor: Colors.red,
            textColor: Colors.red,
            title: 'Logout',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}