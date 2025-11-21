enum AcronymCategory {
  adjectif('Adjectif'),
  adverbe('Adverbe'),
  conjonction('Conjonction'),
  interjection('Interjection'),
  motInvariable('Mot invariable'),
  nomFeminin('Nom Féminin'),
  nomMasculin('Nom Masculin'),
  nomPropre('Nom Propre'),
  sensFigure('Sens Figuré'),
  nomMasculinetsensFigure('Nom Masculin / Sens Figuré'),
  nomFemininetsensFigure('Nom Féminin / Sens Figuré'),
  verbeTransitifetsensFigure('Verbe Transitif / Sens Figuré'),
  verbeIntransitifetsensFigure('Verbe Intransitif / Sens Figuré'),
  adjectifetsensFigure('Adjectif / Sens Figuré'),
  nomPropreetsensFigure('Nom Propre / Sens Figuré'),
  verbePronominaletsensFigure('Verbe Pronominal / Sens Figuré'),
  adjectifetparticipePresent('Adjectif / Participe Présent'),
  nomMasculinetadjectif('Nom Masculin / Adjectif'),
  verbeIntransitif('Verbe Intransitif'),
  verbePronominal('Verbe Pronominal'),
  verbeTransitif('Verbe Transitif'),
  pronomPersonnel('Pronom Personnel'),
  pronomRelatifOuIndefini('Pronom Relatif ou Indéfini');

  final String label;
  const AcronymCategory(this.label);

  static List<AcronymCategory> get all => AcronymCategory.values;
}

enum TriAcronyme {
  alphabetique,
  categorie,
  aucun,
}

class Acronym {
  final String id;
  final String letters;
  final String fullForm;
  final List<String> examples;
  final AcronymCategory category;

  Acronym({
    required this.id,
    required this.letters,
    required this.fullForm,
    required this.examples,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'letters': letters,
        'fullForm': fullForm,
        'examples': examples,
        'category': category.label,
      };

  factory Acronym.fromJson(Map<String, dynamic> json) => Acronym(
        id: json['id'] as String,
        letters: json['letters'] as String,
        fullForm: json['fullForm'] as String,
        examples: (json['examples'] as List).map((e) => e.toString()).toList(),
        category: AcronymCategory.values.firstWhere(
          (c) => c.label == json['category'],
          orElse: () => AcronymCategory.nomMasculin,
        ),
      );
}

