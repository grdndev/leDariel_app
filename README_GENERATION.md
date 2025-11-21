# 📱 Guide de Génération IPA iOS et APK Android

## État actuel

✅ **Flutter installé** (3.38.2)  
✅ **Xcode installé** (26.1.1)  
✅ **Android Studio installé**  
✅ **CocoaPods installé**  
✅ **Projet Flutter configuré**

⚠️ **À configurer** :
- iOS : Certificats de signature Apple (dans Xcode)
- Android : SDK Android (via Android Studio)

---

## 🍎 ÉTAPE 1 : Générer l'IPA iOS

### Option A : Avec signature (pour distribution)

1. **Ouvrir Xcode** (déjà ouvert automatiquement) :
   ```
   Le projet devrait être ouvert dans Xcode : ios/Runner.xcworkspace
   ```

2. **Configurer la signature** :
   - Dans Xcode, cliquer sur **"Runner"** (projet) dans le panneau de gauche
   - Sélectionner la cible **"Runner"** sous TARGETS
   - Aller dans **"Signing & Capabilities"**
   - Cocher ✅ **"Automatically manage signing"**
   - Choisir votre **Team** (votre compte Apple ID)
   - Si pas de Team : **Add Account...** → Connectez-vous avec votre Apple ID

3. **Modifier le Bundle Identifier** (si nécessaire) :
   - Changez `com.example.leDariel` en quelque chose d'unique
   - Exemple : `com.votrenom.ledariel`

4. **Générer l'IPA** :
   ```bash
   cd /Users/jayance/Desktop/Le_DARIEL
   flutter build ipa --release
   ```
   📦 Le fichier IPA sera dans : `build/ios/ipa/`

### Option B : Sans signature (pour tester uniquement)

```bash
cd /Users/jayance/Desktop/Le_DARIEL
flutter build ios --release --no-codesign
```

---

## 🤖 ÉTAPE 2 : Configurer Android et générer l'APK

### 1. Installer le SDK Android

1. **Ouvrir Android Studio** :
   ```bash
   open -a "Android Studio"
   ```

2. **Première configuration** :
   - Au premier lancement, Android Studio va vous guider
   - Cliquez sur **"Next"** → **"Next"** → **"Finish"**
   - Android Studio va télécharger et installer automatiquement :
     - Android SDK
     - Android SDK Platform
     - Android SDK Build-Tools

3. **Attendre la fin du téléchargement** (peut prendre plusieurs minutes)

4. **Vérifier l'installation** :
   ```bash
   flutter doctor
   ```
   Vous devriez voir : `[✓] Android toolchain`

### 2. Accepter les licences Android

```bash
flutter doctor --android-licenses
```
Tapez **'y'** et **Entrée** pour chaque licence (environ 5-7 licences)

### 3. Générer l'APK

```bash
cd /Users/jayance/Desktop/Le_DARIEL

# APK de debug (pour tester - plus facile, pas besoin de clé)
flutter build apk --debug
# 📦 Fichier : build/app/outputs/flutter-apk/app-debug.apk

# APK de release (pour distribution - optimisé)
flutter build apk --release
# 📦 Fichier : build/app/outputs/flutter-apk/app-release.apk

# APK split par architecture (plus petit)
flutter build apk --split-per-abi --release
# 📦 Fichiers : build/app/outputs/flutter-apk/app-*-release.apk
```

---

## 📂 Emplacement des fichiers générés

### iOS
- **IPA** : `build/ios/ipa/le_dariel.ipa`

### Android
- **APK Debug** : `build/app/outputs/flutter-apk/app-debug.apk`
- **APK Release** : `build/app/outputs/flutter-apk/app-release.apk`

---

## ✅ Vérification finale

Avant de générer, vérifiez que tout est prêt :

```bash
flutter doctor
```

Vous devriez voir :
- ✅ Flutter
- ✅ Xcode (avec CocoaPods)
- ✅ Android toolchain (après configuration)
- ✅ Chrome
- ✅ Connected device

---

## 🚀 Commandes rapides

```bash
# Se placer dans le dossier du projet
cd /Users/jayance/Desktop/Le_DARIEL

# Installer les dépendances
flutter pub get

# Vérifier la configuration
flutter doctor

# Générer IPA iOS
flutter build ipa --release

# Générer APK Android
flutter build apk --release
```

---

## ❓ Problèmes courants

### iOS : "No valid code signing certificates"
→ Ouvrez Xcode et configurez la signature (voir ÉTAPE 1)

### Android : "No Android SDK found"
→ Ouvrez Android Studio et laissez-le installer le SDK (voir ÉTAPE 2)

### "CocoaPods not installed"
→ Déjà installé, mais si problème :
```bash
sudo gem install cocoapods
```

---

## 📞 Support

Pour plus d'aide, consultez :
- Documentation Flutter : https://docs.flutter.dev
- Configuration iOS : https://docs.flutter.dev/deployment/ios
- Configuration Android : https://docs.flutter.dev/deployment/android

