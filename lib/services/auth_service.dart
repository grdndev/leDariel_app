import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:le_dariel/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthService() {
    _loadCurrentUser();
  }

  Future<void> signUp({
    required String email,
    required String password,
    UserType userType = UserType.utilisateur1,
  }) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      if (await _emailExists(email)) {
        throw AuthError.emailAlreadyExists;
      }

      final passwordHash = _hashPassword(password);
      final user = User(
        id: const Uuid().v4(),
        email: email,
        passwordHash: passwordHash,
        userType: userType,
        createdAt: DateTime.now(),
      );

      await _saveUser(user);
      _currentUser = user;
      _isAuthenticated = true;
      await _saveCurrentUser();
      notifyListeners();
    } catch (e) {
      _errorMessage = e is AuthError ? e.message : 'Erreur lors de l\'inscription';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      final user = await _getUser(email: email);
      if (user == null) {
        throw AuthError.userNotFound;
      }

      final passwordHash = _hashPassword(password);
      if (user.passwordHash != passwordHash) {
        throw AuthError.invalidPassword;
      }

      final updatedUser = User(
        id: user.id,
        email: user.email,
        passwordHash: user.passwordHash,
        userType: user.userType,
        createdAt: user.createdAt,
        lastLogin: DateTime.now(),
      );

      await _saveUser(updatedUser);
      _currentUser = updatedUser;
      _isAuthenticated = true;
      await _saveCurrentUser();
      notifyListeners();
    } catch (e) {
      _errorMessage = e is AuthError ? e.message : 'Erreur lors de la connexion';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _currentUser = null;
    _isAuthenticated = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
    notifyListeners();
  }

  Future<void> upgradeToPremium() async {
    if (_currentUser == null) {
      throw AuthError.notAuthenticated;
    }

    final updatedUser = User(
      id: _currentUser!.id,
      email: _currentUser!.email,
      passwordHash: _currentUser!.passwordHash,
      userType: UserType.utilisateur2,
      createdAt: _currentUser!.createdAt,
      lastLogin: _currentUser!.lastLogin,
    );

    await _saveUser(updatedUser);
    _currentUser = updatedUser;
    await _saveCurrentUser();
    notifyListeners();
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> _emailExists(String email) async {
    final users = await _loadAllUsers();
    return users.any((u) => u.email.toLowerCase() == email.toLowerCase());
  }

  Future<User?> _getUser({required String email}) async {
    final users = await _loadAllUsers();
    try {
      return users.firstWhere(
        (u) => u.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveUser(User user) async {
    final users = await _loadAllUsers();
    final index = users.indexWhere((u) => u.id == user.id);
    
    if (index != -1) {
      users[index] = user;
    } else {
      users.add(user);
    }
    
    await _saveAllUsers(users);
  }

  Future<List<User>> _loadAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('allUsers');
    if (data == null) return [];
    
    try {
      final List<dynamic> jsonList = json.decode(data);
      return jsonList.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveAllUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = users.map((u) => u.toJson()).toList();
    await prefs.setString('allUsers', json.encode(jsonList));
  }

  Future<void> _loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('currentUser');
    if (data == null) return;
    
    try {
      final json = jsonDecode(data);
      _currentUser = User.fromJson(json);
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      // Ignorer les erreurs de parsing
    }
  }

  Future<void> _saveCurrentUser() async {
    if (_currentUser == null) return;
    
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(_currentUser!.toJson());
    await prefs.setString('currentUser', json);
  }
}

class AuthError implements Exception {
  final String message;

  AuthError(this.message);

  static AuthError get emailAlreadyExists => 
      AuthError('Cet email est déjà utilisé');
  static AuthError get userNotFound => 
      AuthError('Utilisateur non trouvé');
  static AuthError get invalidPassword => 
      AuthError('Mot de passe incorrect');
  static AuthError get notAuthenticated => 
      AuthError('Vous n\'êtes pas connecté');
  static AuthError get invalidEmail => 
      AuthError('Email invalide');
}

