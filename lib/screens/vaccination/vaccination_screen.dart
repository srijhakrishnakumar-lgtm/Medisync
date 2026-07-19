import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VaccinationScreen extends StatefulWidget {
  const VaccinationScreen({super.key});

  @override
  State<VaccinationScreen> createState() =>
      _VaccinationScreenState();
}

class _VaccinationScreenState
    extends State<VaccinationScreen> {
final FirebaseFirestore firestore =
FirebaseFirestore.instance;

final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> addVaccination() async {
final vaccineController =
TextEditingController();

final hospitalController =
TextEditingController();

final dateController =
TextEditingController();

final doseController =
TextEditingController();

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
decoration:
const InputDecoration(
labelText: "Vaccine Name",
),
),
const SizedBox(height: 10),
TextField(
controller: doseController,
decoration:
const InputDecoration(
labelText: "Dose",
),
),
const SizedBox(height: 10),
TextField(
controller: hospitalController,
decoration:
const InputDecoration(
labelText:
"Hospital / Clinic",
),
),
const SizedBox(height: 10),
TextField(
controller: dateController,
readOnly: true,
onTap: pickDate,
decoration:
const InputDecoration(
labelText:
"Vaccination Date",
suffixIcon: Icon(
Icons.calendar_today,
),
),
),
],
),
),
actions: [
TextButton(
onPressed: () =>
Navigator.pop(context),
child: const Text("Cancel"),
),
ElevatedButton(
onPressed: () async {
if (vaccineController.text
.trim()
.isEmpty ||
doseController.text
.trim()
.isEmpty ||
hospitalController.text
.trim()
.isEmpty ||
dateController.text
.trim()
.isEmpty) {
ScaffoldMessenger.of(context)
.showSnackBar(
const SnackBar(
content: Text(
"Please fill all required fields.",
),
),
);
return;
}

await firestore
.collection("users")
.doc(auth.currentUser!.uid)
.collection("vaccinations")
.add({
"vaccine":
vaccineController.text.trim(),
"dose":
doseController.text.trim(),
"hospital":
hospitalController.text.trim(),
"date":
dateController.text.trim(),
"createdAt":
FieldValue.serverTimestamp(),
});

if (mounted) {
Navigator.pop(context);

ScaffoldMessenger.of(context)
.showSnackBar(
const SnackBar(
content: Text(
"Vaccination added successfully.",
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

Future<void> editVaccination(
DocumentSnapshot doc,
Map<String, dynamic> data,
) async {
final vaccineController =
TextEditingController(
text: data["vaccine"],
);

final hospitalController =
TextEditingController(
text: data["hospital"],
);

final doseController =
TextEditingController(
text: data["dose"],
);

final dateController =
TextEditingController(
text: data["date"],
);
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
    title: const Text("Edit Vaccination"),
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
          const SizedBox(height: 10),
          TextField(
            controller: doseController,
            decoration: const InputDecoration(
              labelText: "Dose",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: hospitalController,
            decoration: const InputDecoration(
              labelText: "Hospital / Clinic",
            ),
          ),
          const SizedBox(height: 10),
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
          if (vaccineController.text.trim().isEmpty ||
              doseController.text.trim().isEmpty ||
              hospitalController.text.trim().isEmpty ||
              dateController.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    "Please fill all required fields."),
              ),
            );
            return;
          }

          await doc.reference.update({
            "vaccine": vaccineController.text.trim(),
            "dose": doseController.text.trim(),
            "hospital": hospitalController.text.trim(),
            "date": dateController.text.trim(),
          });

          if (mounted) {
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    "Vaccination updated successfully."),
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
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.vaccines,
                  size: 70,
                  color: Colors.teal,
                ),
                SizedBox(height: 16),
                Text(
                  "No Vaccinations",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Tap the + button to add your vaccination records.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (_, index) {
            final data =
            docs[index].data()
            as Map<String, dynamic>;

            return Card(
              margin:
              const EdgeInsets.all(10),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor:
                  Colors.teal,
                  child: Icon(
                    Icons.vaccines,
                    color: Colors.white,
                  ),
                ),
                title:
                Text(data["vaccine"] ?? ""),
                subtitle: Text(
                  "${data["dose"]}\n${data["hospital"]}\n${data["date"]}",
                ),
                isThreeLine: true,
                onTap: () {
                  editVaccination(
                    docs[index],
                    data,
                  );
                },
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    final confirm =
                    await showDialog<bool>(
                      context: context,
                      builder: (_) =>
                          AlertDialog(
                            title: const Text(
                                "Delete Vaccination"),
                            content: const Text(
                              "Are you sure you want to delete this vaccination record?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(
                                        context,
                                        false),
                                child:
                                const Text("Cancel"),
                              ),
                              ElevatedButton(
                                style:
                                ElevatedButton
                                    .styleFrom(
                                  backgroundColor:
                                  Colors.red,
                                  foregroundColor:
                                  Colors.white,
                                ),
                                onPressed: () =>
                                    Navigator.pop(
                                        context,
                                        true),
                                child:
                                const Text("Delete"),
                              ),
                            ],
                          ),
                    );

                    if (confirm != true) return;

                    await docs[index]
                        .reference
                        .delete();

                    if (mounted) {
                      ScaffoldMessenger.of(
                          context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Vaccination deleted."),
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