//
//  AdminView.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct AdminView: View {
    @ObservedObject var authService: AuthService
    @ObservedObject var acronymManager: AcronymManager
    @State private var selectedTab = 0
    @State private var stats = AdminStats()
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                // Statistiques
                AdminStatsView(stats: $stats)
                    .tabItem {
                        Label("Statistiques", systemImage: "chart.bar.fill")
                    }
                    .tag(0)
                
                // Gestion des acronymes
                AdminAcronymsView(acronymManager: acronymManager)
                    .tabItem {
                        Label("Acronymes", systemImage: "book.fill")
                    }
                    .tag(1)
                
                // Modération
                AdminModerationView()
                    .tabItem {
                        Label("Modération", systemImage: "checkmark.shield.fill")
                    }
                    .tag(2)
            }
            .navigationTitle("Administration")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct AdminStats {
    var totalUsers: Int = 0
    var premiumUsers: Int = 0
    var totalDonations: Int = 0
    var totalSuggestions: Int = 0
}

struct AdminStatsView: View {
    @Binding var stats: AdminStats
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Cartes de statistiques
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    StatCardAdmin(title: "Utilisateurs", value: "\(stats.totalUsers)", icon: "person.3.fill", color: .blue)
                    StatCardAdmin(title: "Premium", value: "\(stats.premiumUsers)", icon: "star.fill", color: DARIELTheme.accentRed)
                    StatCardAdmin(title: "Dons", value: "\(stats.totalDonations)", icon: "heart.fill", color: .pink)
                    StatCardAdmin(title: "Suggestions", value: "\(stats.totalSuggestions)", icon: "lightbulb.fill", color: .yellow)
                }
                .padding()
                
                // Graphiques et rapports
                VStack(alignment: .leading, spacing: 16) {
                    Text("Rapports")
                        .font(DARIELTheme.subtitleFont())
                        .padding(.horizontal)
                    
                    Button(action: {
                        // TODO: Générer un rapport
                    }) {
                        HStack {
                            Image(systemName: "doc.text.fill")
                            Text("Générer un rapport complet")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(DARIELTheme.cornerRadiusMedium)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .background(DARIELTheme.secondaryColor.ignoresSafeArea())
    }
}

struct StatCardAdmin: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(color)
            Text(value)
                .font(DARIELTheme.titleFont(size: 32))
                .foregroundColor(DARIELTheme.textPrimary)
            Text(title)
                .font(DARIELTheme.captionFont())
                .foregroundColor(DARIELTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(DARIELTheme.cornerRadiusMedium)
        .shadow(
            color: DARIELTheme.shadowSmall.color,
            radius: DARIELTheme.shadowSmall.radius,
            x: DARIELTheme.shadowSmall.x,
            y: DARIELTheme.shadowSmall.y
        )
    }
}

struct AdminAcronymsView: View {
    @ObservedObject var acronymManager: AcronymManager
    @State private var searchText = ""
    @State private var showAddAcronym = false
    
    var filteredAcronyms: [Acronym] {
        if searchText.isEmpty {
            return acronymManager.acronyms
        } else {
            return acronymManager.searchAcronyms(with: searchText)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Barre de recherche
            SearchBar(text: $searchText)
                .padding()
            
            // Liste des acronymes
            List {
                ForEach(filteredAcronyms) { acronym in
                    NavigationLink(destination: AdminAcronymEditView(acronym: acronym, acronymManager: acronymManager)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(acronym.letters)
                                .font(DARIELTheme.subtitleFont())
                                .foregroundColor(DARIELTheme.accentRed)
                            Text(acronym.fullForm)
                                .font(DARIELTheme.captionFont())
                                .lineLimit(2)
                        }
                    }
                }
                .onDelete { indexSet in
                    // TODO: Supprimer les acronymes
                }
            }
        }
        .navigationTitle("Gestion des acronymes")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showAddAcronym = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddAcronym) {
            AdminAddAcronymView(acronymManager: acronymManager)
        }
    }
}

struct AdminAcronymEditView: View {
    let acronym: Acronym
    @ObservedObject var acronymManager: AcronymManager
    @Environment(\.dismiss) var dismiss
    @State private var letters: String
    @State private var fullForm: String
    @State private var examples: [String]
    
    init(acronym: Acronym, acronymManager: AcronymManager) {
        self.acronym = acronym
        self.acronymManager = acronymManager
        _letters = State(initialValue: acronym.letters)
        _fullForm = State(initialValue: acronym.fullForm)
        _examples = State(initialValue: acronym.examples)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Détails") {
                    TextField("Lettres", text: $letters)
                    TextEditor(text: $fullForm)
                        .frame(height: 200)
                }
                
                Section("Exemples") {
                    ForEach(examples.indices, id: \.self) { index in
                        TextField("Exemple \(index + 1)", text: $examples[index])
                    }
                }
            }
            .navigationTitle("Modifier l'acronyme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sauvegarder") {
                        // TODO: Sauvegarder les modifications
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AdminAddAcronymView: View {
    @ObservedObject var acronymManager: AcronymManager
    @Environment(\.dismiss) var dismiss
    @State private var letters = ""
    @State private var fullForm = ""
    @State private var examples: [String] = [""]
    @State private var category: Acronym.Category = .nomMasculin
    
    var body: some View {
        NavigationView {
            Form {
                Section("Nouvel acronyme") {
                    TextField("Lettres", text: $letters)
                    TextEditor(text: $fullForm)
                        .frame(height: 200)
                    Picker("Catégorie", selection: $category) {
                        ForEach(Acronym.Category.allCases, id: \.self) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }
                }
                
                Section("Exemples") {
                    ForEach(examples.indices, id: \.self) { index in
                        TextField("Exemple \(index + 1)", text: $examples[index])
                    }
                }
            }
            .navigationTitle("Ajouter un acronyme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Ajouter") {
                        let newAcronym = Acronym(
                            letters: letters,
                            fullForm: fullForm,
                            examples: examples.filter { !$0.isEmpty },
                            category: category
                        )
                        acronymManager.addAcronym(newAcronym)
                        dismiss()
                    }
                    .disabled(letters.isEmpty || fullForm.isEmpty)
                }
            }
        }
    }
}

struct AdminModerationView: View {
    var body: some View {
        List {
            Section("Signalements en attente") {
                // TODO: Afficher les signalements
                Text("Aucun signalement")
                    .foregroundColor(.gray)
            }
            
            Section("Suggestions en attente") {
                // TODO: Afficher les suggestions
                Text("Aucune suggestion")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Modération")
    }
}

