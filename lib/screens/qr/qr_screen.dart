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
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final doc = await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get();

    if (doc.exists) {
      userData = doc.data();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (userData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Emergency QR"),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text(
            "Please complete your profile first.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    final qrData = '''
Name: ${userData!["fullName"] ?? ""}
Blood Group: ${userData!["bloodGroup"] ?? ""}
Allergies: ${userData!["allergies"] ?? ""}
Medications: ${userData!["medications"] ?? ""}
Emergency Contact: ${userData!["emergencyName"] ?? ""}
Phone: ${userData!["emergencyPhone"] ?? ""}
''';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency QR"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.health_and_safety,
                    color: Colors.teal,
                    size: 60,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Emergency Health QR",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    userData!["fullName"] ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 25),

                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 250,
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Scan this QR in case of emergency.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ListTile(
                    leading: const Icon(
                      Icons.bloodtype,
                      color: Colors.red,
                    ),
                    title: const Text("Blood Group"),
                    subtitle:
                    Text(userData!["bloodGroup"] ?? "-"),
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.warning,
                      color: Colors.orange,
                    ),
                    title: const Text("Allergies"),
                    subtitle:
                    Text(userData!["allergies"] ?? "None"),
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    title: const Text("Emergency Contact"),
                    subtitle: Text(
                      "${userData!["emergencyName"] ?? ""}\n${userData!["emergencyPhone"] ?? ""}",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}