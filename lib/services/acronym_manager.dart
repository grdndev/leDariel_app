import 'package:flutter/foundation.dart';
import 'package:le_dariel/models/acronym.dart';
import 'package:uuid/uuid.dart';

class AcronymManager extends ChangeNotifier {
  final List<Acronym> _acronyms = [];
  TriAcronyme _triActuel = TriAcronyme.aucun;
  
  List<Acronym> get acronyms => List.unmodifiable(_acronyms);
  TriAcronyme get triActuel => _triActuel;

  AcronymManager() {
    _loadDefaultAcronyms();
  }

  void trierAcronymes(TriAcronyme tri) {
    _triActuel = tri;
    switch (tri) {
      case TriAcronyme.alphabetique:
        _acronyms.sort((a, b) => a.letters.compareTo(b.letters));
      case TriAcronyme.categorie:
        _acronyms.sort((a, b) => a.category.label.compareTo(b.category.label));
      case TriAcronyme.aucun:
        _loadDefaultAcronyms();
    }
    notifyListeners();
  }

  void _loadDefaultAcronyms() {
    _acronyms.clear();
    final uuid = const Uuid();
    
    // Charger les acronymes de base
    _acronyms.addAll([
      Acronym(
        id: uuid.v4(),
        letters: "ABAISSEMENT",
        fullForm: "(la chute de l'esprit d'élévation) Acte de Brisement de l'Arrogance d'une Image de Soi Surfaite et d'une Estime Mauvaise qui Exigent Nécessairement de Tomber. (Jb.14.21 ; Ec.10.6 ; Ez.17.14)",
        examples: ["Jb.14.21 : Ses fils connaissent-ils la gloire ? Il n'en sait rien. Sont-ils dans l'abaissement ? Il ne s'en aperçoit pas."],
        category: AcronymCategory.nomMasculin,
      ),
      Acronym(
        id: uuid.v4(),
        letters: "ABAISSER",
        fullForm: "(diminuer de sa hauteur) 1. Amener vers le Bas une Ame Imbue de Soi et qui Socialement s'Estime quant à son Rang. 2. Accepter de Baisser en Altitude quant à son Importance Sociale et Spirituellement dans un Esprit de Renoncement. (1 Sa.2.7 ; Jb.40.11 ; Pv.29.23 ; Es.2.11 ; Da.4.37 ; Mt.11.23 ; Lc.18.14 ; Ac.10.11 ; 2 Co.11.7 ; Hb.2.9)",
        examples: ["1 Sa.2.7 :  C'est le Seigneur qui rend pauvre ou riche, c'est lui qui abaisse et qui élève."],
        category: AcronymCategory.verbeTransitif,
      ),
      Acronym(
        id: uuid.v4(),
        letters: "ABANDON",
        fullForm: "(le rejet de la foi) Acte Blâmable d'Apostasie par la Négation de la Doctrine Orthodoxe de Naissance (nouvelle). (1 Ti.1.19 ; 4.1 ; 6.20-21 ; 2 Ti.1.12-14 ; 3.14-15 ; 4.10)",
        examples: ["1 Ti.4.1 : Mais l'Esprit dit expressément que, dans les derniers temps, quelques-uns abandonneront la foi, pour s'attacher à des esprits séducteurs et à des doctrines de démons,.."],
        category: AcronymCategory.nomMasculin,
      ),
      // Ajouter plus d'acronymes selon les besoins
      // Pour l'instant, j'ajoute quelques exemples représentatifs
    ]);
  }

  void addAcronym(Acronym acronym) {
    _acronyms.add(acronym);
    notifyListeners();
  }

  void updateAcronym(Acronym updatedAcronym) {
    final index = _acronyms.indexWhere((a) => a.id == updatedAcronym.id);
    if (index != -1) {
      _acronyms[index] = updatedAcronym;
      notifyListeners();
    }
  }

  void deleteAcronym(String id) {
    _acronyms.removeWhere((a) => a.id == id);
    notifyListeners();
  }
}

