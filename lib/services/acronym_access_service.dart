import 'package:le_dariel/models/acronym.dart';
import 'package:le_dariel/services/auth_service.dart';
import 'package:le_dariel/services/acronym_manager.dart';

class AcronymAccessService {
  final AuthService authService;
  final AcronymManager acronymManager;

  AcronymAccessService({
    required this.authService,
    required this.acronymManager,
  });

  List<Acronym> getAccessibleAcronyms() {
    final user = authService.currentUser;
    if (user == null) return [];

    if (user.canAccessAllAcronyms) {
      return acronymManager.acronyms;
    } else {
      // Utilisateur gratuit : limiter à 20 acronymes
      return acronymManager.acronyms.take(20).toList();
    }
  }

  bool canAccessAcronym(Acronym acronym) {
    final user = authService.currentUser;
    if (user == null) return false;

    if (user.canAccessAllAcronyms) {
      return true;
    } else {
      final accessibleAcronyms = getAccessibleAcronyms();
      return accessibleAcronyms.any((a) => a.id == acronym.id);
    }
  }

  int getLockedAcronymsCount() {
    final user = authService.currentUser;
    if (user == null) return acronymManager.acronyms.length;

    if (user.canAccessAllAcronyms) {
      return 0;
    } else {
      return (acronymManager.acronyms.length - 20).clamp(0, double.maxFinite.toInt());
    }
  }

  List<Acronym> searchAccessibleAcronyms(String query) {
    final accessibleAcronyms = getAccessibleAcronyms();

    if (query.isEmpty) {
      return accessibleAcronyms;
    }

    final lowerQuery = query.toLowerCase();
    return accessibleAcronyms.where((acronym) {
      return acronym.letters.toLowerCase().contains(lowerQuery) ||
          acronym.fullForm.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  List<String> getSuggestions(String query) {
    final accessibleAcronyms = getAccessibleAcronyms();
    final lowerQuery = query.toLowerCase();
    
    final matchingAcronyms = accessibleAcronyms.where((acronym) {
      return acronym.letters.toLowerCase().contains(lowerQuery);
    }).toList();
    
    return matchingAcronyms.map((a) => a.letters).toList();
  }
}

