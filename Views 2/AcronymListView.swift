//
//  AcronymListView.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct AcronymListView: View {
    @StateObject private var acronymManager = AcronymManager()
    @State private var searchText = ""
    @State private var showSortMenu = false
    
    var filteredAcronyms: [Acronym] {
        searchText.isEmpty ?
            acronymManager.acronyms :
            acronymManager.searchAcronyms(with: searchText)
    }
    
    var body: some View {
        ZStack {
            AppTheme.secondaryColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Barre de recherche et tri
                HStack(spacing: 12) {
                    SearchBar(text: $searchText)
                    
                    // Menu de tri
                    Menu {
                        Button(action: {
                            withAnimation {
                                acronymManager.trierAcronymes(par: .alphabetique)
                            }
                        }) {
                            Label("Alphabétique", systemImage: "textformat.abc")
                        }
                        
                        Button(action: {
                            withAnimation {
                                acronymManager.trierAcronymes(par: .categorie)
                            }
                        }) {
                            Label("Par catégorie", systemImage: "tag.fill")
                        }
                        
                        Button(action: {
                            withAnimation {
                                acronymManager.trierAcronymes(par: .aucun)
                            }
                        }) {
                            Label("Par défaut", systemImage: "arrow.counterclockwise")
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(AppTheme.primaryColor)
                            .frame(width: 50, height: 50)
                            .background(Color.white)
                            .cornerRadius(AppTheme.cornerRadiusMedium)
                            .shadow(
                                color: AppTheme.shadowSmall.color,
                                radius: AppTheme.shadowSmall.radius,
                                x: AppTheme.shadowSmall.x,
                                y: AppTheme.shadowSmall.y
                            )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(AppTheme.secondaryColor)
                
                // Liste des acronymes
                if filteredAcronyms.isEmpty {
                    VStack(spacing: 20) {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 60))
                            .foregroundColor(.gray.opacity(0.5))
                        Text("Aucun résultat trouvé")
                            .font(AppTheme.subtitleFont)
                            .foregroundColor(.gray)
                        Text("Essayez avec d'autres mots-clés")
                            .font(AppTheme.captionFont)
                            .foregroundColor(.gray.opacity(0.7))
                        Spacer()
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredAcronyms) { acronym in
                                NavigationLink(destination: AcronymDetailView(acronym: acronym)) {
                                    AcronymCard(acronym: acronym)
                                }
                                .buttonStyle(PlainButtonStyle())
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
    }
}


