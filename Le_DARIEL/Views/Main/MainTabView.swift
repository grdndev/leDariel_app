//
//  MainTabView.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var authService = AuthService()
    @StateObject private var acronymManager = AcronymManager()
    @StateObject private var accessService: AcronymAccessService
    
    @State private var selectedTab = 0
    
    init() {
        let auth = AuthService()
        let manager = AcronymManager()
        _authService = StateObject(wrappedValue: auth)
        _acronymManager = StateObject(wrappedValue: manager)
        _accessService = StateObject(wrappedValue: AcronymAccessService(authService: auth, acronymManager: manager))
    }
    
    var body: some View {
        Group {
            if authService.isAuthenticated {
                TabView(selection: $selectedTab) {
                    // Onglet Dictionnaire
                    AcronymListView(accessService: accessService, acronymManager: acronymManager)
                        .tabItem {
                            Label("Dictionnaire", systemImage: "book.fill")
                        }
                        .tag(0)
                    
                    // Onglet Index (A-Z)
                    AlphabeticalIndexView(accessService: accessService)
                        .tabItem {
                            Label("Index", systemImage: "list.bullet")
                        }
                        .tag(1)
                    
                    // Onglet Profil
                    ProfileView(authService: authService, accessService: accessService)
                        .tabItem {
                            Label("Profil", systemImage: "person.fill")
                        }
                        .tag(2)
                    
                    // Onglet Admin (seulement pour les admins)
                    if authService.currentUser?.userType == .administrateur {
                        AdminView(authService: authService, acronymManager: acronymManager)
                            .tabItem {
                                Label("Admin", systemImage: "gearshape.fill")
                            }
                            .tag(3)
                    }
                }
                .accentColor(DARIELTheme.accentRed)
            } else {
                LoginView()
            }
        }
    }
}





