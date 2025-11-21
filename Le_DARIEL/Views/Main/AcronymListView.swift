//
//  AcronymListView.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct AcronymListView: View {
    @ObservedObject var accessService: AcronymAccessService
    @ObservedObject var acronymManager: AcronymManager
    @State private var searchText = ""
    @State private var suggestions: [String] = []
    @State private var showUpgradeAlert = false
    
    var filteredAcronyms: [Acronym] {
        accessService.searchAccessibleAcronyms(query: searchText)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                DARIELTheme.secondaryColor.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Barre de recherche avec suggestions
                    VStack(spacing: 0) {
                        SearchBarWithSuggestions(
                            text: $searchText,
                            suggestions: $suggestions,
                            onSearch: { query in
                                suggestions = accessService.getSuggestions(for: query)
                            }
                        )
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        
                        // Afficher les suggestions
                        if !suggestions.isEmpty && !searchText.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(suggestions, id: \.self) { suggestion in
                                        Button(action: {
                                            searchText = suggestion
                                            suggestions = []
                                        }) {
                                            Text(suggestion)
                                                .font(DARIELTheme.captionFont())
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(DARIELTheme.primaryColor.opacity(0.1))
                                                .foregroundColor(DARIELTheme.primaryColor)
                                                .cornerRadius(20)
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                            .padding(.bottom, 8)
                        }
                    }
                    .background(DARIELTheme.secondaryColor)
                    
                    // Liste des acronymes
                    if filteredAcronyms.isEmpty {
                        VStack(spacing: 20) {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 60))
                                .foregroundColor(.gray.opacity(0.5))
                            Text("Aucun résultat trouvé")
                                .font(DARIELTheme.subtitleFont())
                                .foregroundColor(.gray)
                            Text("Essayez avec d'autres mots-clés")
                                .font(DARIELTheme.captionFont())
                                .foregroundColor(.gray.opacity(0.7))
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(filteredAcronyms) { acronym in
                                    NavigationLink(destination: AcronymDetailView(acronym: acronym, accessService: accessService)) {
                                        AcronymCardDARIEL(acronym: acronym)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                                // Afficher un message pour les utilisateurs gratuits
                                if accessService.authService.currentUser?.userType == .utilisateur1 {
                                    UpgradePromptCard(showUpgradeAlert: $showUpgradeAlert)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                        }
                    }
                }
            }
            .navigationTitle("Le DARIEL")
            .navigationBarTitleDisplayMode(.large)
            .alert("Passer à la version premium", isPresented: $showUpgradeAlert) {
                Button("Annuler", role: .cancel) { }
                Button("En savoir plus") {
                    // TODO: Naviguer vers la page d'upgrade
                }
            } message: {
                Text("Débloquez l'accès à tous les acronymes et fonctionnalités premium !")
            }
        }
        .onChange(of: searchText) { newValue in
            if !newValue.isEmpty {
                suggestions = accessService.getSuggestions(for: newValue)
            } else {
                suggestions = []
            }
        }
    }
}





