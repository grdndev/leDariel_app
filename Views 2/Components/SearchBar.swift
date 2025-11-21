//
//  SearchBar.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = "Rechercher un acronyme..."
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppTheme.primaryColor)
                .font(.system(size: 18, weight: .medium))
            
            TextField(placeholder, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.textPrimary)
            
            if !text.isEmpty {
                Button(action: { 
                    withAnimation(.spring(response: 0.3)) {
                        text = ""
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
        .cornerRadius(AppTheme.cornerRadiusMedium)
        .shadow(
            color: AppTheme.shadowSmall.color,
            radius: AppTheme.shadowSmall.radius,
            x: AppTheme.shadowSmall.x,
            y: AppTheme.shadowSmall.y
        )
    }
}


