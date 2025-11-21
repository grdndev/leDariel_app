import 'package:flutter/material.dart';
import 'package:le_dariel/theme/dariel_theme.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSearchChanged;
  final String? hintText;

  const SearchBar({
    super.key,
    required this.onSearchChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        hintText: hintText ?? 'Rechercher un acronyme...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            // Reset search - would need a controller for this
            onSearchChanged('');
          },
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DARIELTheme.cornerRadiusSmall),
        ),
      ),
    );
  }
}

