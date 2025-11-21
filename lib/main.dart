import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:le_dariel/services/auth_service.dart';
import 'package:le_dariel/services/acronym_manager.dart';
import 'package:le_dariel/services/acronym_access_service.dart';
import 'package:le_dariel/theme/dariel_theme.dart';
import 'package:le_dariel/views/auth/login_view.dart';
import 'package:le_dariel/views/main/main_tab_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialiser les services
    final authService = AuthService();
    final acronymManager = AcronymManager();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authService),
        ChangeNotifierProvider.value(value: acronymManager),
        ProxyProvider2<AuthService, AcronymManager, AcronymAccessService>(
          update: (context, auth, manager, previous) =>
              previous ?? AcronymAccessService(
                authService: auth,
                acronymManager: manager,
              ),
        ),
      ],
      child: MaterialApp(
        title: 'Le DARIEL',
        debugShowCheckedModeBanner: false,
        theme: DARIELTheme.lightTheme,
        home: Consumer<AuthService>(
          builder: (context, authService, child) {
            if (authService.isAuthenticated) {
              return const MainTabView();
            } else {
              return const LoginView();
            }
          },
        ),
      ),
    );
  }
}

