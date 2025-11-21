//
//  AuthService.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import Foundation
import SwiftUI
import CryptoKit

class AuthService: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let userDefaults = UserDefaults.standard
    private let userKey = "currentUser"
    
    init() {
        loadCurrentUser()
    }
    
    // MARK: - Authentication
    
    func signUp(email: String, password: String, userType: UserType = .utilisateur1) async throws {
        isLoading = true
        defer { isLoading = false }
        
        // Vérifier si l'email existe déjà
        if await emailExists(email) {
            throw AuthError.emailAlreadyExists
        }
        
        // Créer le hash du mot de passe
        let passwordHash = hashPassword(password)
        
        // Créer l'utilisateur
        let user = User(
            email: email,
            passwordHash: passwordHash,
            userType: userType
        )
        
        // Sauvegarder l'utilisateur (dans un vrai projet, ce serait dans une base de données)
        try await saveUser(user)
        
        // Connecter l'utilisateur
        await MainActor.run {
            self.currentUser = user
            self.isAuthenticated = true
            saveCurrentUser()
        }
    }
    
    func signIn(email: String, password: String) async throws {
        isLoading = true
        defer { isLoading = false }
        
        // Récupérer l'utilisateur
        guard let user = await getUser(email: email) else {
            throw AuthError.userNotFound
        }
        
        // Vérifier le mot de passe
        let passwordHash = hashPassword(password)
        guard user.passwordHash == passwordHash else {
            throw AuthError.invalidPassword
        }
        
        // Mettre à jour la dernière connexion
        var updatedUser = user
        updatedUser.lastLogin = Date()
        try await saveUser(updatedUser)
        
        // Connecter l'utilisateur
        await MainActor.run {
            self.currentUser = updatedUser
            self.isAuthenticated = true
            saveCurrentUser()
        }
    }
    
    func signOut() {
        currentUser = nil
        isAuthenticated = false
        userDefaults.removeObject(forKey: userKey)
    }
    
    // MARK: - Password Management
    
    func resetPassword(email: String) async throws {
        // Dans un vrai projet, envoyer un email de réinitialisation
        // Pour l'instant, on simule
        guard await emailExists(email) else {
            throw AuthError.userNotFound
        }
        // TODO: Implémenter l'envoi d'email
    }
    
    // MARK: - User Management
    
    func upgradeToPremium() async throws {
        guard var user = currentUser else {
            throw AuthError.notAuthenticated
        }
        
        user.userType = .utilisateur2
        try await saveUser(user)
        
        await MainActor.run {
            self.currentUser = user
            saveCurrentUser()
        }
    }
    
    // MARK: - Private Helpers
    
    private func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    private func emailExists(_ email: String) async -> Bool {
        // Dans un vrai projet, vérifier dans la base de données
        // Pour l'instant, on simule avec UserDefaults
        let users = loadAllUsers()
        return users.contains { $0.email.lowercased() == email.lowercased() }
    }
    
    private func getUser(email: String) async -> User? {
        let users = loadAllUsers()
        return users.first { $0.email.lowercased() == email.lowercased() }
    }
    
    private func saveUser(_ user: User) async throws {
        var users = loadAllUsers()
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index] = user
        } else {
            users.append(user)
        }
        saveAllUsers(users)
    }
    
    private func loadAllUsers() -> [User] {
        guard let data = userDefaults.data(forKey: "allUsers"),
              let users = try? JSONDecoder().decode([User].self, from: data) else {
            return []
        }
        return users
    }
    
    private func saveAllUsers(_ users: [User]) {
        if let data = try? JSONEncoder().encode(users) {
            userDefaults.set(data, forKey: "allUsers")
        }
    }
    
    private func loadCurrentUser() {
        guard let data = userDefaults.data(forKey: userKey),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            return
        }
        currentUser = user
        isAuthenticated = true
    }
    
    private func saveCurrentUser() {
        if let user = currentUser,
           let data = try? JSONEncoder().encode(user) {
            userDefaults.set(data, forKey: userKey)
        }
    }
}

// MARK: - Auth Errors

enum AuthError: LocalizedError {
    case emailAlreadyExists
    case userNotFound
    case invalidPassword
    case notAuthenticated
    case invalidEmail
    
    var errorDescription: String? {
        switch self {
        case .emailAlreadyExists:
            return "Cet email est déjà utilisé"
        case .userNotFound:
            return "Utilisateur non trouvé"
        case .invalidPassword:
            return "Mot de passe incorrect"
        case .notAuthenticated:
            return "Vous n'êtes pas connecté"
        case .invalidEmail:
            return "Email invalide"
        }
    }
}





