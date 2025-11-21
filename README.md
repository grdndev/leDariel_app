# Le_DARIEL - Version Flutter 📱

**Le DARIEL** : Dictionnaire des Acronymes pour une Richesse de l'Interprétation et de l'Exégèse du Livre

Application mobile cross-platform développée avec Flutter pour iOS et Android.

## ✨ Fonctionnalités

- 📚 **Dictionnaire d'acronymes** : Parcourir une collection complète d'acronymes bibliques
- 🔍 **Recherche avancée** : Rechercher par lettres, forme complète ou catégorie
- 📑 **Index alphabétique** : Navigation rapide par ordre alphabétique
- 🏷️ **Catégories** : Filtrer par catégories grammaticales (nom, verbe, adjectif, etc.)
- 👤 **Authentification utilisateur** : Système de connexion et d'inscription
- 💳 **Gestion des abonnements** : Support pour différents types d'utilisateurs (Gratuit/Premium/Admin)
- ⚙️ **Interface administrateur** : Gestion des acronymes pour les administrateurs
- 🎨 **Interface moderne** : Design élégant avec thème personnalisé DARIEL

## 🚀 Installation

### Prérequis

- **Flutter SDK** : Version 3.0.0 ou supérieure
  - Installation : https://flutter.dev/docs/get-started/install
- **Dart SDK** : Inclus avec Flutter
- **Android Studio** : Pour développer sur Android (optionnel mais recommandé)
- **Xcode** : Pour développer sur iOS (macOS uniquement)
- **Un appareil ou simulateur** : Android ou iOS

### Étapes d'installation

1. **Cloner ou télécharger le projet**
   ```bash
   cd leDariel_flutter
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Vérifier la configuration**
   ```bash
   flutter doctor
   ```

4. **Lancer l'application**

   Sur Android :
   ```bash
   flutter run
   ```

   Sur iOS :
   ```bash
   flutter run -d ios
   ```

## 📦 Générer un APK (Android)

Pour générer un fichier APK que vous pouvez installer sur Android :

1. **APK de debug** (pour tester) :
   ```bash
   flutter build apk --debug
   ```
   Le fichier APK sera dans : `build/app/outputs/flutter-apk/app-debug.apk`

2. **APK de release** (pour distribution) :
   ```bash
   flutter build apk --release
   ```
   Le fichier APK sera dans : `build/app/outputs/flutter-apk/app-release.apk`

3. **APK split par architecture** (pour réduire la taille) :
   ```bash
   flutter build apk --split-per-abi
   ```
   Cela génère plusieurs APK (arm64-v8a, armeabi-v7a, x86_64)

## 🍎 Générer un build iOS

Pour générer un fichier IPA pour iOS :

1. **Ouvrir le projet iOS dans Xcode** :
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Configurer les certificats** :
   - Sélectionner votre équipe de développement
   - Configurer les certificats de signature

3. **Build IPA** :
   ```bash
   flutter build ipa
   ```
   Le fichier IPA sera dans : `build/ios/ipa/`

   Ou via Xcode :
   - Menu Product → Archive
   - Organizer → Distribute App

## 🛠️ Technologies utilisées

- **Flutter** : Framework cross-platform
- **Dart** : Langage de programmation
- **Provider** : State management
- **SharedPreferences** : Stockage local
- **Crypto** : Hachage des mots de passe

## 📁 Structure du projet

```
lib/
├── main.dart                      # Point d'entrée
├── models/                        # Modèles de données
│   ├── acronym.dart
│   ├── user.dart
│   └── subscription.dart
├── services/                      # Services métier
│   ├── auth_service.dart
│   ├── acronym_manager.dart
│   └── acronym_access_service.dart
├── theme/                         # Thème de l'application
│   └── dariel_theme.dart
└── views/                         # Vues de l'application
    ├── auth/                      # Authentification
    │   ├── login_view.dart
    │   └── signup_view.dart
    ├── main/                      # Vues principales
    │   ├── main_tab_view.dart
    │   ├── acronym_list_view.dart
    │   ├── acronym_detail_view.dart
    │   ├── alphabetical_index_view.dart
    │   └── profile_view.dart
    ├── admin/                     # Interface admin
    │   └── admin_view.dart
    └── components/                # Composants réutilisables
        ├── acronym_card.dart
        ├── category_badge.dart
        └── search_bar.dart
```

## 📱 Utilisation

1. **Créer un compte** : Inscrivez-vous avec votre email et mot de passe
2. **Explorer** : Parcourez le dictionnaire d'acronymes dans l'onglet "Dictionnaire"
3. **Rechercher** : Utilisez la barre de recherche pour trouver des acronymes spécifiques
4. **Naviguer** : Utilisez l'index alphabétique pour une navigation rapide
5. **Filtrer** : Filtrez par catégories grammaticales pour affiner vos résultats

## 🔧 Configuration

### Android

Modifier `android/app/build.gradle` pour configurer :
- Le nom de l'application
- Le package name
- La version
- Les permissions

### iOS

Modifier `ios/Runner/Info.plist` pour configurer :
- Le nom de l'application
- Le bundle identifier
- Les permissions

## 👨‍💻 Développement

**Créé par** : FRÉDÉRIC ASDRUBAL EI - MSIF-971  
**Entreprise** : Entreprise Individuelle créée le 18/07/2025  
**Date de création** : 23/07/2025

## 📄 Licence

Tous droits réservés.

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à ouvrir une issue ou à soumettre une pull request.

---

⭐ Si ce projet vous est utile, n'hésitez pas à lui donner une étoile !

