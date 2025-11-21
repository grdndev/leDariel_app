enum UserType {
  utilisateur1('u1', 'Utilisateur Gratuit'),
  utilisateur2('u2', 'Utilisateur Premium'),
  administrateur('admin', 'Administrateur');

  final String value;
  final String label;
  const UserType(this.value, this.label);
}

class User {
  final String id;
  final String email;
  final String passwordHash;
  final UserType userType;
  final DateTime createdAt;
  final DateTime? lastLogin;

  User({
    required this.id,
    required this.email,
    required this.passwordHash,
    required this.userType,
    required this.createdAt,
    this.lastLogin,
  });

  bool get canAccessAllAcronyms {
    return userType == UserType.utilisateur2 || userType == UserType.administrateur;
  }

  int get maxAcronymsAllowed {
    switch (userType) {
      case UserType.utilisateur1:
        return 20;
      case UserType.utilisateur2:
      case UserType.administrateur:
        return double.maxFinite.toInt();
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'email': email,
      'passwordHash': passwordHash,
      'userType': userType.value,
      'createdAt': createdAt.toIso8601String(),
    };
    if (lastLogin != null) {
      map['lastLogin'] = lastLogin!.toIso8601String();
    }
    return map;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        email: json['email'] as String,
        passwordHash: json['passwordHash'] as String,
        userType: UserType.values.firstWhere(
          (t) => t.value == json['userType'],
          orElse: () => UserType.utilisateur1,
        ),
        createdAt: DateTime.parse(json['createdAt'] as String),
        lastLogin: json['lastLogin'] != null
            ? DateTime.parse(json['lastLogin'] as String)
            : null,
      );
}

