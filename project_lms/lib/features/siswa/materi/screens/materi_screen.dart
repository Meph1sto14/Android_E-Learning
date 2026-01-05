import 'package:flutter/material.dart';
import 'materi_detail_screen.dart';

class MateriScreen extends StatelessWidget {
  final String mapel;

  const MateriScreen({super.key, required this.mapel});

  @override
  Widget build(BuildContext context) {
    // Dummy daftar materi
    final List<String> materiList = [
      'Pengenalan $mapel',
      'Konsep Dasar $mapel',
      'Latihan Soal $mapel',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Materi $mapel',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal.shade600,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: materiList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.menu_book, color: Colors.teal),
              title: Text(
                materiList[index],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MateriDetailScreen(
                      title: mapel,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
