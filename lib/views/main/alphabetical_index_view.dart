import 'package:flutter/material.dart';
import 'package:le_dariel/services/acronym_access_service.dart';
import 'package:le_dariel/views/components/acronym_card.dart';
import 'package:le_dariel/views/main/acronym_detail_view.dart';
import 'package:le_dariel/models/acronym.dart';

class AlphabeticalIndexView extends StatelessWidget {
  final AcronymAccessService accessService;

  const AlphabeticalIndexView({
    super.key,
    required this.accessService,
  });

  Map<String, List<Acronym>> _groupByLetter() {
    final acronyms = accessService.getAccessibleAcronyms();
    final grouped = <String, List<Acronym>>{};
    
    for (final acronym in acronyms) {
      final firstLetter = acronym.letters.isNotEmpty 
          ? acronym.letters[0].toUpperCase() 
          : '#';
      grouped.putIfAbsent(firstLetter, () => []).add(acronym);
    }
    
    // Trier les lettres et les acronymes dans chaque groupe
    final sortedGroups = <String, List<Acronym>>{};
    final sortedKeys = grouped.keys.toList()..sort();
    
    for (final key in sortedKeys) {
      final items = grouped[key]!..sort((a, b) => a.letters.compareTo(b.letters));
      sortedGroups[key] = items;
    }
    
    return sortedGroups;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByLetter();
    final letters = grouped.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Index Alphabétique'),
      ),
      body: letters.isEmpty
          ? const Center(
              child: Text('Aucun acronyme disponible'),
            )
          : ListView.builder(
              itemCount: letters.length,
              itemBuilder: (context, index) {
                final letter = letters[index];
                final acronyms = grouped[letter]!;
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.grey.shade200,
                      width: double.infinity,
                      child: Text(
                        letter,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...acronyms.map(
                      (acronym) => AcronymCard(
                        acronym: acronym,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AcronymDetailView(
                                acronym: acronym,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

