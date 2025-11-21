//
//  AccueilView.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct AccueilView: View {
    @State private var showContent = false
    @State private var scale: CGFloat = 0.5
    @State private var rotation: Double = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fond dégradé moderne
                AppTheme.gradientBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Icône de l'application avec animation
                    Image("ledariel-icone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .shadow(
                            color: .black.opacity(0.3),
                            radius: 20,
                            x: 0,
                            y: 10
                        )
                        .scaleEffect(showContent ? 1 : scale)
                        .opacity(showContent ? 1 : 0)
                        .rotationEffect(.degrees(showContent ? 0 : rotation))
                    
                    // Nom de l'application
                    Text("Le DARIEL")
                        .font(AppTheme.largeTitleFont)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 20)
                    
                    // Slogan
                    Text("L'étude biblique à portée de main")
                        .font(AppTheme.subtitleFont)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 20)
                    
                    Spacer()
                    
                    // Bouton de navigation
                    NavigationLink(destination: AcronymListView()) {
                        HStack {
                            Text("Commencer")
                                .font(AppTheme.subtitleFont)
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 20))
                        }
                        .foregroundColor(AppTheme.primaryColor)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(AppTheme.cornerRadiusLarge)
                        .shadow(
                            color: .black.opacity(0.2),
                            radius: 15,
                            x: 0,
                            y: 8
                        )
                    }
                    .padding(.horizontal, 30)
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
                    .scaleEffect(showContent ? 1 : 0.8)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
            .onAppear {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                    showContent = true
                    scale = 1
                    rotation = 360
                }
            }
        }
    }
}


