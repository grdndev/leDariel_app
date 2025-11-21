//
//  DARIELTheme.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct DARIELTheme {
    // Couleurs principales selon la charte graphique
    static let accentRed = Color(red: 0.8, green: 0.1, blue: 0.1) // Rouge pour les acronymes
    static let primaryColor = Color(red: 0.4, green: 0.3, blue: 0.7) // Indigo
    static let secondaryColor = Color(red: 0.98, green: 0.96, blue: 1.0) // Fond clair
    static let cardBackground = Color.white
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
    
    // Dégradés
    static let gradientBackground = LinearGradient(
        colors: [Color(red: 0.4, green: 0.3, blue: 0.7), Color(red: 0.9, green: 0.4, blue: 0.6)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Polices avec taille ajustable
    static func titleFont(size: CGFloat = 28) -> Font {
        .system(size: size, weight: .bold, design: .rounded)
    }
    
    static func subtitleFont(size: CGFloat = 20) -> Font {
        .system(size: size, weight: .semibold, design: .rounded)
    }
    
    static func bodyFont(size: CGFloat = 16) -> Font {
        .system(size: size, weight: .regular, design: .default)
    }
    
    static func captionFont(size: CGFloat = 14) -> Font {
        .system(size: size, weight: .medium, design: .default)
    }
    
    // Espacements
    static let spacingSmall: CGFloat = 8
    static let spacingMedium: CGFloat = 16
    static let spacingLarge: CGFloat = 24
    
    // Rayons de coins
    static let cornerRadiusSmall: CGFloat = 12
    static let cornerRadiusMedium: CGFloat = 16
    static let cornerRadiusLarge: CGFloat = 24
    
    // Ombres
    static let shadowSmall = Shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    static let shadowMedium = Shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    
    struct Shadow {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
    }
}

// MARK: - View Extensions pour le style DARIEL

extension View {
    func darielCardStyle() -> some View {
        self
            .padding(DARIELTheme.spacingMedium)
            .background(DARIELTheme.cardBackground)
            .cornerRadius(DARIELTheme.cornerRadiusMedium)
            .shadow(
                color: DARIELTheme.shadowMedium.color,
                radius: DARIELTheme.shadowMedium.radius,
                x: DARIELTheme.shadowMedium.x,
                y: DARIELTheme.shadowMedium.y
            )
    }
    
    func darielAcronymStyle() -> some View {
        self
            .foregroundColor(DARIELTheme.accentRed)
            .font(DARIELTheme.titleFont())
    }
}

// MARK: - Helper pour formater la définition selon la charte
extension String {
    func formattedDefinition() -> AttributedString {
        var attributed = AttributedString(self)
        
        // Première lettre en majuscule et rouge
        if let firstChar = self.first,
           let firstCharRange = attributed.range(of: String(firstChar)) {
            attributed[firstCharRange].foregroundColor = DARIELTheme.accentRed
            attributed[firstCharRange].font = .system(size: 18, weight: .bold)
        }
        
        return attributed
    }
}





