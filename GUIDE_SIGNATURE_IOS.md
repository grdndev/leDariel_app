# 🔐 Guide de Signature iOS - Générer l'IPA

## 📋 Étapes pour configurer la signature iOS

Xcode devrait maintenant être ouvert avec votre projet. Suivez ces étapes :

### 1. Dans Xcode

1. **Sélectionner le projet** :
   - Dans le panneau de gauche (Navigator), cliquez sur **"Runner"** (le projet bleu en haut)
   
2. **Sélectionner la cible** :
   - Sous **"TARGETS"**, sélectionnez **"Runner"**
   
3. **Aller dans l'onglet Signing** :
   - Cliquez sur l'onglet **"Signing & Capabilities"** en haut

### 2. Configurer la signature automatique

1. **Cocher "Automatically manage signing"** ✅
   - Cette case doit être cochée

2. **Sélectionner un Team** :
   - Dans le menu déroulant **"Team"**, sélectionnez votre Apple ID
   - Si votre Apple ID n'apparaît pas :
     - Cliquez sur **"Add Account..."**
     - Connectez-vous avec votre Apple ID
     - Revenez à la sélection du Team

3. **Bundle Identifier** :
   - Changez `com.example.leDariel` en quelque chose d'unique
   - Exemple : `com.votrenom.ledariel` ou `com.dariel.app`
   - Xcode doit afficher une coche verte ✅ à côté du Bundle Identifier

### 3. Vérifier la configuration

Vous devriez voir :
- ✅ "Automatically manage signing" : **coché**
- ✅ Team : **votre Apple ID sélectionné**
- ✅ Bundle Identifier : **coche verte**
- ✅ Provisioning Profile : **créé automatiquement**

### 4. Générer l'IPA

Une fois la signature configurée dans Xcode :

```bash
cd /Users/jayance/Desktop/Le_DARIEL
flutter build ipa --release
```

Le fichier IPA sera généré dans : `build/ios/ipa/le_dariel.ipa`

## ⚠️ Notes importantes

- **Compte Apple gratuit** : Vous pouvez signer avec un compte Apple gratuit (pas besoin d'un compte développeur payant pour tester)
- **Bundle ID unique** : Assurez-vous que le Bundle Identifier est unique (pas déjà utilisé par une autre app)
- **Première fois** : À la première configuration, Xcode peut mettre quelques secondes à créer les certificats

## 🎯 Problèmes courants

### "No signing certificate found"
→ Vérifiez que vous avez bien sélectionné un Team dans Xcode

### "Bundle ID already exists"
→ Changez le Bundle Identifier pour quelque chose d'unique

### "Automatic signing is disabled"
→ Cochez la case "Automatically manage signing"

---

Une fois la signature configurée, vous pouvez générer l'IPA avec la commande Flutter !

