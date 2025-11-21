//
//  Acronym.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import Foundation

struct Acronym: Identifiable, Codable {
    let id: UUID
    var letters: String
    var fullForm: String
    var examples: [String]
    var category: Category
    
    enum Category: String, Codable, CaseIterable {
        case adjectif = "Adjectif"
        case adverbe = "Adverbe"
        case conjonction = "Conjonction"
        case interjection = "Interjection"
        case motInvariable = "Mot invariable"
        case nomFeminin = "Nom Féminin"
        case nomMasculin = "Nom Masculin"
        case nomPropre = "Nom Propre"
        case sensFigure = "Sens Figuré"
        case nomMasculinetsensFigure = "Nom Masculin / Sens Figuré"
        case nomFemininetsensFigure = "Nom Féminin / Sens Figuré"
        case verbeTransitifetsensFigure = "Verbe Transitif / Sens Figuré"
        case verbeIntransitifetsensFigure = "Verbe Intransitif / Sens Figuré"
        case adjectifetsensFigure = "Adjectif / Sens Figuré"
        case nomPropreetsensFigure = "Nom Propre / Sens Figuré"
        case verbePronominaletsensFigure = "Verbe Pronominal / Sens Figuré"
        case AdjectifetparticipePresent = "Adjectif / Participe Présent"
        case nomMasculinetadjectif = "Nom Masculin / Adjectif"
        case verbeIntransitif = "Verbe Intransitif"
        case verbePronominal = "Verbe Pronominal"
        case verbeTransitif = "Verbe Transitif"
        case pronomPersonnel = "Pronom Personnel"
        case pronomRelatifOuIndéfini = "Pronom Relatif ou Indéfini"
    }
    
    init(id: UUID = UUID(), letters: String, fullForm: String, examples: [String], category: Category = .nomMasculin) {
        self.id = id
        self.letters = letters
        self.fullForm = fullForm
        self.examples = examples
        self.category = category
    }
}

enum TriAcronyme {
    case alphabetique
    case categorie
    case aucun
}





