import 'package:flutter/material.dart';

class DailyHabitCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool completed;
  final VoidCallback? onTap;

  const DailyHabitCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.completed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: completed ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: completed
                ? [Colors.grey.shade300, Colors.grey.shade400]
                : const [Color(0xFF22C55E), Color(0xFF16A34A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              completed ? Icons.check_circle : Icons.self_improvement,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              completed ? 'Completed today ✅' : subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
