import SwiftUI

struct ContentView: View {
    @State private var showingProfile = false
    
    @State var appUser: AppUser?
    
    var body: some View {
        ZStack {
            MapView()
            HStack {
                Spacer()
                VStack {
                    if #available(iOS 16, *) {
                        Button() {
                            showingProfile.toggle()
                        } label: {
                            Label("profile", systemImage: "person.crop.circle")
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.all, 15)
                        .sheet(isPresented: $showingProfile) {
                            ZStack {
                                if let _ = appUser {
                                    ProfileView(appUser: $appUser)
                                } else {
                                    SignInView(appUser: $appUser)
                                }
                            }
                            .presentationDragIndicator(.visible)
                            .onAppear {
                                Task {
                                    self.appUser = try await AuthManager.shared.getCurrentSession()
                                }
                            }
                        }
                    } else {
                        Button() {
                            showingProfile.toggle()
                        } label: {
                            Label("profile", systemImage: "person.crop.circle")
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.all, 15)
                        .sheet(isPresented: $showingProfile) {
                            ZStack {
                                if let _ = appUser {
                                    ProfileView(appUser: $appUser)
                                } else {
                                    SignInView(appUser: $appUser)
                                }
                            }
                            .onAppear {
                                Task {
                                    self.appUser = try await AuthManager.shared.getCurrentSession()
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(appUser: nil)
                .environment(\.locale, Locale.init(identifier: "en"))
                .previewDisplayName("en")
            
            ContentView(appUser: nil)
                .environment(\.locale, Locale.init(identifier: "ru"))
                .previewDisplayName("ru")
        }
    }
}
