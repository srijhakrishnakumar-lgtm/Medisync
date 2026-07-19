import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() =>
      _AppointmentScreenState();
}

class _AppointmentScreenState
    extends State<AppointmentScreen> {
final FirebaseFirestore firestore =
FirebaseFirestore.instance;

final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> pickDate(
TextEditingController controller) async {
FocusScope.of(context).unfocus();

final picked = await showDatePicker(
context: context,
initialDate: DateTime.now(),
firstDate: DateTime.now(),
lastDate: DateTime(2100),
);

if (picked != null) {
controller.text =
"${picked.day.toString().padLeft(2, '0')}/"
"${picked.month.toString().padLeft(2, '0')}/"
"${picked.year}";
}
}

Future<void> pickTime(
TextEditingController controller) async {
FocusScope.of(context).unfocus();

final picked = await showTimePicker(
context: context,
initialTime: TimeOfDay.now(),
);

if (picked != null) {
controller.text = picked.format(context);
}
}

Future<void> addAppointment() async {
final doctorController =
TextEditingController();

final hospitalController =
TextEditingController();

final dateController =
TextEditingController();

final timeController =
TextEditingController();

final notesController =
TextEditingController();

await showDialog(
context: context,
builder: (_) => AlertDialog(
title: const Text("New Appointment"),
content: SingleChildScrollView(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextField(
controller: doctorController,
decoration:
const InputDecoration(
labelText: "Doctor Name",
),
),
const SizedBox(height: 10),

TextField(
controller: hospitalController,
decoration:
const InputDecoration(
labelText: "Hospital",
),
),
const SizedBox(height: 10),

TextField(
controller: dateController,
readOnly: true,
onTap: () =>
pickDate(dateController),
decoration:
const InputDecoration(
labelText: "Date",
suffixIcon:
Icon(Icons.calendar_month),
),
),
const SizedBox(height: 10),

TextField(
controller: timeController,
readOnly: true,
onTap: () =>
pickTime(timeController),
decoration:
const InputDecoration(
labelText: "Time",
suffixIcon:
Icon(Icons.access_time),
),
),
const SizedBox(height: 10),

TextField(
controller: notesController,
maxLines: 3,
decoration:
const InputDecoration(
labelText: "Notes",
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
if (doctorController.text
.trim()
.isEmpty ||
hospitalController.text
.trim()
.isEmpty ||
dateController.text
.trim()
.isEmpty ||
timeController.text
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
.collection("appointments")
.add({
"doctor":
doctorController.text.trim(),
"hospital":
hospitalController.text.trim(),
"date":
dateController.text.trim(),
"time":
timeController.text.trim(),
"notes":
notesController.text.trim(),
"createdAt":
FieldValue.serverTimestamp(),
});

if (mounted) {
Navigator.pop(context);

ScaffoldMessenger.of(context)
.showSnackBar(
const SnackBar(
content: Text(
"Appointment added successfully.",
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

Future<void> editAppointment(
DocumentSnapshot doc,
Map<String, dynamic> data,
) async {
final doctorController =
TextEditingController(
text: data["doctor"],
);

final hospitalController =
TextEditingController(
text: data["hospital"],
);

final dateController =
TextEditingController(
text: data["date"],
);

final timeController =
TextEditingController(
text: data["time"],
);

final notesController =
TextEditingController(
text: data["notes"],
);
await showDialog(
  context: context,
  builder: (_) => AlertDialog(
    title: const Text("Edit Appointment"),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: doctorController,
            decoration: const InputDecoration(
              labelText: "Doctor Name",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: hospitalController,
            decoration: const InputDecoration(
              labelText: "Hospital",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: dateController,
            readOnly: true,
            onTap: () => pickDate(dateController),
            decoration: const InputDecoration(
              labelText: "Date",
              suffixIcon: Icon(Icons.calendar_month),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: timeController,
            readOnly: true,
            onTap: () => pickTime(timeController),
            decoration: const InputDecoration(
              labelText: "Time",
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
          if (doctorController.text.trim().isEmpty ||
              hospitalController.text.trim().isEmpty ||
              dateController.text.trim().isEmpty ||
              timeController.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please fill all required fields."),
              ),
            );
            return;
          }

          await doc.reference.update({
            "doctor": doctorController.text.trim(),
            "hospital": hospitalController.text.trim(),
            "date": dateController.text.trim(),
            "time": timeController.text.trim(),
            "notes": notesController.text.trim(),
          });

          if (mounted) {
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Appointment updated successfully."),
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
      title: const Text("Appointments"),
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.teal,
      onPressed: addAppointment,
      child: const Icon(Icons.add),
    ),
    body: StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("users")
          .doc(uid)
          .collection("appointments")
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 70,
                  color: Colors.teal,
                ),
                SizedBox(height: 16),
                Text(
                  "No Appointments",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Tap the + button to schedule your first appointment.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data =
            docs[index].data() as Map<String, dynamic>;

            return Card(
              elevation: 3,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  data["doctor"] ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${data["hospital"]}\n${data["date"]} • ${data["time"]}",
                ),
                isThreeLine: true,
                onTap: () {
                  editAppointment(
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
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Delete Appointment"),
                        content: const Text(
                          "Are you sure you want to delete this appointment?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(context, false),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () =>
                                Navigator.pop(context, true),
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );

                    if (confirm != true) return;

                    await docs[index].reference.delete();

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Appointment deleted."),
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