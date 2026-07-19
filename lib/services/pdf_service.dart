import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Uint8List> generateHealthPassport() async {
    final uid = _auth.currentUser!.uid;

    final profileDoc =
    await _firestore.collection("users").doc(uid).get();

    final profile = profileDoc.data() ?? <String, dynamic>{};

    final medicationSnapshot = await _firestore
        .collection("users")
        .doc(uid)
        .collection("medications")
        .orderBy("createdAt", descending: true)
        .get();

    final vaccinationSnapshot = await _firestore
        .collection("users")
        .doc(uid)
        .collection("vaccinations")
        .orderBy("createdAt", descending: true)
        .get();

    final appointmentSnapshot = await _firestore
        .collection("users")
        .doc(uid)
        .collection("appointments")
        .orderBy("createdAt", descending: true)
        .get();

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(
          margin: pw.EdgeInsets.all(24),
        ),
        footer: (context) =>
            pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 15),
              child: pw.Text(
                "Page ${context.pageNumber} of ${context.pagesCount}",
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey700,
                ),
              ),
            ),
        build: (context) =>
        [
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(20),
            decoration: pw.BoxDecoration(
              color: PdfColors.teal700,
              borderRadius: pw.BorderRadius.circular(12),
            ),
            child: pw.Column(
              children: [
                pw.Text(
                  "MEDISYNC",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  "Digital Health Passport",
                  style: const pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 20),
          pw.Container(
            padding: const pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.teal300),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _sectionTitle("Personal Information"),
                _infoRow("Full Name", profile["fullName"]),
                _infoRow("Email", profile["email"]),
                _infoRow("Phone", profile["phone"]),
                _infoRow("Blood Group", profile["bloodGroup"]),
                _infoRow("Gender", profile["gender"]),
                _infoRow("Date of Birth", profile["dateOfBirth"]),
                _infoRow("Height", profile["height"]),
                _infoRow("Weight", profile["weight"]),
              ],
            ),
          ),

          pw.SizedBox(height: 15),
          pw.Container(
            padding: const pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.teal300),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _sectionTitle("Medical Information"),
                _infoRow("Allergies", profile["allergies"]),
                _infoRow("Diseases", profile["diseases"]),
                _infoRow("Current Medication", profile["medications"]),
              ],
            ),
          ),

          pw.SizedBox(height: 15),
          pw.Container(
            padding: const pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              color: PdfColors.red50,
              border: pw.Border.all(color: PdfColors.red300),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _sectionTitle("Emergency Contact"),
                _infoRow("Name", profile["emergencyName"]),
                _infoRow("Phone", profile["emergencyPhone"]),
                _infoRow("Relationship", profile["emergencyRelation"]),
              ],
            ),
          ),

          pw.SizedBox(height: 20),
          _sectionTitle("Medication Reminder"),

          pw.Table.fromTextArray(
            border: pw.TableBorder.all(
              color: PdfColors.grey400,
              width: 0.5,
            ),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.teal200,
            ),
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
            cellPadding: const pw.EdgeInsets.all(8),
            headers: const [
              "Medicine",
              "Dosage",
              "Time",
              "Notes",
            ],
            data: medicationSnapshot.docs.map((doc) {
              final d = doc.data();

              return [
                d["medicine"] ?? "-",
                d["dosage"] ?? "-",
                d["time"] ?? "-",
                d["notes"] ?? "-",
              ];
            }).toList(),
          ),

          pw.SizedBox(height: 20),
          _sectionTitle("Vaccination History"),

          pw.Table.fromTextArray(
            border: pw.TableBorder.all(
              color: PdfColors.grey400,
              width: 0.5,
            ),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.teal200,
            ),
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
            cellPadding: const pw.EdgeInsets.all(8),
            headers: const [
              "Vaccine",
              "Dose",
              "Hospital",
              "Date",
            ],
            data: vaccinationSnapshot.docs.map((doc) {
              final d = doc.data();

              return [
                d["vaccine"] ?? "-",
                d["dose"] ?? "-",
                d["hospital"] ?? "-",
                d["date"] ?? "-",
              ];
            }).toList(),
          ),

          pw.SizedBox(height: 20),

          _sectionTitle("Appointments"),

          pw.Table.fromTextArray(
            border: pw.TableBorder.all(
              color: PdfColors.grey400,
              width: 0.5,
            ),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.teal200,
            ),
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
            cellPadding: const pw.EdgeInsets.all(8),
            headers: const [
              "Doctor",
              "Hospital",
              "Date",
              "Time",
            ],
            data: appointmentSnapshot.docs.map((doc) {
              final d = doc.data();

              return [
                d["doctor"] ?? "-",
                d["hospital"] ?? "-",
                d["date"] ?? "-",
                d["time"] ?? "-",
              ];
            }).toList(),
          ),

          pw.SizedBox(height: 25),
          pw.Divider(
            thickness: 1,
            color: PdfColors.grey400,
          ),

          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              "Generated on ${DateFormat('dd MMM yyyy, hh:mm a').format(
                  DateTime.now())}",
              style: const pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey700,
              ),
            ),
          ),

          pw.SizedBox(height: 8),

          pw.Center(
            child: pw.Text(
              "Generated by MediSync • Digital Health Passport",
              style: const pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey600,
              ),
            ),
          ),

        ],
      ),
    );

    return pdf.save();
  }

  pw.Widget _sectionTitle(String title) {
    return pw.Container(
      width: double.infinity,
      margin: const pw.EdgeInsets.only(bottom: 10),
      padding: const pw.EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration: pw.BoxDecoration(
        color: PdfColors.teal100,
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 15,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.teal900,
        ),
      ),
    );
  }

  pw.Widget _infoRow(String label, dynamic value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 130,
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Text(": "),
          pw.Expanded(
            child: pw.Text(
              (value == null || value
                  .toString()
                  .trim()
                  .isEmpty)
                  ? "-"
                  : value.toString(),
            ),
          ),
        ],
      ),
    );
  }
}