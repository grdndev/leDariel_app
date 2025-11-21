import 'package:flutter/material.dart';
import 'package:le_dariel/models/acronym.dart';
import 'package:le_dariel/theme/dariel_theme.dart';
import 'package:le_dariel/views/components/category_badge.dart';

class AcronymCard extends StatelessWidget {
  final Acronym acronym;
  final VoidCallback onTap;

  const AcronymCard({
    super.key,
    required this.acronym,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DARIELTheme.cornerRadiusMedium),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DARIELTheme.cornerRadiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(DARIELTheme.spacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      acronym.letters,
                      style: DARIELTheme.titleFont(size: 24).copyWith(
                        color: DARIELTheme.accentRed,
                      ),
                    ),
                  ),
                  CategoryBadge(category: acronym.category),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                acronym.fullForm,
                style: DARIELTheme.bodyFont(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (acronym.examples.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  acronym.examples.first,
                  style: DARIELTheme.captionFont().copyWith(
                    fontStyle: FontStyle.italic,
                    color: DARIELTheme.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

