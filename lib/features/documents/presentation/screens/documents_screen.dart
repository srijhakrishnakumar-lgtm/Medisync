import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary sample data
    final List<Map<String, String>> documents = [
      {
        'title': 'Blood Test Report',
        'date': '12 Jun 2026',
        'category': 'Lab Report',
      },
      {
        'title': 'COVID-19 Vaccination',
        'date': '20 May 2026',
        'category': 'Vaccination',
      },
      {
        'title': 'Prescription',
        'date': '08 Apr 2026',
        'category': 'Medication',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Documents'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Document upload will be added soon.'),
            ),
          );
        },
        child: const Icon(Icons.upload_file),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search documents...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: documents.isEmpty
                  ? const _EmptyDocuments()
                  : ListView.separated(
                itemCount: documents.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final document = documents[index];

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                        AppColors.primary.withValues(alpha: 0.15),
                        child: const Icon(
                          Icons.description,
                          color: AppColors.primary,
                        ),
                      ),
                      title: Text(document['title']!),
                      subtitle: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(document['category']!),
                          Text(document['date']!),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyDocuments extends StatelessWidget {
  const _EmptyDocuments();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 90,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          const Text(
            'No Documents Yet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Upload your first medical document\nand access it anytime.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}