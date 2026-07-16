import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../routes/app_routes.dart';
import '../widgets/auth_header.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.dashboard,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                const SizedBox(height: 20),

                const AuthHeader(
                  title: "Create Account",
                  subtitle:
                  "Create your Digital Health Passport.",
                ),

                const SizedBox(height: 35),

                CustomTextField(
                  controller: nameController,
                  label: "Full Name",
                  hintText: "Enter your name",
                  prefixIcon: Icons.person,
                  validator: (v) =>
                  v!.isEmpty ? "Required" : null,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  controller: emailController,
                  label: "Email",
                  hintText: "Enter email",
                  prefixIcon: Icons.email,
                  validator: (v) =>
                  v!.contains("@") ? null : "Invalid email",
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  controller: passwordController,
                  label: "Password",
                  hintText: "Minimum 6 characters",
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  validator: (v) =>
                  v!.length >= 6 ? null : "Too short",
                ),

                const SizedBox(height: 30),

                PrimaryButton(
                  text: "Create Account",
                  isLoading: loading,
                  onPressed: signup,
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Already have an account? Login",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}