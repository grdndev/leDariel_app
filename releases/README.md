# 📱 Fichiers de Build iOS - Le_DARIEL

⚠️ **Important** : Ce projet est une application **iOS/SwiftUI**, pas Android.  
**Un fichier APK ne peut pas être créé** car :
- **APK** = Android Package Kit (format Android)
- **Ce projet** = Application iOS/SwiftUI (format iOS)

## 📦 Fichiers disponibles

### 1. `Le_DARIEL.xcarchive`
- **Type** : Archive Xcode
- **Format** : iOS Archive (.xcarchive)
- **Usage** : Archive complète de l'application pour distribution via App Store ou TestFlight
- **Installation** : Nécessite Xcode et un compte développeur Apple

### 2. `Le_DARIEL.app`
- **Type** : Application iOS (Simulateur)
- **Format** : iOS App Bundle (.app)
- **Usage** : Version compilée pour simulateur iOS
- **Installation** : Peut être installée sur un simulateur iOS via Xcode
- **Plateforme** : iPhone Simulator (pas pour appareils réels)

## 🚀 Installation

### Option 1 : Via Xcode (Recommandé)
1. Ouvrir le projet dans Xcode
2. Sélectionner un simulateur iOS
3. Appuyer sur `Cmd + R` pour lancer l'application

### Option 2 : Pour distribution sur appareil réel
1. Ouvrir Xcode
2. Menu **Product** → **Archive**
3. Exporter l'archive pour :
   - **App Store Connect** (pour TestFlight/App Store)
   - **Ad Hoc** (pour installation directe sur appareils enregistrés)
   - **Development** (pour installation via Xcode)

## 📲 Pour créer un APK Android

Si vous souhaitez vraiment un fichier APK, il faudrait :
1. **Recréer l'application** en :
   - **Flutter** (framework cross-platform)
   - **Kotlin/Java** (Android natif)
   - **React Native** (framework cross-platform)

2. **Ou migrer** le code Swift vers Swift pour Android (expérimental)

## 📋 Informations techniques

- **Plateforme** : iOS 16.2+
- **Framework** : SwiftUI
- **Langage** : Swift 5.0
- **SDK** : iOS SDK

---

**Note** : Ces fichiers sont des builds iOS et ne fonctionneront pas sur Android. Pour Android, une version séparée de l'application serait nécessaire.

