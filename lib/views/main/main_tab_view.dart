import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:le_dariel/services/auth_service.dart';
import 'package:le_dariel/services/acronym_manager.dart';
import 'package:le_dariel/services/acronym_access_service.dart';
import 'package:le_dariel/views/main/acronym_list_view.dart';
import 'package:le_dariel/views/main/alphabetical_index_view.dart';
import 'package:le_dariel/views/main/profile_view.dart';
import 'package:le_dariel/views/admin/admin_view.dart';
import 'package:le_dariel/models/user.dart';
import 'package:le_dariel/services/acronym_access_service.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final acronymManager = Provider.of<AcronymManager>(context);
    final accessService = Provider.of<AcronymAccessService>(context);
    final isAdmin = authService.currentUser?.userType == UserType.administrateur;

    final tabs = <Widget>[
      AcronymListView(
        accessService: accessService,
        acronymManager: acronymManager,
      ),
      AlphabeticalIndexView(accessService: accessService),
      ProfileView(
        authService: authService,
        accessService: accessService,
      ),
    ];

    if (isAdmin) {
      tabs.add(AdminView(
        authService: authService,
        acronymManager: acronymManager,
      ));
    }

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: tabs,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Dictionnaire',
          ),
          const NavigationDestination(
            icon: Icon(Icons.list_outlined),
            selectedIcon: Icon(Icons.list),
            label: 'Index',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
          if (isAdmin)
            const NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Admin',
            ),
        ],
      ),
    );
  }
}

