import 'package:flutter/material.dart';

class JadwalItem {
  final String mapel;
  final String hari;
  final String mulai;
  final String selesai;

  const JadwalItem({
    required this.mapel,
    required this.hari,
    required this.mulai,
    required this.selesai,
  });
}

class JadwalCard extends StatelessWidget {
  final JadwalItem item;

  const JadwalCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.mapel,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${item.hari} • ${item.mulai} - ${item.selesai}',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
