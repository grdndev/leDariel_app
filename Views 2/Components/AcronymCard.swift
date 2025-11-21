//
//  AcronymCard.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct AcronymCard: View {
    let acronym: Acronym
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // En-tête avec acronyme et catégorie
            HStack(alignment: .top) {
                Text(acronym.letters)
                    .font(AppTheme.titleFont)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                CategoryBadge(category: acronym.category)
            }
            
            // Forme complète
            Text(acronym.fullForm)
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            // Exemple avec icône
            if !acronym.examples.isEmpty {
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "text.quote")
                        .foregroundColor(AppTheme.accentColor)
                        .font(.system(size: 16, weight: .medium))
                        .padding(.top, 2)
                    
                    Text(acronym.examples[0])
                        .font(AppTheme.captionFont)
                        .foregroundColor(AppTheme.textSecondary)
                        .lineLimit(2)
                        .italic()
                }
            }
        }
        .cardStyle()
    }
}


