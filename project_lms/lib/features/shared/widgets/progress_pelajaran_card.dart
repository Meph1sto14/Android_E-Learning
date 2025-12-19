import 'package:flutter/material.dart';

class ProgressPelajaranCard extends StatelessWidget {
  final dynamic item;

  const ProgressPelajaranCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: item.lesson / item.totalLesson,
              color: Colors.teal,
            ),
            const SizedBox(height: 6),
            Text(
              'Lesson ${item.lesson} of ${item.totalLesson}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
