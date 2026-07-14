import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 55,
                child: Icon(
                  Icons.person,
                  size: 60,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'John Doe',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'john.doe@email.com',
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(height: 24),

              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.badge),
                        title: const Text('Age'),
                        subtitle: const Text('24 Years'),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.bloodtype),
                        title: const Text('Blood Group'),
                        subtitle: const Text('O+'),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.monitor_weight),
                        title: const Text('Weight'),
                        subtitle: const Text('70 kg'),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.height),
                        title: const Text('Height'),
                        subtitle: const Text('175 cm'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.medical_services),
                        title: Text('Allergies'),
                        subtitle: Text('No known allergies'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.favorite),
                        title: Text('Medical Conditions'),
                        subtitle: Text('None'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                elevation: 0,
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: ListTile(
                    leading: Icon(Icons.contact_phone),
                    title: Text('Emergency Contact'),
                    subtitle: Text('+91 9876543210'),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}