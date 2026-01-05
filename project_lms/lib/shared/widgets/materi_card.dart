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
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 🔥 PENTING: Supaya area kosong juga bisa diklik
      onTap: () {
        print('╔════════════════════════════════════════╗');
        print('║  CARD DIKLIK: ${item.title}');
        print('╚════════════════════════════════════════╝');
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Card ${item.title} diklik!'),
            duration: const Duration(seconds: 1),
          ),
        );
        
        Navigator.pushNamed(
          context,
          '/materi_detail',
          arguments: item.title,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                item.icon,
                size: 36,
                color: item.color,
              ),
            ),
            const Spacer(),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.description,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}