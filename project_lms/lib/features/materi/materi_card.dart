import 'package:flutter/material.dart';
import 'materi_detail_screen.dart';

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
    // Konversi progress dari string ke double
    final progressValue = double.tryParse(
          item.progress.replaceAll('%', ''),
        )! /
        100;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MateriDetailScreen(title: item.title),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIcon(),
              const SizedBox(height: 10),
              _buildTitle(),
              const SizedBox(height: 8),
              _buildProgressText(),
              _buildProgressBar(progressValue),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Icon Section
  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: item.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(item.icon, color: item.color, size: 30),
    );
  }

  /// 🔹 Title Section
  Widget _buildTitle() {
    return Text(
      item.title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 🔹 Progress Text
  Widget _buildProgressText() {
    return Text(
      'Progress: ${item.progress}',
      style: TextStyle(
        fontSize: 12,
        color: item.color,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// 🔹 Progress Bar
  Widget _buildProgressBar(double progressValue) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: LinearProgressIndicator(
        value: progressValue,
        backgroundColor: item.color.withOpacity(0.3),
        color: item.color,
        minHeight: 8,
      ),
    );
  }
}
