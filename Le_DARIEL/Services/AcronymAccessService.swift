//
//  AcronymAccessService.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import Foundation

class AcronymAccessService: ObservableObject {
    let authService: AuthService
    let acronymManager: AcronymManager
    
    init(authService: AuthService, acronymManager: AcronymManager) {
        self.authService = authService
        self.acronymManager = acronymManager
    }
    
    // MARK: - Access Control
    
    func getAccessibleAcronyms() -> [Acronym] {
        guard let user = authService.currentUser else {
            return []
        }
        
        if user.canAccessAllAcronyms {
            return acronymManager.acronyms
        } else {
            // Utilisateur gratuit : limiter à 20 acronymes
            return Array(acronymManager.acronyms.prefix(20))
        }
    }
    
    func canAccessAcronym(_ acronym: Acronym) -> Bool {
        guard let user = authService.currentUser else {
            return false
        }
        
        if user.canAccessAllAcronyms {
            return true
        } else {
            // Vérifier si l'acronyme fait partie des 20 premiers
            let accessibleAcronyms = getAccessibleAcronyms()
            return accessibleAcronyms.contains { $0.id == acronym.id }
        }
    }
    
    func getLockedAcronymsCount() -> Int {
        guard let user = authService.currentUser else {
            return acronymManager.acronyms.count
        }
        
        if user.canAccessAllAcronyms {
            return 0
        } else {
            return max(0, acronymManager.acronyms.count - 20)
        }
    }
    
    func searchAccessibleAcronyms(query: String) -> [Acronym] {
        let accessibleAcronyms = getAccessibleAcronyms()
        
        guard !query.isEmpty else {
            return accessibleAcronyms
        }
        
        return accessibleAcronyms.filter {
            $0.letters.localizedCaseInsensitiveContains(query) ||
            $0.fullForm.localizedCaseInsensitiveContains(query)
        }
    }
    
    func getSuggestions(for query: String) -> [String] {
        let accessibleAcronyms = getAccessibleAcronyms()
        let matchingAcronyms = accessibleAcronyms.filter {
            $0.letters.localizedCaseInsensitiveContains(query)
        }
        return matchingAcronyms.map { $0.letters }
    }
}

