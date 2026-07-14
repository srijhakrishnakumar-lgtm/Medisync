import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../routes/app_routes.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';

import '../features/dashboard/presentation/screens/dashboard_screen.dart';

import '../features/profile/presentation/screens/profile_screen.dart';

import '../features/documents/presentation/screens/documents_screen.dart';

import '../features/qr_passport/presentation/screens/qr_passport_screen.dart';

import '../features/appointments/presentation/screens/appointments_screen.dart';

import '../features/vaccinations/presentation/screens/vaccinations_screen.dart';
import '../features/medications/presentation/screens/medications_screen.dart';

import '../features/emergency/presentation/screens/emergency_screen.dart';

import '../features/settings/presentation/screens/settings_screen.dart';

class MediSyncApp extends StatelessWidget {
  const MediSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediSync',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: {
        // Authentication
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.signup: (_) => const SignupScreen(),

        // Dashboard
        AppRoutes.dashboard: (_) => const DashboardScreen(),

        // Profile
        AppRoutes.profile: (_) => const ProfileScreen(),

        // Features
        AppRoutes.documents: (_) => const DocumentsScreen(),
        AppRoutes.qrPassport: (_) => const QrPassportScreen(),
        AppRoutes.appointments: (_) => const AppointmentsScreen(),
        AppRoutes.vaccinations: (_) => const VaccinationsScreen(),
        AppRoutes.medications: (_) => const MedicationsScreen(),
        AppRoutes.emergency: (_) => const EmergencyScreen(),
        AppRoutes.settings: (_) => const SettingsScreen(),
      },
    );
  }
}