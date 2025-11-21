import 'package:flutter/material.dart';
import 'package:le_dariel/models/acronym.dart';
import 'package:le_dariel/theme/dariel_theme.dart';
import 'package:le_dariel/views/components/category_badge.dart';

class AcronymDetailView extends StatelessWidget {
  final Acronym acronym;

  const AcronymDetailView({
    super.key,
    required this.acronym,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DARIELTheme.spacingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    acronym.letters,
                    style: DARIELTheme.titleFont(size: 32).copyWith(
                      color: DARIELTheme.accentRed,
                    ),
                  ),
                ),
                CategoryBadge(category: acronym.category),
              ],
            ),
            const SizedBox(height: DARIELTheme.spacingLarge),
            Container(
              padding: const EdgeInsets.all(DARIELTheme.spacingMedium),
              decoration: BoxDecoration(
                color: DARIELTheme.secondaryColor,
                borderRadius: BorderRadius.circular(DARIELTheme.cornerRadiusMedium),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Définition complète',
                    style: DARIELTheme.subtitleFont(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    acronym.fullForm,
                    style: DARIELTheme.bodyFont(),
                  ),
                ],
              ),
            ),
            if (acronym.examples.isNotEmpty) ...[
              const SizedBox(height: DARIELTheme.spacingLarge),
              Text(
                'Exemples',
                style: DARIELTheme.subtitleFont(),
              ),
              const SizedBox(height: DARIELTheme.spacingMedium),
              ...acronym.examples.map(
                (example) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(DARIELTheme.spacingMedium),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(DARIELTheme.cornerRadiusSmall),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    example,
                    style: DARIELTheme.bodyFont().copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

