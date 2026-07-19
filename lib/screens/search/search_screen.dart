import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  List<Map<String, dynamic>> medications = [];
  List<Map<String, dynamic>> appointments = [];
  List<Map<String, dynamic>> vaccinations = [];
  List<Map<String, dynamic>> records = [];

  bool loading = false;

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        medications = [];
        appointments = [];
        vaccinations = [];
        records = [];
      });
      return;
    }

    setState(() => loading = true);

    final medSnap = await firestore
        .collection("users")
        .doc(user!.uid)
        .collection("medications")
        .get();

    final appSnap = await firestore
        .collection("users")
        .doc(user!.uid)
        .collection("appointments")
        .get();

    final vacSnap = await firestore
        .collection("users")
        .doc(user!.uid)
        .collection("vaccinations")
        .get();

    final recSnap = await firestore
        .collection("users")
        .doc(user!.uid)
        .collection("records")
        .get();

    final q = query.toLowerCase();

    medications = medSnap.docs
        .where((d) => d.data().values.join(" ").toLowerCase().contains(q))
        .map((d) => d.data())
        .toList();

    appointments = appSnap.docs
        .where((d) => d.data().values.join(" ").toLowerCase().contains(q))
        .map((d) => d.data())
        .toList();

    vaccinations = vacSnap.docs
        .where((d) => d.data().values.join(" ").toLowerCase().contains(q))
        .map((d) => d.data())
        .toList();

    records = recSnap.docs
        .where((d) => d.data().values.join(" ").toLowerCase().contains(q))
        .map((d) => d.data())
        .toList();

    setState(() => loading = false);
  }

  String getTitle(Map<String, dynamic> item) {
    return (item["medicine"] ??
        item["medicineName"] ??
        item["name"] ??
        item["doctor"] ??
        item["appointment"] ??
        item["title"] ??
        item["vaccine"] ??
        item["vaccineName"] ??
        item["fileName"] ??
        item["file"] ??
        item.values.first)
        .toString();
  }

  Widget buildSection(
      String title,
      IconData icon,
      List<Map<String, dynamic>> items,
      ) {
    if (items.isEmpty) return const SizedBox();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.teal),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            ...items.map(
                  (item) => ListTile(
                leading: Icon(
                  icon,
                  color: Colors.teal,
                ),
                title: Text(
                  getTitle(item),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  item.values.join(" • "),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search medications, appointments...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: search,
            ),
            const SizedBox(height: 20),
            if (loading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              Expanded(
                child: medications.isEmpty &&
                    appointments.isEmpty &&
                    vaccinations.isEmpty &&
                    records.isEmpty
                    ? const Center(
                  child: Text(
                    "No matching results found.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                )
                    : ListView(
                  children: [
                    buildSection(
                      "Medications",
                      Icons.medication,
                      medications,
                    ),
                    buildSection(
                      "Appointments",
                      Icons.calendar_month,
                      appointments,
                    ),
                    buildSection(
                      "Vaccinations",
                      Icons.health_and_safety,
                      vaccinations,
                    ),
                    buildSection(
                      "Medical Records",
                      Icons.folder,
                      records,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}