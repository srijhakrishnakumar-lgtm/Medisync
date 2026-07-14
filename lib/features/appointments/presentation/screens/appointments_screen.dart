import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to Book Appointment
        },
        icon: const Icon(Icons.add),
        label: const Text('Book'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Upcoming',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const _AppointmentCard(
            doctor: 'Dr. Sarah Johnson',
            specialty: 'Cardiologist',
            date: '18 July 2026',
            time: '10:30 AM',
            location: 'City Hospital',
            upcoming: true,
          ),

          const SizedBox(height: 24),

          Text(
            'Previous',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const _AppointmentCard(
            doctor: 'Dr. Michael Lee',
            specialty: 'Dermatologist',
            date: '05 June 2026',
            time: '2:00 PM',
            location: 'Apollo Clinic',
            upcoming: false,
          ),

          const SizedBox(height: 16),

          const _AppointmentCard(
            doctor: 'Dr. Emily Brown',
            specialty: 'General Physician',
            date: '12 April 2026',
            time: '9:15 AM',
            location: 'Health Care Center',
            upcoming: false,
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String doctor;
  final String specialty;
  final String date;
  final String time;
  final String location;
  final bool upcoming;

  const _AppointmentCard({
    required this.doctor,
    required this.specialty,
    required this.date,
    required this.time,
    required this.location,
    required this.upcoming,
  });

  @override
  Widget build(BuildContext context) {
    final color = upcoming ? Colors.green : Colors.grey;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.12),
                  child: Icon(
                    Icons.medical_services,
                    color: color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    doctor,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    upcoming ? 'Upcoming' : 'Completed',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.medical_services),
              title: const Text('Specialty'),
              subtitle: Text(specialty),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today),
              title: const Text('Date'),
              subtitle: Text(date),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.access_time),
              title: const Text('Time'),
              subtitle: Text(time),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.location_on),
              title: const Text('Hospital'),
              subtitle: Text(location),
            ),
          ],
        ),
      ),
    );
  }
}