# Le_DARIEL 📖

**Le DARIEL** : Dictionnaire des Acronymes pour une Richesse de l'Interprétation et de l'Exégèse du Livre

Application iOS native développée avec SwiftUI pour consulter et explorer un dictionnaire d'acronymes bibliques.

## 📱 À propos

Le_DARIEL est une application mobile iOS qui permet aux utilisateurs d'explorer et de rechercher des acronymes bibliques avec leurs définitions complètes, exemples et catégories. L'application propose une interface moderne et intuitive pour naviguer dans ce dictionnaire spécialisé.

🔗 **Site web du DARIEL** : [https://darieleditions.notion.site/Les-acronymes-du-Dariel-9b1db9b794ee4fb3b2e22613ad4c5789](https://darieleditions.notion.site/Les-acronymes-du-Dariel-9b1db9b794ee4fb3b2e22613ad4c5789)

## ✨ Fonctionnalités

- 📚 **Dictionnaire d'acronymes** : Parcourir une collection complète d'acronymes bibliques
- 🔍 **Recherche avancée** : Rechercher par lettres, forme complète ou catégorie
- 📑 **Index alphabétique** : Navigation rapide par ordre alphabétique
- 🏷️ **Catégories** : Filtrer par catégories grammaticales (nom, verbe, adjectif, etc.)
- 👤 **Authentification utilisateur** : Système de connexion et d'inscription
- 💳 **Gestion des abonnements** : Support pour différents types d'utilisateurs
- ⚙️ **Interface administrateur** : Gestion des acronymes pour les administrateurs
- 🎨 **Interface moderne** : Design élégant avec thème personnalisé

## 🛠️ Technologies

- **SwiftUI** : Framework d'interface utilisateur
- **Swift** : Langage de programmation
- **iOS 16.2+** : Version minimale supportée
- **Xcode** : Environnement de développement

## 📁 Structure du projet

```
Le_DARIEL/
├── Models/
│   ├── Acronym.swift          # Modèle de données pour les acronymes
│   ├── User.swift             # Modèle utilisateur
│   └── Subscription.swift     # Modèle d'abonnement
├── Views/
│   ├── Main/
│   │   ├── MainTabView.swift          # Vue principale avec onglets
│   │   ├── AcronymListView.swift      # Liste des acronymes
│   │   ├── AcronymDetailView.swift    # Détail d'un acronyme
│   │   ├── AlphabeticalIndexView.swift # Index alphabétique
│   │   └── ProfileView.swift          # Profil utilisateur
│   ├── Auth/
│   │   ├── LoginView.swift    # Connexion
│   │   └── SignUpView.swift   # Inscription
│   ├── Admin/
│   │   └── AdminView.swift    # Interface administrateur
│   └── Components/
│       ├── AcronymCardDARIEL.swift    # Carte d'acronyme
│       ├── CategoryBadge.swift        # Badge de catégorie
│       ├── SearchBar.swift            # Barre de recherche
│       └── SearchBarWithSuggestions.swift # Recherche avec suggestions
├── Services/
│   ├── AuthService.swift              # Service d'authentification
│   └── AcronymAccessService.swift     # Service d'accès aux acronymes
├── Theme/
│   └── DARIELTheme.swift      # Thème de l'application
├── AcronymManager.swift       # Gestionnaire d'acronymes
└── Le_DARIELApp.swift         # Point d'entrée de l'application
```

## 🚀 Installation

### Prérequis

- macOS avec Xcode 14.0 ou supérieur
- iOS 16.2 ou supérieur pour l'exécution sur appareil
- Compte développeur Apple (pour tester sur appareil)

### Étapes d'installation

1. **Cloner le dépôt**
   ```bash
   git clone https://github.com/grdndev/leDariel_app.git
   cd leDariel_app
   ```

2. **Ouvrir le projet**
   ```bash
   open Le_DARIEL.xcodeproj
   ```

3. **Configurer le projet**
   - Sélectionner votre équipe de développement dans les paramètres du projet
   - Choisir un bundle identifier unique
   - Configurer les certificats de signature si nécessaire

4. **Construire et exécuter**
   - Sélectionner un simulateur ou un appareil
   - Appuyer sur `Cmd + R` ou cliquer sur le bouton Play

## 📱 Utilisation

1. **Créer un compte** : Inscrivez-vous avec votre email et mot de passe
2. **Explorer** : Parcourez le dictionnaire d'acronymes dans l'onglet "Dictionnaire"
3. **Rechercher** : Utilisez la barre de recherche pour trouver des acronymes spécifiques
4. **Naviguer** : Utilisez l'index alphabétique pour une navigation rapide
5. **Filtrer** : Filtrez par catégories grammaticales pour affiner vos résultats

## 🎯 Fonctionnalités à venir

- 📲 **Notifications quotidiennes** : Recevoir un acronyme aléatoire par jour
- 💾 **Synchronisation cloud** : Sauvegarder vos favoris et préférences
- 🌐 **Mode hors ligne** : Accès aux acronymes sans connexion internet

## 👨‍💻 Développement

**Créé par** : FRÉDÉRIC ASDRUBAL EI - MSIF-971  
**Entreprise** : Entreprise Individuelle créée le 18/07/2025  
**Date de création** : 23/07/2025

## 📄 Licence

Tous droits réservés.

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à ouvrir une issue ou à soumettre une pull request.

## 📞 Contact

Pour toute question ou suggestion, veuillez ouvrir une issue sur le dépôt GitHub.

---

⭐ Si ce projet vous est utile, n'hésitez pas à lui donner une étoile !

