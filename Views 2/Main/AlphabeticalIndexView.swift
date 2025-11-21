//
//  AlphabeticalIndexView.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct AlphabeticalIndexView: View {
    @ObservedObject var accessService: AcronymAccessService
    @State private var selectedLetter: String?
    
    let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map { String($0) }
    
    var accessibleAcronyms: [Acronym] {
        accessService.getAccessibleAcronyms()
    }
    
    var groupedAcronyms: [String: [Acronym]] {
        Dictionary(grouping: accessibleAcronyms) { acronym in
            String(acronym.letters.prefix(1).uppercased())
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                DARIELTheme.secondaryColor.ignoresSafeArea()
                
                ScrollViewReader { proxy in
                    HStack(spacing: 0) {
                        // Liste principale
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 20) {
                                ForEach(alphabet, id: \.self) { letter in
                                    if let acronyms = groupedAcronyms[letter], !acronyms.isEmpty {
                                        Section(header: LetterHeader(letter: letter)) {
                                            ForEach(acronyms) { acronym in
                                                NavigationLink(destination: AcronymDetailView(acronym: acronym, accessService: accessService)) {
                                                    AcronymCardDARIEL(acronym: acronym)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                            }
                                        }
                                        .id(letter)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                        }
                        
                        // Index latéral A-Z
                        VStack(spacing: 4) {
                            ForEach(alphabet, id: \.self) { letter in
                                Button(action: {
                                    withAnimation {
                                        proxy.scrollTo(letter, anchor: .top)
                                    }
                                }) {
                                    Text(letter)
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(
                                            groupedAcronyms[letter] != nil && !groupedAcronyms[letter]!.isEmpty
                                                ? DARIELTheme.accentRed
                                                : .gray.opacity(0.5)
                                        )
                                        .frame(width: 20, height: 20)
                                }
                                .disabled(groupedAcronyms[letter] == nil || groupedAcronyms[letter]!.isEmpty)
                            }
                        }
                        .padding(.trailing, 8)
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Index A-Z")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct LetterHeader: View {
    let letter: String
    
    var body: some View {
        HStack {
            Text(letter)
                .font(DARIELTheme.titleFont(size: 32))
                .foregroundColor(DARIELTheme.accentRed)
            Rectangle()
                .fill(DARIELTheme.accentRed.opacity(0.3))
                .frame(height: 2)
        }
        .padding(.vertical, 8)
    }
}

