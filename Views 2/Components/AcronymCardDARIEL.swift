//
//  AcronymCardDARIEL.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct AcronymCardDARIEL: View {
    let acronym: Acronym
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // En-tête avec acronyme en ROUGE (selon charte graphique)
            HStack(alignment: .top) {
                Text(acronym.letters)
                    .font(DARIELTheme.titleFont())
                    .foregroundColor(DARIELTheme.accentRed) // Acronyme en rouge
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                CategoryBadge(category: acronym.category)
            }
            
            // Forme complète avec première lettre en majuscule et rouge
            Text(formatDefinition(acronym.fullForm))
                .font(DARIELTheme.bodyFont())
                .foregroundColor(DARIELTheme.textPrimary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            // Exemple avec icône
            if !acronym.examples.isEmpty {
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "text.quote")
                        .foregroundColor(DARIELTheme.primaryColor)
                        .font(.system(size: 16, weight: .medium))
                        .padding(.top, 2)
                    
                    Text(acronym.examples[0])
                        .font(DARIELTheme.captionFont())
                        .foregroundColor(DARIELTheme.textSecondary)
                        .lineLimit(2)
                        .italic()
                }
            }
        }
        .darielCardStyle()
    }
    
    // Formater la définition : première lettre en majuscule et rouge
    private func formatDefinition(_ definition: String) -> AttributedString {
        var attributed = AttributedString(definition)
        
        // Première lettre en majuscule et rouge
        if let firstChar = definition.first,
           let firstCharRange = attributed.range(of: String(firstChar)) {
            attributed[firstCharRange].foregroundColor = DARIELTheme.accentRed
            attributed[firstCharRange].font = .system(size: 18, weight: .bold)
        }
        
        return attributed
    }
}

// Carte pour inciter à l'upgrade
struct UpgradePromptCard: View {
    @Binding var showUpgradeAlert: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "lock.fill")
                .font(.system(size: 40))
                .foregroundColor(DARIELTheme.accentRed)
            
            Text("Débloquez tous les acronymes")
                .font(DARIELTheme.subtitleFont())
                .foregroundColor(DARIELTheme.textPrimary)
            
            Text("Passez à la version premium pour accéder à tous les acronymes et fonctionnalités avancées")
                .font(DARIELTheme.captionFont())
                .foregroundColor(DARIELTheme.textSecondary)
                .multilineTextAlignment(.center)
            
            Button(action: {
                showUpgradeAlert = true
            }) {
                Text("En savoir plus")
                    .font(DARIELTheme.subtitleFont())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(DARIELTheme.accentRed)
                    .cornerRadius(DARIELTheme.cornerRadiusMedium)
            }
        }
        .padding()
        .darielCardStyle()
    }
}

