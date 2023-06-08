import SwiftUI 

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    
    @State private var email = ""
    @State private var password = ""
    @State private var isPresented = false
    
    @Binding var appUser: AppUser?

    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                AppTextField(placeHolder: "email", text: $email)
                
                AppSecureField(placeHolder: "password", text: $password)
            }
            .padding(.horizontal, 24)
            
            Button("new-user") {
                isPresented.toggle()
            }
            .sheet(isPresented: $isPresented) {
                if #available(iOS 16, *) {
                    RegistrationView(appUser: $appUser)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                        .environmentObject(viewModel)
                } else {
                    RegistrationView(appUser: $appUser)
                        .environmentObject(viewModel)
                }
            }
            
            Button {
                Task {
                    do {
                        let appUser = try await viewModel.signInWithEmail(email: email, password: password)
                        self.appUser = appUser
                    } catch {
                        print("issue with sign in")
                    }
                }
            } label: {
                Text("sign-in")
                    .padding()
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundColor(Color(uiColor: .label))
                    }
                    .padding(.horizontal, 24)
            }

            
            VStack {
                Button {
                    Task {
                        do {
                            let appUser = try await viewModel.signInWithApple()
                            self.appUser = appUser
                        } catch {
                            print("error signing in")
                        }
                    }
                } label: {
                    Text("sign-in-apple")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(uiColor: .label), lineWidth: 1)
                        }
                }
                
                Button {
                    Task {
                        do {
                            let appUser = try await viewModel.signInWithGoogle()
                            self.appUser = appUser
                        } catch {
                            print("error signing in")
                        }
                    }
                } label: {
                    Text("sign-in-google")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(uiColor: .label), lineWidth: 1)
                        }
                }
            }
            .padding(.top)
            .padding(.horizontal, 24)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignInView(appUser: .constant(.init(uuid: "1234", email: nil)))
                .environment(\.locale, Locale.init(identifier: "en"))
                .previewDisplayName("en")
            
            SignInView(appUser: .constant(.init(uuid: "1234", email: nil)))
                .environment(\.locale, Locale.init(identifier: "ru"))
                .previewDisplayName("ru")
        }
    }
}
