import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../services/pdf_service.dart';

class HealthPassportScreen extends StatelessWidget {
  const HealthPassportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Passport"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: PdfPreview(
        build: (format) async {
          return await PdfService().generateHealthPassport();
        },

        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,

        allowPrinting: true,
        allowSharing: true,

        pdfFileName: "MediSync_Health_Passport.pdf",

        loadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}