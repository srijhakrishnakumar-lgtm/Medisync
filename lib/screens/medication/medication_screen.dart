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

  bool isSaving = false;

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
      builder: (_) =>
          AlertDialog(
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
                  const SizedBox(height: 10),
                  TextField(
                    controller: dosageController,
                    decoration: const InputDecoration(
                      labelText: "Dosage",
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: timeController,
                    readOnly: true,
                    onTap: pickTime,
                    decoration: const InputDecoration(
                      labelText: "Reminder Time",
                      suffixIcon: Icon(Icons.access_time),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  if (medicineController.text
                      .trim()
                      .isEmpty ||
                      dosageController.text
                          .trim()
                          .isEmpty ||
                      notesController.text
                          .trim()
                          .isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all required fields."),
                      ),
                    );
                    return;
                  }

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

                  try {
                    await NotificationService.instance
                        .scheduleMedicationNotification(
                      id: docRef.id.hashCode,
                      medicine: medicineController.text.trim(),
                      time: selectedTime!,
                    );
                  } catch (e) {
                    debugPrint(e.toString());
                  }

                  if (mounted) {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Medication reminder scheduled.",
                        ),
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

  Future<void> editMedication(DocumentSnapshot doc,
      Map<String, dynamic> data,) async {
    final medicineController =
    TextEditingController(text: data["medicine"]);

    final dosageController =
    TextEditingController(text: data["dosage"]);

    final timeController =
    TextEditingController(text: data["time"]);

    final notesController =
    TextEditingController(text: data["notes"]);

    TimeOfDay selectedTime = TimeOfDay(
      hour: data["hour"] ?? 0,
      minute: data["minute"] ?? 0,
    );

    Future<void> pickTime() async {
      final picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (picked != null) {
        selectedTime = picked;
        timeController.text = picked.format(context);
      }
    }

    await showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: const Text("Edit Medication"),
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
                  const SizedBox(height: 10),
                  TextField(
                    controller: dosageController,
                    decoration: const InputDecoration(
                      labelText: "Dosage",
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: timeController,
                    readOnly: true,
                    onTap: pickTime,
                    decoration: const InputDecoration(
                      labelText: "Reminder Time",
                      suffixIcon: Icon(Icons.access_time),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  await doc.reference.update({
                    "medicine": medicineController.text.trim(),
                    "dosage": dosageController.text.trim(),
                    "time": timeController.text.trim(),
                    "hour": selectedTime.hour,
                    "minute": selectedTime.minute,
                    "notes": notesController.text.trim(),
                  });

                  try {
                    await NotificationService.instance.cancelNotification(
                      doc.id.hashCode,
                    );

                    await NotificationService.instance
                        .scheduleMedicationNotification(
                      id: doc.id.hashCode,
                      medicine: medicineController.text.trim(),
                      time: selectedTime,
                    );
                  } catch (e) {
                    debugPrint(e.toString());
                  }

                  if (mounted) {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Medication updated successfully."),
                      ),
                    );
                  }
                },
                child: const Text("Update"),
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
                  onTap: () {
                    editMedication(
                      docs[index],
                      data,
                    );
                  },
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
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Delete Medication"),
                          content: const Text(
                            "Are you sure you want to delete this medication?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, false),
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(context, true),
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );

                      if (confirm != true) return;

                      try {
                        await NotificationService.instance
                            .cancelNotification(
                          docs[index].id.hashCode,
                        );
                      } catch (_) {}

                      await docs[index].reference.delete();

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Medication deleted."),
                          ),
                        );
                      }
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
