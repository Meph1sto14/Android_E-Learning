import 'package:flutter/material.dart';
import 'package:project_lms/features/siswa/materi/model/materi_item_model.dart';

class MateriCard extends StatelessWidget {
  final MateriItem item;

  const MateriCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: item.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: item.color, size: 32),
          const SizedBox(height: 12),
          Text(
            item.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.description,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
