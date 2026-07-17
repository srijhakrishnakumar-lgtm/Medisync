import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medisync/services/notification_service.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addMedication() async {
    final medicineController = TextEditingController();
    final dosageController = TextEditingController();
    final timeController = TextEditingController();
    final notesController = TextEditingController();

    TimeOfDay? selectedTime;

    Future<void> pickTime() async {
      final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (picked != null) {
        selectedTime = picked;
        timeController.text = picked.format(context);
      }
    }

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Medication"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: medicineController,
                decoration: const InputDecoration(
                  labelText: "Medicine Name",
                ),
              ),
              TextField(
                controller: dosageController,
                decoration: const InputDecoration(
                  labelText: "Dosage",
                ),
              ),
              TextField(
                controller: timeController,
                readOnly: true,
                onTap: pickTime,
                decoration: const InputDecoration(
                  labelText: "Reminder Time",
                  suffixIcon: Icon(Icons.access_time),
                ),
              ),
              TextField(
                controller: notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Notes",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (selectedTime == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select a reminder time."),
                  ),
                );
                return;
              }

              final docRef = await firestore
                  .collection("users")
                  .doc(auth.currentUser!.uid)
                  .collection("medications")
                  .add({
                "medicine": medicineController.text.trim(),
                "dosage": dosageController.text.trim(),
                "time": timeController.text.trim(),
                "hour": selectedTime!.hour,
                "minute": selectedTime!.minute,
                "notes": notesController.text.trim(),
                "createdAt": FieldValue.serverTimestamp(),
              });

              await NotificationService.instance.scheduleMedicationNotification(
                id: docRef.id.hashCode,
                medicine: medicineController.text.trim(),
                time: selectedTime!,
              );

              if (mounted) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Medication reminder scheduled."),
                  ),
                );
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid = auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication Reminder"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: addMedication,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("users")
            .doc(uid)
            .collection("medications")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                "No Medications Added",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, index) {
              final data =
              docs[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Icon(
                      Icons.medication,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(data["medicine"] ?? ""),
                  subtitle: Text(
                    "${data["dosage"]}\n${data["time"]}\n${data["notes"]}",
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await docs[index].reference.delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}