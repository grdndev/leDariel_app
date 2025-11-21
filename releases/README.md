# Fichiers de build - Releases

Ces fichiers peuvent être téléchargés directement depuis les [Releases GitHub](https://github.com/grdndev/leDariel_app/releases).

## 📦 Fichiers disponibles

### Android
- **le_dariel-android-release.apk** (45 MB)
  - Version optimisée pour Android
  - Installation : Transférer sur appareil Android et installer

### iOS  
- **le_dariel-ios-release.ipa** (à venir)
  - Version optimisée pour iOS
  - Installation : Via Xcode ou TestFlight

## 🔧 Régénérer les fichiers

Les fichiers peuvent être régénérés avec :

```bash
# APK Android
flutter build apk --release

# IPA iOS
flutter build ipa --release
```

## 📝 Note

Les fichiers de build ne sont pas dans le dépôt Git car ils sont trop volumineux (45+ MB).
Ils sont disponibles dans le dossier `releases/` ou via GitHub Releases.
