import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VaccinationScreen extends StatefulWidget {
  const VaccinationScreen({super.key});

  @override
  State<VaccinationScreen> createState() => _VaccinationScreenState();
}

class _VaccinationScreenState extends State<VaccinationScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addVaccination() async {
    final vaccineController = TextEditingController();
    final hospitalController = TextEditingController();
    final dateController = TextEditingController();
    final doseController = TextEditingController();

    Future<void> pickDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (picked != null) {
        dateController.text =
        "${picked.day}/${picked.month}/${picked.year}";
      }
    }

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Vaccination"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: vaccineController,
                decoration: const InputDecoration(
                  labelText: "Vaccine Name",
                ),
              ),
              TextField(
                controller: doseController,
                decoration: const InputDecoration(
                  labelText: "Dose",
                ),
              ),
              TextField(
                controller: hospitalController,
                decoration: const InputDecoration(
                  labelText: "Hospital / Clinic",
                ),
              ),
              TextField(
                controller: dateController,
                readOnly: true,
                onTap: pickDate,
                decoration: const InputDecoration(
                  labelText: "Vaccination Date",
                  suffixIcon: Icon(Icons.calendar_today),
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
              await firestore
                  .collection("users")
                  .doc(auth.currentUser!.uid)
                  .collection("vaccinations")
                  .add({
                "vaccine": vaccineController.text.trim(),
                "dose": doseController.text.trim(),
                "hospital": hospitalController.text.trim(),
                "date": dateController.text.trim(),
                "createdAt": FieldValue.serverTimestamp(),
              });

              if (mounted) {
                Navigator.pop(context);
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
        title: const Text("Vaccination Tracker"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: addVaccination,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("users")
            .doc(uid)
            .collection("vaccinations")
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
                "No Vaccinations Added",
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
                      Icons.vaccines,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(data["vaccine"] ?? ""),
                  subtitle: Text(
                    "${data["dose"]}\n${data["hospital"]}\n${data["date"]}",
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