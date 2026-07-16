import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void addRecord() {
    final titleController = TextEditingController();
    final doctorController = TextEditingController();
    final dateController = TextEditingController();
    final notesController = TextEditingController();

    String selectedType = "Prescription";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Add Medical Record"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration:
                      const InputDecoration(labelText: "Record Title"),
                    ),
                    TextField(
                      controller: doctorController,
                      decoration:
                      const InputDecoration(labelText: "Hospital / Doctor"),
                    ),
                    TextField(
                      controller: dateController,
                      decoration:
                      const InputDecoration(labelText: "Date"),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      items: const [
                        DropdownMenuItem(
                          value: "Prescription",
                          child: Text("Prescription"),
                        ),
                        DropdownMenuItem(
                          value: "Lab Report",
                          child: Text("Lab Report"),
                        ),
                        DropdownMenuItem(
                          value: "Scan",
                          child: Text("Scan"),
                        ),
                        DropdownMenuItem(
                          value: "Vaccination",
                          child: Text("Vaccination"),
                        ),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          selectedType = value!;
                        });
                      },
                    ),
                    TextField(
                      controller: notesController,
                      maxLines: 3,
                      decoration:
                      const InputDecoration(labelText: "Notes"),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final uid = auth.currentUser!.uid;

                    await firestore
                        .collection("users")
                        .doc(uid)
                        .collection("records")
                        .add({
                      "title": titleController.text,
                      "doctor": doctorController.text,
                      "date": dateController.text,
                      "type": selectedType,
                      "notes": notesController.text,
                      "createdAt": FieldValue.serverTimestamp(),
                    });

                    if (mounted) Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid = auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Medical Records"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: addRecord,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("users")
            .doc(uid)
            .collection("records")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                "No Medical Records Yet",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final record =
              docs[index].data() as Map<String, dynamic>;

              return Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.description,
                    color: Colors.teal,
                  ),
                  title: Text(record["title"] ?? ""),
                  subtitle: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(record["doctor"] ?? ""),
                      Text(record["date"] ?? ""),
                      Text(record["type"] ?? ""),
                    ],
                  ),
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