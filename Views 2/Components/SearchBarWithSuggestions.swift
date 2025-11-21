//
//  SearchBarWithSuggestions.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct SearchBarWithSuggestions: View {
    @Binding var text: String
    @Binding var suggestions: [String]
    var onSearch: (String) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(DARIELTheme.primaryColor)
                .font(.system(size: 18, weight: .medium))
            
            TextField("Rechercher un acronyme...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .font(DARIELTheme.bodyFont())
                .foregroundColor(DARIELTheme.textPrimary)
                .onChange(of: text) { newValue in
                    onSearch(newValue)
                }
            
            if !text.isEmpty {
                Button(action: {
                    withAnimation(.spring(response: 0.3)) {
                        text = ""
                        suggestions = []
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray.opacity(0.6))
                        .font(.system(size: 20))
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
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

