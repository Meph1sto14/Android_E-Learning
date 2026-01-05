import 'package:flutter/material.dart';
import 'materi_screen.dart';

class MapelScreen extends StatelessWidget {
  const MapelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mapelList = [
      'Matematika',
      'Bahasa Indonesia',
      'Pendidikan Pancasila',
      'Ilmu Pengetahuan Alam',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Mata Pelajaran',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal.shade600,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mapelList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MateriScreen(
                    mapel: mapelList[index],
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                mapelList[index],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
