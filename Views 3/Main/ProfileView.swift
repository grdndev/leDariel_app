//
//  ProfileView.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var authService: AuthService
    @ObservedObject var accessService: AcronymAccessService
    @State private var showBugReport = false
    @State private var showSuggestion = false
    @State private var showDonation = false
    
    var user: User? {
        authService.currentUser
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                DARIELTheme.secondaryColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // En-tête profil
                        VStack(spacing: 12) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(DARIELTheme.primaryColor)
                            
                            Text(user?.email ?? "")
                                .font(DARIELTheme.subtitleFont())
                                .foregroundColor(DARIELTheme.textPrimary)
                            
                            // Badge du type d'utilisateur
                            Text(userTypeLabel)
                                .font(DARIELTheme.captionFont())
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(userTypeColor.opacity(0.2))
                                .foregroundColor(userTypeColor)
                                .cornerRadius(20)
                        }
                        .padding(.top, 20)
                        
                        // Statistiques
                        if let user = user {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Statistiques")
                                    .font(DARIELTheme.subtitleFont())
                                    .padding(.horizontal, 16)
                                
                                HStack(spacing: 16) {
                                    StatCard(
                                        title: "Acronymes accessibles",
                                        value: "\(accessService.getAccessibleAcronyms().count)",
                                        icon: "book.fill"
                                    )
                                    
                                    if user.userType == .utilisateur1 {
                                        StatCard(
                                            title: "Acronymes verrouillés",
                                            value: "\(accessService.getLockedAcronymsCount())",
                                            icon: "lock.fill"
                                        )
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                        
                        // Actions disponibles
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Actions")
                                .font(DARIELTheme.subtitleFont())
                                .padding(.horizontal, 16)
                            
                            VStack(spacing: 12) {
                                // Signalement de bug
                                ActionButton(
                                    title: "Signaler un bug",
                                    icon: "exclamationmark.triangle.fill",
                                    color: .orange
                                ) {
                                    showBugReport = true
                                }
                                
                                // Suggestion d'acronyme (pour u2)
                                if user?.userType == .utilisateur2 || user?.userType == .administrateur {
                                    ActionButton(
                                        title: "Suggérer un acronyme",
                                        icon: "lightbulb.fill",
                                        color: .yellow
                                    ) {
                                        showSuggestion = true
                                    }
                                }
                                
                                // Don (pour u2)
                                if user?.userType == .utilisateur2 {
                                    ActionButton(
                                        title: "Faire un don",
                                        icon: "heart.fill",
                                        color: DARIELTheme.accentRed
                                    ) {
                                        showDonation = true
                                    }
                                }
                                
                                // Upgrade (pour u1)
                                if user?.userType == .utilisateur1 {
                                    ActionButton(
                                        title: "Passer à la version premium",
                                        icon: "star.fill",
                                        color: DARIELTheme.accentRed
                                    ) {
                                        // TODO: Naviguer vers upgrade
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        // Déconnexion
                        Button(action: {
                            authService.signOut()
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.square")
                                Text("Se déconnecter")
                            }
                            .font(DARIELTheme.bodyFont())
                            .foregroundColor(DARIELTheme.accentRed)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(DARIELTheme.cornerRadiusMedium)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showBugReport) {
                BugReportView()
            }
            .sheet(isPresented: $showSuggestion) {
                AcronymSuggestionView()
            }
            .sheet(isPresented: $showDonation) {
                DonationView()
            }
        }
    }
    
    private var userTypeLabel: String {
        switch user?.userType {
        case .utilisateur1:
            return "Utilisateur Gratuit"
        case .utilisateur2:
            return "Utilisateur Premium"
        case .administrateur:
            return "Administrateur"
        case .none:
            return "Non connecté"
        }
    }
    
    private var userTypeColor: Color {
        switch user?.userType {
        case .utilisateur1:
            return .blue
        case .utilisateur2:
            return DARIELTheme.accentRed
        case .administrateur:
            return .purple
        case .none:
            return .gray
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(DARIELTheme.primaryColor)
            Text(value)
                .font(DARIELTheme.titleFont(size: 24))
                .foregroundColor(DARIELTheme.textPrimary)
            Text(title)
                .font(DARIELTheme.captionFont())
                .foregroundColor(DARIELTheme.textSecondary)
                .multilineTextAlignment(.center)
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

struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(title)
                    .font(DARIELTheme.bodyFont())
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
            }
            .foregroundColor(DARIELTheme.textPrimary)
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
}

// Vues simplifiées pour les sheets
struct BugReportView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Détails du bug") {
                    TextField("Titre", text: $title)
                    TextEditor(text: $description)
                        .frame(height: 200)
                }
            }
            .navigationTitle("Signaler un bug")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Envoyer") {
                        // TODO: Envoyer le rapport
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AcronymSuggestionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var acronym = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Suggestion d'acronyme") {
                    TextField("Acronyme", text: $acronym)
                    TextEditor(text: $description)
                        .frame(height: 200)
                }
            }
            .navigationTitle("Suggérer un acronyme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Envoyer") {
                        // TODO: Envoyer la suggestion
                        dismiss()
                    }
                }
            }
        }
    }
}

struct DonationView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .foregroundColor(DARIELTheme.accentRed)
                
                Text("Faire un don")
                    .font(DARIELTheme.titleFont())
                
                Text("Votre soutien nous aide à continuer à développer et améliorer Le DARIEL")
                    .font(DARIELTheme.bodyFont())
                    .multilineTextAlignment(.center)
                    .padding()
                
                // TODO: Intégrer un système de paiement
                Button("Fermer") {
                    dismiss()
                }
            }
            .padding()
            .navigationTitle("Don")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

