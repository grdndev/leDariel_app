//
//  AcronymDetailView.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct AcronymDetailView: View {
    let acronym: Acronym
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // En-tête avec acronyme
                VStack(alignment: .leading, spacing: 12) {
                    Text(acronym.letters)
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                    
                    CategoryBadge(category: acronym.category)
                }
                .padding(.bottom, 8)
                
                Divider()
                    .background(AppTheme.primaryColor.opacity(0.3))
                
                // Signification
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "book.fill")
                            .foregroundColor(AppTheme.primaryColor)
                            .font(.system(size: 18))
                        Text("Signification")
                            .font(AppTheme.subtitleFont)
                            .foregroundColor(AppTheme.textPrimary)
                    }
                    
                    Text(acronym.fullForm)
                        .font(AppTheme.bodyFont)
                        .foregroundColor(AppTheme.textPrimary)
                        .lineSpacing(4)
                        .padding(.leading, 28)
                }
                .cardStyle()
                
                // Exemples
                if !acronym.examples.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "text.quote")
                                .foregroundColor(AppTheme.accentColor)
                                .font(.system(size: 18))
                            Text("Exemples")
                                .font(AppTheme.subtitleFont)
                                .foregroundColor(AppTheme.textPrimary)
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(acronym.examples, id: \.self) { example in
                                HStack(alignment: .top, spacing: 12) {
                                    Image(systemName: "quote.bubble.fill")
                                        .foregroundColor(AppTheme.accentColor.opacity(0.7))
                                        .font(.system(size: 14))
                                        .padding(.top, 4)
                                    
                                    Text(example)
                                        .font(AppTheme.bodyFont)
                                        .foregroundColor(AppTheme.textSecondary)
                                        .italic()
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                        .padding(.leading, 28)
                    }
                    .cardStyle()
                }
                
                Spacer(minLength: 40)
            }
            .padding(20)
        }
        .background(AppTheme.secondaryColor.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}


