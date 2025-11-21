//
//  CategoryBadge.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct CategoryBadge: View {
    let category: Acronym.Category
    
    var body: some View {
        Text(category.rawValue)
            .font(DARIELTheme.captionFont())
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(DARIELTheme.primaryColor.opacity(0.15))
            )
            .foregroundColor(DARIELTheme.primaryColor)
    }
}


