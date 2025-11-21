enum SubscriptionType {
  monthly('monthly', 'Mensuel'),
  yearly('yearly', 'Annuel'),
  lifetime('lifetime', 'À vie');

  final String value;
  final String label;
  const SubscriptionType(this.value, this.label);
}

enum DonationStatus {
  pending('pending', 'En attente'),
  completed('completed', 'Terminée'),
  failed('failed', 'Échouée');

  final String value;
  final String label;
  const DonationStatus(this.value, this.label);
}

enum ReportStatus {
  pending('pending', 'En attente'),
  resolved('resolved', 'Résolu'),
  dismissed('dismissed', 'Rejeté');

  final String value;
  final String label;
  const ReportStatus(this.value, this.label);
}

enum SuggestionStatus {
  pending('pending', 'En attente'),
  approved('approved', 'Approuvée'),
  rejected('rejected', 'Rejetée');

  final String value;
  final String label;
  const SuggestionStatus(this.value, this.label);
}

class Subscription {
  final String id;
  final String userId;
  final bool isActive;
  final DateTime startDate;
  final DateTime? endDate;
  final SubscriptionType subscriptionType;

  Subscription({
    required this.id,
    required this.userId,
    required this.isActive,
    required this.startDate,
    this.endDate,
    required this.subscriptionType,
  });

  bool get isExpired {
    if (endDate == null) return false; // Lifetime subscription
    return DateTime.now().isAfter(endDate!);
  }
}

class Donation {
  final String id;
  final String userId;
  final double amount;
  final DateTime date;
  final DonationStatus status;

  Donation({
    required this.id,
    required this.userId,
    required this.amount,
    required this.date,
    required this.status,
  });
}

class BugReport {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime date;
  final ReportStatus status;

  BugReport({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });
}

class AcronymSuggestion {
  final String id;
  final String userId;
  final String acronym;
  final String? description;
  final DateTime date;
  final SuggestionStatus status;

  AcronymSuggestion({
    required this.id,
    required this.userId,
    required this.acronym,
    this.description,
    required this.date,
    required this.status,
  });
}

