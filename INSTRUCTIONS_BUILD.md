# Instructions pour générer APK et IPA

## 📦 Générer un APK (Android)

### Prérequis
- Flutter installé et configuré
- Android Studio installé (ou Android SDK)
- Clé de signature configurée (pour release)

### Étapes

1. **Vérifier que tout est prêt** :
   ```bash
   flutter doctor
   ```

2. **Générer l'APK de debug** (pour tester) :
   ```bash
   flutter build apk --debug
   ```
   - Fichier généré : `build/app/outputs/flutter-apk/app-debug.apk`
   - Taille : ~50-80 MB
   - Pas de signature requise

3. **Générer l'APK de release** (pour distribution) :
   ```bash
   flutter build apk --release
   ```
   - Fichier généré : `build/app/outputs/flutter-apk/app-release.apk`
   - Taille : ~20-30 MB (optimisé)
   - Signature requise

4. **Générer des APK séparés par architecture** (recommandé) :
   ```bash
   flutter build apk --split-per-abi --release
   ```
   - Génère 3 fichiers :
     - `app-armeabi-v7a-release.apk` (~10 MB)
     - `app-arm64-v8a-release.apk` (~12 MB)
     - `app-x86_64-release.apk` (~12 MB)
   - Chaque APK contient seulement l'architecture ciblée

5. **Installer l'APK sur un appareil** :
   ```bash
   flutter install
   ```
   Ou copier manuellement le fichier APK sur l'appareil et l'installer.

### Configuration de la signature (Release)

1. Créer une clé de signature :
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. Créer le fichier `android/key.properties` :
   ```
   storePassword=<mot de passe>
   keyPassword=<mot de passe>
   keyAlias=upload
   storeFile=<chemin vers le fichier .jks>
   ```

3. Modifier `android/app/build.gradle` pour utiliser la clé.

## 🍎 Générer un build iOS (IPA)

### Prérequis
- macOS avec Xcode installé
- Compte développeur Apple
- Certificats et profils de provisionnement configurés

### Étapes

1. **Ouvrir le projet iOS** :
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Configurer dans Xcode** :
   - Sélectionner votre équipe de développement
   - Vérifier le Bundle Identifier
   - Configurer les certificats (Automatic Signing recommandé)

3. **Générer l'IPA via Flutter** :
   ```bash
   flutter build ipa
   ```
   - Fichier généré : `build/ios/ipa/le_dariel.ipa`
   - Prêt pour TestFlight ou App Store

4. **Générer l'IPA via Xcode** (méthode alternative) :
   - Menu **Product** → **Archive**
   - Attendre la fin de l'archivage
   - Dans **Organizer** :
     - Sélectionner l'archive
     - Cliquer sur **Distribute App**
     - Choisir la méthode de distribution :
       - **App Store Connect** : Pour publier sur l'App Store
       - **Ad Hoc** : Pour installation directe sur appareils enregistrés
       - **Enterprise** : Pour distribution interne (nécessite compte Enterprise)
       - **Development** : Pour installation via Xcode

### Via la ligne de commande (automatisé)

```bash
# Build pour iOS
flutter build ios --release

# Générer l'IPA
flutter build ipa --release
```

## 📂 Emplacement des fichiers générés

### Android
- **Debug APK** : `build/app/outputs/flutter-apk/app-debug.apk`
- **Release APK** : `build/app/outputs/flutter-apk/app-release.apk`
- **Split APK** : `build/app/outputs/flutter-apk/`

### iOS
- **IPA** : `build/ios/ipa/le_dariel.ipa`
- **Archive** : `~/Library/Developer/Xcode/Archives/`

## 🚀 Distribution

### Android (APK)
1. **Google Play Store** :
   - Créer un compte développeur
   - Créer une application dans la Console Play
   - Uploader le fichier APK signé

2. **Distribution directe** :
   - Partager le fichier APK
   - Les utilisateurs doivent autoriser l'installation depuis des sources inconnues

### iOS (IPA)
1. **App Store** :
   - Utiliser App Store Connect
   - Uploader l'IPA via Xcode ou Transporter

2. **TestFlight** :
   - Uploader l'IPA dans App Store Connect
   - Inviter des testeurs

3. **Distribution Ad Hoc** :
   - Inclure les UDID des appareils dans le profil de provisionnement
   - Distribuer l'IPA aux utilisateurs

## ⚠️ Notes importantes

- Les builds de **debug** sont plus volumineux et non optimisés
- Les builds de **release** sont optimisés et prêts pour la production
- Pour iOS, un compte développeur Apple payant est requis ($99/an)
- Pour Android, l'inscription sur Google Play coûte $25 (paiement unique)
- Toujours tester les builds de release avant de les distribuer

## 🔧 Dépannage

### Erreur de signature Android
```bash
# Vérifier la clé
keytool -list -v -keystore ~/upload-keystore.jks
```

### Erreur de certificat iOS
- Vérifier dans Xcode : Settings → Accounts → Votre compte → Certificates
- Régénérer les certificats si nécessaire

### Problèmes de build
```bash
# Nettoyer le projet
flutter clean
flutter pub get

# Vérifier les problèmes
flutter analyze
```

