import 'package:flutter/material.dart';
import 'package:le_dariel/services/auth_service.dart';
import 'package:le_dariel/services/acronym_manager.dart';
import 'package:le_dariel/theme/dariel_theme.dart';

class AdminView extends StatelessWidget {
  final AuthService authService;
  final AcronymManager acronymManager;

  const AdminView({
    super.key,
    required this.authService,
    required this.acronymManager,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administration'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(DARIELTheme.spacingLarge),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Nombre d\'acronymes'),
              subtitle: Text('${acronymManager.acronyms.length} acronymes'),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Utilisateur actuel'),
              subtitle: Text(authService.currentUser?.email ?? 'Non connecté'),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Actions',
                    style: DARIELTheme.subtitleFont(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implémenter l'ajout d'acronyme
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fonctionnalité à venir'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Ajouter un acronyme'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

