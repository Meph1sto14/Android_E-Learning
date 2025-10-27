import 'package:flutter/material.dart';
import 'materi_detail_screen.dart'; // 

class MateriItem {
  final String title;
  final String progress;
  final IconData icon;
  final Color color;

  const MateriItem({
    required this.title,
    required this.progress,
    required this.icon,
    required this.color,
  });
}

class MateriCard extends StatelessWidget {
  final MateriItem item;

  const MateriCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    double progressValue = double.tryParse(item.progress.replaceAll('%', ''))! / 100;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: InkWell(
        // ✅ Aksi ketika kartu diklik
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MateriDetailScreen(title: item.title),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item.icon, color: item.color, size: 30),
              ),
              const SizedBox(height: 10),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                'Progress: ${item.progress}',
                style: TextStyle(
                  fontSize: 12,
                  color: item.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: item.color.withOpacity(0.3),
                  color: item.color,
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
