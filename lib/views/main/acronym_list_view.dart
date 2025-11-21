import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:le_dariel/models/acronym.dart';
import 'package:le_dariel/services/acronym_manager.dart';
import 'package:le_dariel/services/acronym_access_service.dart';
import 'package:le_dariel/views/components/acronym_card.dart';
import 'package:le_dariel/views/components/search_bar.dart';
import 'package:le_dariel/theme/dariel_theme.dart';
import 'package:le_dariel/views/main/acronym_detail_view.dart';

class AcronymListView extends StatefulWidget {
  final AcronymAccessService accessService;
  final AcronymManager acronymManager;

  const AcronymListView({
    super.key,
    required this.accessService,
    required this.acronymManager,
  });

  @override
  State<AcronymListView> createState() => _AcronymListViewState();
}

class _AcronymListViewState extends State<AcronymListView> {
  String _searchQuery = '';
  TriAcronyme _selectedTri = TriAcronyme.aucun;

  List<Acronym> get _filteredAcronyms {
    var acronyms = widget.accessService.searchAccessibleAcronyms(_searchQuery);
    
    // Appliquer le tri
    switch (_selectedTri) {
      case TriAcronyme.alphabetique:
        acronyms.sort((a, b) => a.letters.compareTo(b.letters));
        break;
      case TriAcronyme.categorie:
        acronyms.sort((a, b) => a.category.label.compareTo(b.category.label));
        break;
      case TriAcronyme.aucun:
        break;
    }
    
    return acronyms;
  }

  @override
  Widget build(BuildContext context) {
    final lockedCount = widget.accessService.getLockedAcronymsCount();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionnaire DARIEL'),
        actions: [
          PopupMenuButton<TriAcronyme>(
            icon: const Icon(Icons.sort),
            onSelected: (TriAcronyme tri) {
              setState(() {
                _selectedTri = tri;
              });
              widget.acronymManager.trierAcronymes(tri);
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: TriAcronyme.aucun,
                child: Text('Aucun tri'),
              ),
              const PopupMenuItem(
                value: TriAcronyme.alphabetique,
                child: Text('Alphabétique'),
              ),
              const PopupMenuItem(
                value: TriAcronyme.categorie,
                child: Text('Par catégorie'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(DARIELTheme.spacingMedium),
            child: SearchBar(
              onSearchChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          if (lockedCount > 0)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.lock, color: Colors.orange.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '$lockedCount acronymes verrouillés. Passez à Premium pour y accéder !',
                      style: TextStyle(color: Colors.orange.shade900),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _filteredAcronyms.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty
                              ? 'Aucun acronyme disponible'
                              : 'Aucun résultat pour "$_searchQuery"',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(DARIELTheme.spacingMedium),
                    itemCount: _filteredAcronyms.length,
                    itemBuilder: (context, index) {
                      final acronym = _filteredAcronyms[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AcronymCard(
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

