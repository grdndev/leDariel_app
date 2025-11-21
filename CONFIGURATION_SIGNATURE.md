# Configuration de la signature iOS et Android

## 🍎 iOS - Configuration de la signature

### Pour générer l'IPA iOS, vous devez configurer les certificats :

1. **Ouvrir le projet Xcode** (déjà ouvert automatiquement)
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Dans Xcode** :
   - Sélectionner le projet "Runner" dans le navigateur de gauche
   - Sélectionner la cible "Runner" sous "TARGETS"
   - Aller dans l'onglet **"Signing & Capabilities"**
   - Cocher **"Automatically manage signing"**
   - Sélectionner votre **"Team"** (votre compte Apple ID)
   - Si vous n'avez pas de Team, cliquer sur **"Add Account..."** et vous connecter avec votre Apple ID

3. **Changer le Bundle Identifier** si nécessaire :
   - Dans "Signing & Capabilities", modifier le Bundle Identifier pour qu'il soit unique
   - Exemple : `com.votrenom.ledariel` au lieu de `com.example.leDariel`

4. **Générer l'IPA** :
   ```bash
   flutter build ipa --release
   ```
   Le fichier IPA sera dans : `build/ios/ipa/`

### Alternative : Build sans signature (pour tester uniquement)
```bash
flutter build ios --release --no-codesign
```

## 🤖 Android - Installation du SDK

### Étapes pour installer le SDK Android :

1. **Lancer Android Studio** (déjà installé)
   ```bash
   open -a "Android Studio"
   ```

2. **Première configuration** :
   - Au premier lancement, Android Studio va installer automatiquement :
     - Android SDK
     - Android SDK Platform-Tools
     - Android SDK Build-Tools
   - Accepter les licences quand demandé

3. **Vérifier l'installation** :
   ```bash
   flutter doctor
   ```
   Le Android toolchain devrait maintenant être configuré ✓

4. **Accepter les licences Android** :
   ```bash
   flutter doctor --android-licenses
   ```
   Accepter toutes les licences (taper 'y' pour chaque)

5. **Générer l'APK** :
   ```bash
   # APK de debug (pour tester)
   flutter build apk --debug
   
   # APK de release (pour distribution)
   flutter build apk --release
   ```
   Le fichier APK sera dans : `build/app/outputs/flutter-apk/`

## 📝 Notes importantes

- **iOS** : Pour distribuer sur l'App Store, vous aurez besoin d'un compte développeur Apple ($99/an)
- **Android** : Pour publier sur Google Play, vous aurez besoin d'un compte développeur Google ($25, paiement unique)
- **Debug vs Release** :
  - Debug : Plus volumineux, non optimisé, facile à installer
  - Release : Optimisé, plus petit, nécessite une signature appropriée

## 🚀 Génération rapide

Une fois tout configuré :

```bash
# IPA iOS
flutter build ipa --release

# APK Android  
flutter build apk --release
```

