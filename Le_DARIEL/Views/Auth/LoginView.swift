//
//  LoginView.swift
//  Le_DARIEL
//
//  Created by FAEI971 on 23/07/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var authService = AuthService()
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showSignUp = false
    
    var body: some View {
        NavigationView {
            ZStack {
                DARIELTheme.gradientBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Spacer()
                    
                    // Logo et titre
                    VStack(spacing: 16) {
                        Image("ledariel-icone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8)
                        
                        Text("Le DARIEL")
                            .font(DARIELTheme.titleFont(size: 36))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    
                    Spacer()
                    
                    // Formulaire de connexion
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
                        
                        Button(action: {
                            Task {
                                await signIn()
                            }
                        }) {
                            HStack {
                                if authService.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                } else {
                                    Text("Se connecter")
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
                        .disabled(authService.isLoading || email.isEmpty || password.isEmpty)
                        
                        Button(action: {
                            showSignUp = true
                        }) {
                            Text("Créer un compte")
                                .font(DARIELTheme.bodyFont())
                                .foregroundColor(.white)
                                .underline()
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .alert("Erreur", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .sheet(isPresented: $showSignUp) {
                SignUpView(authService: authService)
            }
        }
    }
    
    private func signIn() async {
        do {
            try await authService.signIn(email: email, password: password)
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
}





