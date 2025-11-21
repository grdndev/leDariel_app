//
//  SignUpView.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var authService: AuthService
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                DARIELTheme.gradientBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Logo
                        Image("ledariel-icone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.top, 40)
                        
                        Text("Créer un compte")
                            .font(DARIELTheme.titleFont(size: 32))
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        
                        // Formulaire
                        VStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email")
                                    .font(DARIELTheme.captionFont())
                                    .foregroundColor(.white.opacity(0.9))
                                
                                TextField("votre@email.com", text: $email)
                                    .textFieldStyle(.plain)
                                    .padding()
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(DARIELTheme.cornerRadiusMedium)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Mot de passe")
                                    .font(DARIELTheme.captionFont())
                                    .foregroundColor(.white.opacity(0.9))
                                
                                SecureField("••••••••", text: $password)
                                    .textFieldStyle(.plain)
                                    .padding()
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(DARIELTheme.cornerRadiusMedium)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Confirmer le mot de passe")
                                    .font(DARIELTheme.captionFont())
                                    .foregroundColor(.white.opacity(0.9))
                                
                                SecureField("••••••••", text: $confirmPassword)
                                    .textFieldStyle(.plain)
                                    .padding()
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(DARIELTheme.cornerRadiusMedium)
                            }
                            
                            // Info sur l'offre gratuite
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "info.circle.fill")
                                        .foregroundColor(.white.opacity(0.8))
                                    Text("Offre découverte : 20 acronymes gratuits")
                                        .font(DARIELTheme.captionFont())
                                        .foregroundColor(.white.opacity(0.9))
                                }
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(DARIELTheme.cornerRadiusSmall)
                            }
                            
                            Button(action: {
                                Task {
                                    await signUp()
                                }
                            }) {
                                HStack {
                                    if authService.isLoading {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    } else {
                                        Text("Créer mon compte")
                                            .font(DARIELTheme.subtitleFont())
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(DARIELTheme.accentRed)
                                .foregroundColor(.white)
                                .cornerRadius(DARIELTheme.cornerRadiusMedium)
                                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                            }
                            .disabled(authService.isLoading || !isFormValid)
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Annuler") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
            .alert("Erreur", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private var isFormValid: Bool {
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        password.count >= 6 &&
        email.contains("@")
    }
    
    private func signUp() async {
        guard password == confirmPassword else {
            await MainActor.run {
                errorMessage = "Les mots de passe ne correspondent pas"
                showError = true
            }
            return
        }
        
        do {
            try await authService.signUp(email: email, password: password, userType: .utilisateur1)
            await MainActor.run {
                dismiss()
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
}





