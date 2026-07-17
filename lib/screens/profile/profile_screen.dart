import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/firestore_services.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
final _formKey = GlobalKey<FormState>();

final FirestoreService firestoreService = FirestoreService();

bool isLoading = false;

final fullNameController = TextEditingController();
final emailController = TextEditingController();
final phoneController = TextEditingController();
final dobController = TextEditingController();

final heightController = TextEditingController();
final weightController = TextEditingController();
final allergiesController = TextEditingController();
final diseasesController = TextEditingController();
final medicationsController = TextEditingController();

final emergencyNameController = TextEditingController();
final emergencyPhoneController = TextEditingController();
final emergencyRelationController = TextEditingController();

String? selectedGender;
String? selectedBloodGroup;

@override
void initState() {
  super.initState();
  loadProfile();
}
Future<void> pickDate(TextEditingController controller) async {
  FocusScope.of(context).unfocus();

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (picked != null) {
    controller.text =
    "${picked.day.toString().padLeft(2, '0')}/"
        "${picked.month.toString().padLeft(2, '0')}/"
        "${picked.year}";
  }
}


Future<void> loadProfile() async {
try {
final doc = await firestoreService.getUserProfile();

if (!doc.exists) {
emailController.text =
FirebaseAuth.instance.currentUser?.email ?? "";
return;
}

final data = doc.data()!;

fullNameController.text = data["fullName"] ?? "";
emailController.text = data["email"] ?? "";
phoneController.text = data["phone"] ?? "";
dobController.text = data["dob"] ?? "";

selectedGender = data["gender"];
selectedBloodGroup = data["bloodGroup"];

heightController.text = data["height"] ?? "";
weightController.text = data["weight"] ?? "";
allergiesController.text = data["allergies"] ?? "";
diseasesController.text = data["diseases"] ?? "";
medicationsController.text = data["medications"] ?? "";

emergencyNameController.text =
data["emergencyName"] ?? "";
emergencyPhoneController.text =
data["emergencyPhone"] ?? "";
emergencyRelationController.text =
data["emergencyRelation"] ?? "";

setState(() {});
} catch (_) {}
}

Future<void> saveProfile() async {
setState(() => isLoading = true);

try {
await firestoreService.saveUserProfile({
"fullName": fullNameController.text.trim(),
"email": emailController.text.trim(),
"phone": phoneController.text.trim(),
"dob": dobController.text.trim(),
"gender": selectedGender,
"bloodGroup": selectedBloodGroup,
"height": heightController.text.trim(),
"weight": weightController.text.trim(),
"allergies": allergiesController.text.trim(),
"diseases": diseasesController.text.trim(),
"medications": medicationsController.text.trim(),
"emergencyName":
emergencyNameController.text.trim(),
"emergencyPhone":
emergencyPhoneController.text.trim(),
"emergencyRelation":
emergencyRelationController.text.trim(),
});

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Profile Saved Successfully"),
),
);
} catch (e) {
if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text(e.toString())),
);
}

if (mounted) {
setState(() => isLoading = false);
}
}

@override
void dispose() {
fullNameController.dispose();
emailController.dispose();
phoneController.dispose();
dobController.dispose();
heightController.dispose();
weightController.dispose();
allergiesController.dispose();
diseasesController.dispose();
medicationsController.dispose();
emergencyNameController.dispose();
emergencyPhoneController.dispose();
emergencyRelationController.dispose();
super.dispose();
}

Widget buildTextField(
    String label,
    TextEditingController controller, {
      TextInputType keyboardType = TextInputType.text,
      bool readOnly = false,
      VoidCallback? onTap,
    }) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: readOnly
            ? const Icon(Icons.calendar_month)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("My Profile"),
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
actions: [
IconButton(
icon: const Icon(Icons.logout),
onPressed: () async {
await FirebaseAuth.instance.signOut();

if (!mounted) return;

Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(
builder: (_) => const LoginScreen(),
),
(route) => false,
);
},
),
],
),
  body: Form(
    key: _formKey,
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Personal Information",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          buildTextField("Full Name", fullNameController),

          buildTextField(
            "Email",
            emailController,
            keyboardType: TextInputType.emailAddress,
          ),

          buildTextField(
            "Phone Number",
            phoneController,
            keyboardType: TextInputType.phone,
          ),

          buildTextField(
            "Date of Birth",
            dobController,
            readOnly: true,
            onTap: () => pickDate(dobController),
          ),

          DropdownButtonFormField<String>(
            value: selectedGender,
            decoration: const InputDecoration(
              labelText: "Gender",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: "Male",
                child: Text("Male"),
              ),
              DropdownMenuItem(
                value: "Female",
                child: Text("Female"),
              ),
              DropdownMenuItem(
                value: "Other",
                child: Text("Other"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),

          const SizedBox(height: 15),

          DropdownButtonFormField<String>(
            value: selectedBloodGroup,
            decoration: const InputDecoration(
              labelText: "Blood Group",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: "A+", child: Text("A+")),
              DropdownMenuItem(value: "A-", child: Text("A-")),
              DropdownMenuItem(value: "B+", child: Text("B+")),
              DropdownMenuItem(value: "B-", child: Text("B-")),
              DropdownMenuItem(value: "AB+", child: Text("AB+")),
              DropdownMenuItem(value: "AB-", child: Text("AB-")),
              DropdownMenuItem(value: "O+", child: Text("O+")),
              DropdownMenuItem(value: "O-", child: Text("O-")),
            ],
            onChanged: (value) {
              setState(() {
                selectedBloodGroup = value;
              });
            },
          ),

          const SizedBox(height: 30),

          const Text(
            "Health Information",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          buildTextField("Height (cm)", heightController),

          buildTextField("Weight (kg)", weightController),

          buildTextField("Allergies", allergiesController),

          buildTextField(
            "Chronic Diseases",
            diseasesController,
          ),

          buildTextField(
            "Current Medications",
            medicationsController,
          ),

          const SizedBox(height: 30),

          const Text(
            "Emergency Contact",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          buildTextField(
            "Contact Name",
            emergencyNameController,
          ),

          buildTextField(
            "Relationship",
            emergencyRelationController,
          ),

          buildTextField(
            "Phone Number",
            emergencyPhoneController,
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                color: Colors.white,
              )
                  : const Text(
                "Save Profile",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    ),
  ),
);
}
}