import 'package:flutter/material.dart';
import 'package:project_lms/features/siswa/dashboard/model/jadwal_item_model.dart';

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.schedule, color: Colors.teal),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.mapel,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text('${item.mulai} - ${item.selesai}'),
            ],
          ),
        ],
      ),
    );
  }
}
