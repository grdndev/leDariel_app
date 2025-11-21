//
//  AcronymDetailView.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct AcronymDetailView: View {
    let acronym: Acronym
    @ObservedObject var accessService: AcronymAccessService
    @State private var fontSize: CGFloat = 16
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // En-tête avec acronyme en ROUGE
                VStack(alignment: .leading, spacing: 12) {
                    Text(acronym.letters)
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(DARIELTheme.accentRed) // Acronyme en rouge selon charte
                    
                    CategoryBadge(category: acronym.category)
                }
                .padding(.bottom, 8)
                
                Divider()
                    .background(DARIELTheme.primaryColor.opacity(0.3))
                
                // Signification avec première lettre en majuscule et rouge
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "book.fill")
                            .foregroundColor(DARIELTheme.primaryColor)
                            .font(.system(size: 18))
                        Text("Signification")
                            .font(DARIELTheme.subtitleFont())
                            .foregroundColor(DARIELTheme.textPrimary)
                    }
                    
                    Text(formatDefinition(acronym.fullForm))
                        .font(.system(size: fontSize))
                        .foregroundColor(DARIELTheme.textPrimary)
                        .lineSpacing(6)
                        .padding(.leading, 28)
                    
                    // Contrôle de taille de police
                    HStack {
                        Text("Taille du texte")
                            .font(DARIELTheme.captionFont())
                        Slider(value: $fontSize, in: 14...24)
                        Text("\(Int(fontSize))")
                            .font(DARIELTheme.captionFont())
                            .frame(width: 30)
                    }
                    .padding(.leading, 28)
                    .padding(.top, 8)
                }
                .darielCardStyle()
                
                // Exemples
                if !acronym.examples.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "text.quote")
                                .foregroundColor(DARIELTheme.primaryColor)
                                .font(.system(size: 18))
                            Text("Exemples")
                                .font(DARIELTheme.subtitleFont())
                                .foregroundColor(DARIELTheme.textPrimary)
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(acronym.examples, id: \.self) { example in
                                HStack(alignment: .top, spacing: 12) {
                                    Image(systemName: "quote.bubble.fill")
                                        .foregroundColor(DARIELTheme.primaryColor.opacity(0.7))
                                        .font(.system(size: 14))
                                        .padding(.top, 4)
                                    
                                    Text(example)
                                        .font(.system(size: fontSize - 2))
                                        .foregroundColor(DARIELTheme.textSecondary)
                                        .italic()
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                        .padding(.leading, 28)
                    }
                    .darielCardStyle()
                }
                
                Spacer(minLength: 40)
            }
            .padding(20)
        }
        .background(DARIELTheme.secondaryColor.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Formater la définition : première lettre en majuscule et rouge
    private func formatDefinition(_ definition: String) -> AttributedString {
        var attributed = AttributedString(definition)
        
        // Première lettre en majuscule et rouge
        if let firstChar = definition.first,
           let firstCharRange = attributed.range(of: String(firstChar)) {
            attributed[firstCharRange].foregroundColor = DARIELTheme.accentRed
            attributed[firstCharRange].font = .system(size: fontSize + 2, weight: .bold)
        }
        
        return attributed
    }
}

