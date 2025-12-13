import 'package:flutter/material.dart';

/// =======================
/// MODEL MATA PELAJARAN
/// =======================
class MateriItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const MateriItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

/// =======================
/// CARD MATA PELAJARAN
/// =======================
class MateriCard extends StatelessWidget {
  final MateriItem item;

  const MateriCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.pushNamed(context, '/materi_detail', arguments: item.title);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(),
              const SizedBox(height: 14),
              _buildTitle(),
              const SizedBox(height: 8),
              _buildDescription(),
            ],
          ),
        ),
      ),
    );
  }

  /// =======================
  /// ICON SECTION
  /// =======================
  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: item.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(item.icon, color: item.color, size: 28),
    );
  }

  /// =======================
  /// TITLE SECTION
  /// =======================
  Widget _buildTitle() {
    return Text(
      item.title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// =======================
  /// DESCRIPTION SECTION
  /// =======================
  Widget _buildDescription() {
    return Text(
      item.description,
      style: TextStyle(fontSize: 12, color: Colors.grey.shade700, height: 1.4),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }
}
