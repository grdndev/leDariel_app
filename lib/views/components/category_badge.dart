import 'package:flutter/material.dart';
import 'package:le_dariel/models/acronym.dart';

class CategoryBadge extends StatelessWidget {
  final AcronymCategory category;

  const CategoryBadge({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Text(
        category.label,
        style: TextStyle(
          fontSize: 10,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

