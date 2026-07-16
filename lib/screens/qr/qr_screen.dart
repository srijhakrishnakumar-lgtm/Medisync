import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
bool isLoading = true;
Map<String, dynamic>? profile;

@override
void initState() {
super.initState();
loadProfile();
}

Future<void> loadProfile() async {
try {
final uid = FirebaseAuth.instance.currentUser!.uid;

final doc = await FirebaseFirestore.instance
.collection("users")
.doc(uid)
.get();

if (doc.exists) {
profile = doc.data();
}
} catch (e) {
debugPrint(e.toString());
}

setState(() {
isLoading = false;
});
}

String get qrData {
if (profile == null) return "";

return '''
Name: ${profile!["fullName"] ?? ""}
Blood Group: ${profile!["bloodGroup"] ?? ""}
Allergies: ${profile!["allergies"] ?? ""}
Diseases: ${profile!["diseases"] ?? ""}
Emergency Contact: ${profile!["emergencyName"] ?? ""} (${profile!["emergencyPhone"] ?? ""})
''';
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Emergency QR"),
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
),
body: isLoading
? const Center(
child: CircularProgressIndicator(),
)
: profile == null
? const Center(
child: Text(
"Please complete your profile first.",
style: TextStyle(fontSize: 18),
),
)
: SingleChildScrollView(
padding: const EdgeInsets.all(20),
child: Column(
children: [
const Icon(
Icons.health_and_safety,
color: Colors.red,
size: 70,
),

const SizedBox(height: 10),

const Text(
"Emergency Health Card",
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 25),

Card(
elevation: 5,
shape: RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(18),
),
child: Padding(
padding:
const EdgeInsets.all(20),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
infoTile(
Icons.person,
"Name",
profile!["fullName"] ?? "",
),

infoTile(
Icons.bloodtype,
"Blood Group",
profile!["bloodGroup"] ?? "",
),

infoTile(
Icons.warning,
"Allergies",
profile!["allergies"] ?? "",
),

infoTile(
Icons.medical_services,
"Diseases",
profile!["diseases"] ?? "",
),

infoTile(
Icons.phone,
"Emergency Contact",
"${profile!["emergencyName"]}\n${profile!["emergencyPhone"]}",
),

const SizedBox(height: 25),

Center(
child: QrImageView(
data: qrData,
size: 240,
),
),
  const SizedBox(height: 15),

  const Center(
    child: Text(
      "Scan this QR in case of emergency",
      style: TextStyle(
        color: Colors.grey,
      ),
    ),
  ),
],
),
),
),
],
),
),
);
}

Widget infoTile(
    IconData icon,
    String title,
    String value,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.teal,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              children: [
                TextSpan(
                  text: "$title: ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}