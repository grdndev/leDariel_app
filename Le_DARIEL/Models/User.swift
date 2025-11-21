//
//  User.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import Foundation

enum UserType: String, Codable {
    case utilisateur1 = "u1"  // Gratuit - 20 acronymes
    case utilisateur2 = "u2"  // Payant - Illimité
    case administrateur = "admin"  // Accès complet
}

struct User: Identifiable, Codable {
    let id: UUID
    var email: String
    var passwordHash: String
    var userType: UserType
    var createdAt: Date
    var lastLogin: Date?
    
    init(id: UUID = UUID(), email: String, passwordHash: String, userType: UserType, createdAt: Date = Date(), lastLogin: Date? = nil) {
        self.id = id
        self.email = email
        self.passwordHash = passwordHash
        self.userType = userType
        self.createdAt = createdAt
        self.lastLogin = lastLogin
    }
    
    var canAccessAllAcronyms: Bool {
        return userType == .utilisateur2 || userType == .administrateur
    }
    
    var maxAcronymsAllowed: Int {
        switch userType {
        case .utilisateur1:
            return 20
        case .utilisateur2, .administrateur:
            return Int.max
        }
    }
}





