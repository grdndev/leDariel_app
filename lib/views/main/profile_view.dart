import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:le_dariel/services/auth_service.dart';
import 'package:le_dariel/services/acronym_access_service.dart';
import 'package:le_dariel/theme/dariel_theme.dart';
import 'package:le_dariel/models/user.dart';

class ProfileView extends StatelessWidget {
  final AuthService authService;
  final AcronymAccessService accessService;

  const ProfileView({
    super.key,
    required this.authService,
    required this.accessService,
  });

  Future<void> _upgradeToPremium(BuildContext context) async {
    try {
      await authService.upgradeToPremium();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passage à Premium réussi !'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur : ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await authService.signOut();
    // Navigation sera gérée par MainTabView
  }

  @override
  Widget build(BuildContext context) {
    final user = authService.currentUser;
    if (user == null) {
      return const Center(child: Text('Non connecté'));
    }

    final accessibleCount = accessService.getAccessibleAcronyms().length;
    final lockedCount = accessService.getLockedAcronymsCount();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DARIELTheme.spacingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(DARIELTheme.spacingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informations',
                      style: DARIELTheme.subtitleFont(),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(user.email),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Type de compte'),
                      subtitle: Text(user.userType.label),
                    ),
                    ListTile(
                      leading: const Icon(Icons.book),
                      title: const Text('Acronymes accessibles'),
                      subtitle: Text(
                        user.canAccessAllAcronyms
                            ? 'Illimité'
                            : '$accessibleCount / ${accessibleCount + lockedCount}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: DARIELTheme.spacingLarge),
            if (!user.canAccessAllAcronyms)
              Card(
                color: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(DARIELTheme.spacingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Passer à Premium',
                        style: DARIELTheme.subtitleFont(),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Débloquez tous les acronymes avec un abonnement Premium !',
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _upgradeToPremium(context),
                          child: const Text('Passer à Premium'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: DARIELTheme.spacingLarge),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _signOut(context),
                icon: const Icon(Icons.logout),
                label: const Text('Se déconnecter'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

